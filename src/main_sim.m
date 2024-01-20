clear all;
close all;
config = load('config.mat');
data = load("20210827_Input.mat");



Ft = data.yout(:, 57);
Tp = data.yout(:, 56);
Tr = data.yout(:, 55);
Ty = data.yout(:, 64);

dt = config.sampling_time;

x_vicon = data.yout(:,44);
y_vicon = data.yout(:,45);
z_vicon = data.yout(:,46);

vx_vicon = data.yout(:,41);
vy_vicon = data.yout(:,42);
vz_vicon = data.yout(:,43);

alpha_vicon = data.yout(:,9);
beta_vicon = data.yout(:,10);
gamma_vicon = data.yout(:,11);

quat_0 = data.yout(:,22);
quat_1 = data.yout(:,23);
quat_2 = data.yout(:,24);
quat_3 = data.yout(:,25);

omega_x_vicon = data.yout(:,12);
omega_y_vicon = data.yout(:,13);
omega_z_vicon = data.yout(:,14);

acceleration_x_vicon = filter([1 -1],[1],vx_vicon)*config.sampling_f;
acceleration_y_vicon = filter([1 -1],[1],vy_vicon)*config.sampling_f;
acceleration_z_vicon = filter([1 -1],[1],vz_vicon)*config.sampling_f;


X_vicon = [zeros(1, 15)];

n_samples = size(Ft, 1);

scenario = uavScenario("StopTime", 20, "UpdateRate", config.sampling_f);
plat = uavPlatform("UAV", scenario, 'ReferenceFrame', 'ENU');
updateMesh(plat,"quadrotor", {0.025}, [0 0 1], [0 0 0], [1 0 0 0]);

% Add a ground plane.
color.Gray = 0.651*ones(1,3);
addMesh(scenario,"polygon",{[-1 -1; 1 -1; 1 1; -1 1],[-0.001 0]},color.Gray)


lidarModel = uavLidarPointCloudGenerator("AzimuthLimits", [-90, 90], "ElevationLimits", [-90, 90], "HasNoise", true, 'UpdateRate', config.sampling_f);

accRmsNoise = 1e-6*190 * config.g;
gyroRmsNoise = 1.9199e-04;
aParams = accelparams("NoiseDensity", accRmsNoise);
gParams = gyroparams("NoiseDensity", gyroRmsNoise);

imuModel = uavIMU(imuSensor('accel-gyro-mag', 'SampleRate', config.sampling_f, 'Accelerometer', aParams, 'Gyroscope', gParams, 'ReferenceFrame','NED'));

imu = uavSensor("IMU", plat, imuModel, "MountingLocation", [0, 0, 0]);
tof = uavSensor("Lidar",plat,lidarModel,"MountingLocation",[0,0, -0.01],"MountingAngles",[0 90 0]);

initCovariance = 10*eye(12);
processNoise = eye(12);
measureNoise = diag([accRmsNoise*ones(1, 3), gyroRmsNoise*ones(1, 3), 1e-3]);

figure
ax = show3D(scenario);
xlim([-0.1 0.1]);
ylim([-0.1 0.1]);

setup(scenario);


FUSE = ahrsfilter('ReferenceFrame', 'NED', 'AccelerometerNoise', accRmsNoise, 'GyroscopeNoise', gyroRmsNoise, 'OrientationFormat', 'Rotation matrix');

FUSE10 = ahrs10filter('ReferenceFrame', 'NED',
                    'AccelerometerNoise',accRmsNoise, ...
                    'State',initstate, ...
                    'StateCovariance',initcov);

initR = eul2rotm([alpha_vicon(30), beta_vicon(30), gamma_vicon(30)], 'XYZ');

orientation = [];
for i = 1: floor(0.27*n_samples)
    if Ft(i) == 0
        continue
    end
    isRunning = advance(scenario);
    updateSensors(scenario);

    [isUpdated_imu, t_imu, acc, gyro, mag] = read(imu);
    [isUpdated_tof, t_tof, ptCloud_lidar] = read(tof);
    % Store data in structure.
    simData.Time = [simData.Time; seconds(t_imu)];
    simData.AccelerationX = [simData.AccelerationX; acc(1)];
    simData.AccelerationY = [simData.AccelerationY; acc(2)];
    simData.AccelerationZ = [simData.AccelerationZ; acc(3)];
    simData.AngularRatesX = [simData.AngularRatesX; gyro(1)];
    simData.AngularRatesY = [simData.AngularRatesY; gyro(2)];
    simData.AngularRatesZ = [simData.AngularRatesZ; gyro(3)];
    simData.MagnetometerX = [simData.MagnetometerX; mag(1)];
    simData.MagnetometerY = [simData.MagnetometerY; mag(2)];
    simData.MagnetometerZ = [simData.MagnetometerZ; mag(3)];    
    z_tof = proximitySensor(ptCloud_lidar);
    simData.ToFDistance = [simData.ToFDistance; z_tof];

    sensorData = [acc gyro z_tof];

    U = [Ft(i), Tr(i), Tp(i), Ty(i)];
    acc(3) = acc(3) + (Ft(i))/config.m;
    acc

    state_vicon = [x_vicon(i), y_vicon(i), z_vicon(i), vx_vicon(i), vy_vicon(i), vz_vicon(i), alpha_vicon(i), beta_vicon(i), gamma_vicon(i), omega_x_vicon(i), omega_y_vicon(i), omega_z_vicon(i), acceleration_x_vicon(i), acceleration_y_vicon(i), acceleration_z_vicon(i)];    
    X_vicon = [X_vicon; state_vicon];
    [orientation_rt, angular_vel] = FUSE(acc, gyro, mag);
    orientation_ = rotm2eul(initR * orientation_rt, 'XYZ');
    orientation = [orientation; orientation_];


    move(plat, state2motion(state_vicon));

    if ~mod(i, 10)
        disp((100*i/n_samples) + "% Done");
%        show3D(scenario, "FastUpdate", true, "Parent", ax);
%        drawnow limitrate
        % exportgraphics(gcf,'sim1.gif','Append',true);
    end
end

figure
plot_time = size(orientation, 1);
y_axis = ["Roll", "Pitch", "Yaw"];
is = [1 2 3];


for i =1:3
    subplot(3, 1, i)
    plot(orientation(1:plot_time, i), 'DisplayName', "AHRS");
    hold on;
    plot(X_vicon(1:plot_time, 3*i + 1), 'DisplayName', "Ground Truth");
    ylabel(y_axis(i));
    legend()
    hold off;
end

simTable = table2timetable(struct2table(simData));
figure
stackedplot(simTable, ["AccelerationX", "AccelerationY", "AccelerationZ", ...
    "AngularRatesX", "AngularRatesY", "AngularRatesZ", "ToFDistance"], ...
    "DisplayLabels", ["AccX (m/s^2)", "AccY (m/s^2)", "AccZ (m/s^2)", ...
    "AngularRateX (rad/s)", "AngularRateY (rad/s)", "AngularRateZ (rad/s)", "Proximity Sensor"]);



function motion = state2motion(state)
    pos = state(1:3);
    vel = state(4:6);
    quat = eul2quat(state(7:9), 'XYZ');
    omega = state(10:12);
    accel = state(12:14);
    motion = [pos vel accel quat omega];
end