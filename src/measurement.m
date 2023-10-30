function yMeas = measurement(x, u, config)
    [x, y, z, vx, vy, vz, phi, theta, psi, phi_dot, theta_dot, psi_dot] = struct('data', num2cell(x)).data;
    yMeas = [
            (cos(phi)*sin(theta)*cos(psi) + sin(phi)*sin(psi))* u(1)/config.m;
            (cos(phi)*sin(theta)*sin(psi) + sin(phi)*sin(psi))* u(1)/config.m;
            (cos(phi)*cos(theta))* u(1)/config.m - config.g;   
            phi_dot;
            theta_dot;
            psi_dot;
            z;
            ];
end