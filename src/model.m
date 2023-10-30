function XNext = model(X, u, dt, config)
    % We assume that state is [x y z vx vy vz phi(roll) theta(pitch)
    % psi(yaw) phi_dot theta_dot psi_dot]
%    [x, y, z, vx, vy, vz, phi, theta, psi, phi_dot, theta_dot, psi_dot] = struct('data', num2cell(X)).data;
%    Xdot = [vx;
%            vy;
%            vz;
%            -(cos(phi)*sin(theta)*cos(psi) + sin(phi)*sin(psi))* u(1)/config.m;
%            -(cos(phi)*sin(theta)*cos(psi) - sin(phi)*sin(psi))* u(1)/config.m;
%            config.g - (cos(phi)*cos(theta))* u(1)/config.m;
%            phi_dot;
%            theta_dot;
%            psi_dot;
%            ((config.Iyy - config.Izz)/(config.Ixx))*theta_dot*psi_dot + (1/config.Ixx)*u(2);
%            ((config.Izz - config.Ixx)/(config.Iyy))*phi_dot*psi_dot + (1/config.Iyy)*u(3);
%            ((config.Ixx - config.Iyy)/(config.Izz))*phi_dot*theta_dot + (1/config.Izz)*u(4);
%            ];
%    XNext = X + Xdot*dt;
    if sum(u) ~= 0

        p = X(1:3); % position x, y, z
        v = X(4:6); % velocity vx vy vz
        w = X(7:9); % euler angle roll pitch yaw
        r = X(10:12); % rotation p q r
    
        
    
        p_dot = v;
    
    
    R = [cos(w(2))*cos(w(3)), sin(w(2))*cos(w(3))*sin(w(1)) - sin(w(3))*cos(w(1)), sin(w(2))*cos(w(3))*cos(w(1))+sin(w(3))*sin(w(1));
         cos(w(2))*sin(w(1)), sin(w(2))*sin(w(3))*sin(w(1)) + cos(w(3))*cos(w(1)), sin(w(2))*sin(w(3))*cos(w(1)) - cos(w(3))*sin(w(1));
         -sin(w(2)),           cos(w(2))*sin(w(1)),                   cos(w(2))*cos(w(1))];
%        R = eul2rotm(w.', 'XYZ');
        
        T = [1, sin(w(1))*tan(w(2)), cos(w(1))*tan(w(2));
             0,  cos(w(1)),      -sin(w(1));
             0,  sin(w(1))*sec(w(2)), cos(w(1))*sec(w(2))];
    
        I_ff = diag(config.I_moment_vec);
        if sum(isnan(R)) > 0
            disp(w)
        end
        v_dot = -config.g*config.e3 + (u(1)/config.m - 1.2*v(3))*R*config.e3;
    
    
        w_dot = T * r;
    
        r_dot = inv(I_ff)*(cross(-r,  I_ff*r) + u(2:4).');
    
        Xdot = [p_dot; v_dot; w_dot; r_dot];
    
        XNext = X + Xdot*dt;
    else
        XNext = X;
    end

    

end