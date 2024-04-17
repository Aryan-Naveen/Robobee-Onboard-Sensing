clear all; close all;

trajectory = waypointTrajectory([0 0 0.01; 0 0 0.3; 0 0 0.01], "TimeOfArrival", [0, 1, 2], "SampleRate", 100, 'ReferenceFrame', 'ENU');

% First, create the scenario.
scenario = uavScenario("StopTime", 20, "UpdateRate", 100);

% Add a ground plane.
color.Gray = 0.651*ones(1,3);
addMesh(scenario,"polygon",{[-1 -1; 1 -1; 1 1; -1 1],[-0.001 0]},color.Gray)

% Create a UAV platform and specify the trajectory. Add a fixed-wing mesh for visualization.
plat = uavPlatform("UAV_open_loop", scenario, 'ReferenceFrame', 'ENU');
updateMesh(plat,"quadrotor", {0.1}, [1 0 0], [1 0 0], [1 0 0 0]);

plat_truth = uavPlatform("UAV_truth", scenario, 'ReferenceFrame', 'ENU');
updateMesh(plat_truth,"quadrotor", {0.1}, [0 0 1], [0 0 0], [1 0 0 0]);

imu = uavSensor("IMU", plat_truth, uavIMU(imuSensor));
LidarModel = uavLidarPointCloudGenerator("AzimuthLimits", [-90, 90], "ElevationLimits", [-90, 90], "HasNoise", false);
tof = uavSensor("Lidar",plat_truth,LidarModel,"MountingLocation",[0,0, -0.01],"MountingAngles",[0 90 0]);

fn = fullfile(matlabroot,'toolbox','shared',...
    'positioning','positioningdata','generic.json');
loadparams(imu.SensorModel,fn,"GenericLowCost9Axis");


% Preallocate the simData structure and fields to store simulation data. The IMU sensor will output acceleration and angular rates.
simData = struct;
simData.Time = duration.empty;
simData.AccelerationX = zeros(0,1);
simData.AccelerationY = zeros(0,1);
simData.AccelerationZ = zeros(0,1);
simData.AngularRatesX = zeros(0,1);
simData.AngularRatesY = zeros(0,1);
simData.AngularRatesZ = zeros(0,1);
simData.ToFDistance = zeros(0, 1);

% Visualize the scenario.
figure
ax = show3D(scenario);
xlim([-1 1]);
ylim([-1 1]);

% Setup the scenario.
setup(scenario);

% Run the simulation using the advance function. Update the sensors and record the data.
updateCounter = 0;


T_s = 0.01; %sampling time

x_ = zeros(12, 1); % state --> [position, velocity, angular position (rotation matrix), angular velocity]
x_prev = x_;

x_naive = zeros(12, 1); % state --> [position, velocity, angular position (rotation matrix), angular velocity]
x_naive_prev = x_naive;

u_ = zeros(4, 1); % control input --> [F_T, tau_x, tau_y, tau_z]

scale = 1e3;

kx = diag([0.5/scale, 0.5/scale, 0.5/scale]);
kv = diag([0.05/scale, 0.05/scale, 0.05/scale]);
kR = diag([0.5/(scale^2), 0.5/(scale^2), 0.5/(scale^2)]);
kS = diag([0.25/(scale^2), 0.25/(scale^2), 0.25/(scale^2)]);

e3 = [0 0 1]; % unit vector along z axis
m = 8.6e-5; % 86 mg
g = 1; 

Ixx = 1e-9*1.42;
Iyy = 1e-9*1.34;
Izz = 1e-9*0.45;
I = diag([Ixx, Iyy, Izz]);

ang_vel_d_prev = [0 0 0];

z_truth = [];
z_open_loop = [];

while ~isDone(trajectory)
    isRunning = advance(scenario);
    updateCounter = updateCounter + 1;

    updateSensors(scenario);
    [isUpdated_imu, t_imu, acc, gyro] = read(imu);
    [isUpdated_tof, t_tof, ptCloud_lidar] = read(tof);
    % Store data in structure.
    simData.Time = [simData.Time; seconds(t_imu)];
    simData.AccelerationX = [simData.AccelerationX; acc(1)];
    simData.AccelerationY = [simData.AccelerationY; acc(2)];
    simData.AccelerationZ = [simData.AccelerationZ; acc(3)];
    simData.AngularRatesX = [simData.AngularRatesX; gyro(1)];
    simData.AngularRatesY = [simData.AngularRatesY; gyro(2)];
    simData.AngularRatesZ = [simData.AngularRatesZ; gyro(3)];

    simData.ToFDistance = [simData.ToFDistance; proximitySensor(ptCloud_lidar)];



    [pos_d,rot_d,vel_d,acc_d,ang_vel_d] = trajectory();
    rot_d = quat2rotm(rot_d);
    
    x_desired = getStateVec(pos_d, rot_d, vel_d, ang_vel_d);
    ang_acc_d = 1/(T_s)*(ang_vel_d - ang_vel_d_prev);


    %%%%%%%%%%%%%%%%%% This is for open loop
    [e_x, e_v, e_R, e_S] = getFeedBackErrors(x_naive, pos_d, vel_d, rot_d, ang_vel_d);
    
    F_T = dot(-kx*e_x - kv*e_v + m*g*e3.' + m*acc_d.', getRot(x_)*e3.');

    K = (getAngVelHat(getAngVel(x_))*getRot(x_).'*rot_d*ang_vel_d.' - getRot(x_).'*rot_d*ang_acc_d.');

    tau = -kR * e_R - kS*e_S + cross(getAngVel(x_), I*getAngVel(x_)) - I*K;

    ang_vel_d_prev = ang_vel_d;
    x_prev = x_;

    x_naive_prev = x_naive;
    u_naive = [F_T; tau];

    x_naive = stateTransitionFcn(x_naive_prev, u_naive, T_s);

    %%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%% This is for x truth
    [e_x, e_v, e_R, e_S] = getFeedBackErrors(x_, pos_d, vel_d, rot_d, ang_vel_d);
    
    F_T = dot(-kx*e_x - kv*e_v + m*g*e3.' + m*acc_d.', getRot(x_)*e3.');

    K = (getAngVelHat(getAngVel(x_))*getRot(x_).'*rot_d*ang_vel_d.' - getRot(x_).'*rot_d*ang_acc_d.');

    tau = -kR * e_R - kS*e_S + cross(getAngVel(x_), I*getAngVel(x_)) - I*K;

    ang_vel_d_prev = ang_vel_d;
    x_prev = x_;

    u_ = u_naive + [1e-4*randn([1, 1]); 0; 0; 0];

    x_ = stateTransitionFcn(x_prev, u_, T_s);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    z_truth = [z_truth; x_(3)];

    z_open_loop = [z_open_loop; x_naive(3)];

    move(plat_truth, getMotion(x_, x_prev, T_s));
    move(plat, getMotion(x_naive, x_naive_prev, T_s));


    if updateCounter > 10
        show3D(scenario, "FastUpdate", true, "Parent", ax);
        updateCounter = 0;
        drawnow limitrate
        % exportgraphics(gcf,'sim1.gif','Append',true);
    end

end

plot(z_truth, 'DisplayName', "Ground Truth");
hold on;
plot(z_open_loop, 'DisplayName', "Naive");
ylabel("Altitude (meters)");
legend()
hold off;

simTable = table2timetable(struct2table(simData));
figure
stackedplot(simTable, ["AccelerationX", "AccelerationY", "AccelerationZ", ...
    "AngularRatesX", "AngularRatesY", "AngularRatesZ", "ToFDistance"], ...
    "DisplayLabels", ["AccX (m/s^2)", "AccY (m/s^2)", "AccZ (m/s^2)", ...
    "AngularRateX (rad/s)", "AngularRateY (rad/s)", "AngularRateZ (rad/s)", "Proximity Sensor"]);


function u = getControlInput(x, kx, kv, kR, kS, m, g, I, pos_d, vel_d, rot_d, ang_vel_d)
    [e_x, e_v, e_R, e_S] = getFeedBackErrors(x, pos_d, vel_d, rot_d, ang_vel_d);

end

function x = getStateVec(pos, rot, vel, ang_vel_d)
    x = [pos vel reshape(rot, [1, 9]) ang_vel_d].';
end

function [e_x, e_v, e_R, e_S] = getFeedBackErrors(x_current, pos_d, vel_d, R_desired, ang_vel_d)

    e_x = x_current(1:3) - pos_d.';
    e_v = x_current(4:6) - vel_d.';

    R_current = getRot(x_current);
    e_R = 0.5*inverse_ssm(R_desired.' * R_current - R_current.' * R_desired);
    e_S = x_current(10:12) - R_current.' * R_desired * ang_vel_d.';
end

function v = inverse_ssm(V_hat)
    v3 = V_hat(2, 1);
    v2 = V_hat(1, 3);
    v1 = V_hat(3, 2);
    v = [v1; v2; v3];
end

function R = getRot(x)
    R = eul2rotm(x(7:9).', 'ZYX');
end

function sigma = getAngVel(x)
    sigma = x(10:12);
end

function sigma_hat = getAngVelHat(angVel)
    sigma_hat = [0 -angVel(3) angVel(2); angVel(3) 0 -angVel(1); -angVel(2) angVel(1) 0];
end


function xNext = stateTransitionFcn(x, u, dt)
    m = 8.6e-5; % 86 mg
    g = 9.81; 
    
    Ixx = 1e-9*1.42;
    Iyy = 1e-9*1.34;
    Izz = 1e-9*0.45;

    A = [0 0 0 1 0 0 0 0 0 0 0 0;
         0 0 0 0 1 0 0 0 0 0 0 0;
         0 0 0 0 0 1 0 0 0 0 0 0;
         0 0 0 0 0 0 0 -g 0 0 0 0;
         0 0 0 0 0 0 g 0 0 0 0 0;
         0 0 0 0 0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0 0 1 0 0;
         0 0 0 0 0 0 0 0 0 0 1 0;
         0 0 0 0 0 0 0 0 0 0 0 1;
         0 0 0 0 0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0 0 0 0 0];
    B = [0 0 0 0;
         0 0 0 0;
         0 0 0 0;
         0 0 0 0;
         0 0 0 0;
         1/m 0 0 0;
         0 0 0 0;
         0 0 0 0;
         0 0 0 0;
         0 1/Ixx 0 0;
         0 0 1/Iyy 0;
         0 0 0 1/Izz;];

    x_dot = A * x + B * u;

    xNext = x + dt*x_dot;
end

function motion = getMotion(X, X_prev, T_s)
    pos = X(1:3);
    vel = X(4:6);
    vel_prev = X_prev(4:6);
    accel = 1/T_s * (vel - vel_prev);
    quat = eul2quat(X(7:9).', 'ZYX');
    ang_vel = X(10:12);
    motion = [pos; vel; accel; quat.'; ang_vel].';
end

function sensorReadings = proximitySensor(ptCloud)
    % Define sensor characteristics (e.g., field of view, range)
    fov = 25; % Field of view in degrees
    maxRange = 25; % Maximum range of the proximity sensor in meters
    minRange = 0.01;

    % Extract XYZ coordinates from the point cloud

    XYZ = reshape(ptCloud.Location, [size(ptCloud.Location, 1)*size(ptCloud.Location, 2), 3]);


    % Calculate Euclidean distances
    distances = sqrt(sum(XYZ.^2, 2));

    % Filter points within the sensor's field of view and within range
    validPoints = (abs(atan2d(XYZ(:,3), XYZ(:,2))) <= fov/2) & (distances <= maxRange);

    % Get the closest valid point
    rmsNoise = 1e-3;
%    distances = distances +  rmsNoise * randn(size(distances, 1), 1);
    closestPoint = min(distances(validPoints));

    % Output sensor reading
    if isempty(closestPoint)
        sensorReadings = nan; % No valid points in range
    else
        sensorReadings = closestPoint
    end
end

