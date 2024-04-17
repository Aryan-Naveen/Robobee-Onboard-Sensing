clear all;
close all;
config = load('config.mat');
data = load("golden.mat");



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

omega_x_vicon = data.yout(:,12);
omega_y_vicon = data.yout(:,13);
omega_z_vicon = data.yout(:,14);

acceleration_x_vicon = (1/dt)*diff(vx_vicon);
%filter([1 -1],[1],vx_vicon)*config.sampling_f;
acceleration_y_vicon = (1/dt)*diff(vy_vicon);
%filter([1 -1],[1],vy_vicon)*config.sampling_f;
acceleration_z_vicon = (1/dt)*diff(vz_vicon);
%filter([1 -1],[1],vz_vicon)*config.sampling_f;


alpha_vicon()
state = [x_vicon(30); y_vicon(30); z_vicon(30); vx_vicon(30); vy_vicon(30); vz_vicon(30); alpha_vicon(30); beta_vicon(30); gamma_vicon(30); omega_x_vicon(30); omega_y_vicon(30); omega_z_vicon(30)];

X = [state.'];
%X_vicon = [zeros(1, 15)];
X_vicon = []
n_samples = size(Ft, 1);

scenario = uavScenario("StopTime", 20, "UpdateRate", config.sampling_f);
plat = uavPlatform("UAV", scenario, 'ReferenceFrame', 'ENU');
updateMesh(plat,"quadrotor", {0.025}, [0 0 1], [0 0 0], [0.9363   -0.0591    0.0218    0.3455]);

% Add a ground plane.
color.Gray = 0.651*ones(1,3);
addMesh(scenario,"polygon",{[-1 -1; 1 -1; 1 1; -1 1],[-0.001 0]},color.Gray)


lidarModel = uavLidarPointCloudGenerator("AzimuthLimits", [-90, 90], "ElevationLimits", [-90, 90], "HasNoise", true, 'UpdateRate', config.sampling_f);

accRmsNoise = 1e-6*190 * config.g;
gyroRmsNoise = 1.9199e-04;
aParams = accelparams("NoiseDensity", accRmsNoise);
gParams = gyroparams("NoiseDensity", gyroRmsNoise);

imuModel = uavIMU(imuSensor('accel-gyro-mag', 'SampleRate', config.sampling_f, 'Accelerometer', aParams, 'Gyroscope', gParams, 'ReferenceFrame','ENU'));

imu = uavSensor("IMU", plat, imuModel, "MountingLocation", [0, 0, 0]);
tof = uavSensor("Lidar",plat,lidarModel,"MountingLocation",[0,0, -0.01],"MountingAngles",[0 90 0]);

initCovariance = 10*eye(12);
processNoise = eye(12);
measureNoise = diag([accRmsNoise*ones(1, 3), gyroRmsNoise*ones(1, 3), 1e-3]);

% Preallocate the simData structure and fields to store simulation data. The IMU sensor will output acceleration and angular rates.
simData = struct;
simData.Time = duration.empty;
simData.AccelerationX = zeros(0,1);
simData.AccelerationY = zeros(0,1);
simData.AccelerationZ = zeros(0,1);
simData.AngularRatesX = zeros(0,1);
simData.AngularRatesY = zeros(0,1);
simData.AngularRatesZ = zeros(0,1);
simData.MagnetometerX = zeros(0, 1);
simData.MagnetometerY = zeros(0, 1);
simData.MagnetometerZ = zeros(0, 1);
simData.ToFDistance = zeros(0, 1);

controlData = struct;
controlData.Time = duration.empty;
controlData.Ft = zeros(0,1);
controlData.Tr = zeros(0,1);
controlData.Tp = zeros(0, 1);
controlData.Ty = zeros(0, 1);

figure
ax = show3D(scenario);
xlim([-0.1 0.1]);
ylim([-0.1 0.1]);

setup(scenario);

ekfFilter = trackingEKF(State=state,StateCovariance=initCovariance, ...
    StateTransitionFcn=@model,ProcessNoise=processNoise, ...
    MeasurementFcn=@measurementModel,MeasurementNoise=measureNoise);

ukfFilter = unscentedKalmanFilter(...
    @model,... % State transition function
    @measurementModel,... % Measurement function
    state);
ukfFilter.MeasurementNoise =measureNoise;
ukf.ProcessNoise = processNoise;

FUSE = imufilter('ReferenceFrame','ENU', 'AccelerometerNoise', 1e-6*190, 'GyroscopeNoise', gyroRmsNoise);

X_ekf = [ekfFilter.State.'];
X_ukf = [ukfFilter.State.'];
orientations = [];
controls = [];
for i = config.start_delay_adaptive*config.sampling_f : (config.start_delay_adaptive+0.05)*config.sampling_f 
    if Ft(i) == 0
        continue
    end

    isRunning = advance(scenario);
    updateSensors(scenario);

    [isUpdated_imu, t_imu, acc, gyro, mag] = read(imu);
    [isUpdated_tof, t_tof, ptCloud_lidar] = read(tof);
    % acc = acc.' -  Ft(i)/config.m * config.e3;
    state_vicon = [x_vicon(i), y_vicon(i), z_vicon(i), vx_vicon(i), vy_vicon(i), vz_vicon(i), alpha_vicon(i), beta_vicon(i), gamma_vicon(i), omega_x_vicon(i), omega_y_vicon(i), omega_z_vicon(i), acceleration_x_vicon(i), acceleration_y_vicon(i), acceleration_z_vicon(i)];
    X_vicon = [X_vicon; state_vicon];

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
    
%{

    sensorData = [acc gyro z_tof];

    U = [Ft(i), Tr(i), Tp(i), Ty(i)];
    state_prev = state;
    state = model(state_prev, U, dt, config);

    

    X = [X; state.'];


    correct(ekfFilter, sensorData, U, config);
    predict(ekfFilter, U, config.sampling_time, config);
    X_ekf = [X_ekf; ekfFilter.State.'];
    
    correct(ukfFilter, sensorData, U, config);
    predict(ukfFilter, U, config.sampling_time, config);
    X_ukf = [X_ukf; ukfFilter.State.'];
%}

    disp(norm(acc))
    
    [orientation, angVel] = FUSE(acc, gyro);
    orientations = [orientations; quat2eul(orientation, 'XYZ')];
    move(plat, state2motion(state_vicon));
    controls = [controls; [Tr(i)/config.Ixx, Tp(i)/config.Iyy, Ty(i)/config.Izz]];
    controlData.Time = [controlData.Time; seconds(t_imu)];
    controlData.Ft = [controlData.Ft, Ft(i)/config.m];
    controlData.Tr = [controlData.Tr, Tr(i)/config.Ixx];
    controlData.Tp = [controlData.Tp, Tp(i)/config.Iyy];
    controlData.Ty = [controlData.Ty, Ty(i)/config.Izz];
    if ~mod(i, 10)
        disp((100*i/n_samples) + "% Done");
        norm(acc)
        
%        show3D(scenario, "FastUpdate", true, "Parent", ax);
%        drawnow limitrate
        % exportgraphics(gcf,'sim1.gif','Append',true);
    end
end

figure
plot_time = size(X_vicon, 1);
plot_time
y_axis = ["X (meters)", "Y (meters)", "Z (meters)", "V_x (m/s)", "V_y (m/s)", "V_z (m_s)", "Roll", "Pitch", "Yaw", "Omega_X (Rad/sec)", "Omega_Y (Rad/sec)", "Omega_Z (Rad/sec)"];
is = [7 8 9]

for i = is
    subplot(3, 1, i - 6)
    y_axis(i)
    plot(orientations(1:plot_time, i - 6), 'DisplayName', "Filter");
    hold on;
    plot(X_vicon(1:plot_time, i), 'DisplayName', "Ground Truth");
%    plot(X(1:plot_time, is(i)), 'DisplayName', "Naive");
%    plot(X_ukf(1:plot_time, is(i)), 'DisplayName', "UKF");
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
    pos = [0 0 0.1];
    vel = [0 0 0];%state(4:6);
    quat = eul2quat(state(7:9), 'XYZ');
    omega = state(10:12);
    accel = [0 0 0];%state(12:14);
    
    motion = [pos vel accel quat omega];
end