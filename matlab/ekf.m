function xNext = ekf(x_prev, u, y_sensor, dt)
    x_prior_next = nonlinearStateTransitionFcn(x_prev, u, dt);

    y_prior = computeMeasurementValues(x_prior_next);


end


function y = computeMeasurementValues(x)
    m = 8.6e-5; % 86 mg
    g = -9.81; 
    
    Ixx = 1e-9*1.42;
    Iyy = 1e-9*1.34;
    Izz = 1e-9*0.45;

    psi = x(7); theta= x(8); phi = x(9);
    p = x(10); q = x(11); r = x(12);

    y = zeros(7, 1);
    y(1) = -(1/m)*(sin(phi)*sin(psi) + cos(phi)*cos(psi)*sin(theta)) * u(1); % x acceleration
    y(2) = -(1/m)*(cos(psi)*sin(phi) - cos(phi)*sin(psi)*sin(theta)) * u(1); % y acceleration
    y(3) = (1/m)*(cos(phi)*cos(theta)) * u(1) + g; % z acceleration

    y(4) = p;
    y(5) = q;
    y(6) = r;

    y(7) = x(3);
end

function xNext = nonlinearStateTransitionFcn(x, u, dt)
    m = 8.6e-5; % 86 mg
    g = -9.81; 
    
    Ixx = 1e-9*1.42;
    Iyy = 1e-9*1.34;
    Izz = 1e-9*0.45;

    psi = x(7); theta= x(8); phi = x(9);
    p = x(10); q = x(11); r = x(12);

    fx = [x(4); 
          x(5);
          x(6);
          0;
          0;
          g;
          q * (sin(phi)/cos(theta)) + r * (cos(phi)/cos(theta));
          q * cos(phi) - r * sin(cos(phi));
          p + q*(sin(phi) * tan(theta)) + r * (cos(phi) * tan(theta));
          ((Iyy - Izz) * q*r)/Ixx;
          ((Izz - Ixx) * p * r)/Iyy;
          ((Ixx - Iyy) * p * q)/Izz];

    a = -(1/m)*(sin(phi)*sin(psi) + cos(phi)*cos(psi)*sin(theta));
    b = -(1/m)*(cos(psi)*sin(phi) - cos(phi)*sin(psi)*sin(theta));
    c = (1/m)*(cos(phi)*cos(theta));
    g_1x = [0 0 0 a b c 0 0 0 0 0 0];
    g_2x = [0 0 0 0 0 0 0 0 0 1/Ixx 0 0];
    g_3x = [0 0 0 0 0 0 0 0 0 0 1/Iyy 0];
    g_4x = [0 0 0 0 0 0 0 0 0 0 0 1/Izz];

    x_dot = fx + g_1x.' * u(1) + g_2x.' * u(2) + g_3x.' * u(3) + g_4x.' * u(4);
    
    xNext = x + x_dot*dt;

    xNext(6)


end