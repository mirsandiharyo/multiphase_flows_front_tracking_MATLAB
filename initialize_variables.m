% initialize variables (liquid is at rest at the beginning)
function [face, center] = initialize_variables(domain)
    % set the grid with staggered arrangement
    face(1).x = linspace(-0.5, domain.nx+2-1.5, domain.nx+2)*domain.dx;
    face(1).y = linspace(-0.5, domain.ny+2-1.5, domain.ny+2)*domain.dy;
    % velocity in x-direction
    [face(1).u, face(1).u_old, face(1).u_temp] = ...
        deal(zeros(domain.nx+1, domain.ny+2));
    % velocity in y-direction
    [face(1).v, face(1).v_old, face(1).v_temp] = ...
        deal(zeros(domain.nx+2, domain.ny+1));
    % pressure and force
    [center(1).pres, face(1).force_x, face(1).force_y] = ...
        deal(zeros(domain.nx+2, domain.ny+2));
end