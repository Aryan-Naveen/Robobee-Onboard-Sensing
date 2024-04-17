function Y = measurementModel(X, u, config)
    % Y = [accel, gyro, tof]
    p = X(1:3); % position x, y, z
    v = X(4:6); % velocity vx vy vz
    w = X(7:9); % euler angle roll pitch yaw
    r = X(10:12); % rotation p q r


    R = [cos(w(2))*cos(w(3)), sin(w(2))*cos(w(3))*sin(w(1)) - sin(w(3))*cos(w(1)), sin(w(2))*cos(w(3))*cos(w(1))+sin(w(3))*sin(w(1));
         cos(w(2))*sin(w(1)), sin(w(2))*sin(w(3))*sin(w(1)) + cos(w(3))*cos(w(1)), sin(w(2))*sin(w(3))*cos(w(1)) - cos(w(3))*sin(w(1));
         -sin(w(2)),           cos(w(2))*sin(w(1)),                   cos(w(2))*cos(w(1))];

    accel_rt_world = -config.g*config.e3 + (u(1)/config.m - 1.2*v(3))*R*config.e3;
    ang_vel_rt_world = r.';

    IMU = imuSensor('accel-gyro-mag', 'ReferenceFrame','ENU');

    [acc, gyro, mag] = IMU(accel_rt_world.',ang_vel_rt_world, R);

    world_T_bee = homogenousT(p, R);
    bee_T_tof = homogenousT([0, 0, -0.01], eye(3));

    world_T_tof = world_T_bee * bee_T_tof;

    z_tof = world_T_tof(3, 4);
    Y = [acc gyro z_tof];

end

function T = homogenousT(pos, R)
    T = eye(4);
    T(1:3, 1:3) = R;
    T(1:3, 4) = pos.';
end