% initialize variables (liquid is at rest at the beginning)
function [face, center] = initialize_variables(domain)
    % set the grid with staggered arrangement
    face(1).x = linspace(-0.5, domain.nx+2-1.5, domain.nx+2)*domain.dx;
    face(1).y = linspace(-0.5, domain.ny+2-1.5, domain.ny+2)*domain.dy;
    % variables located at the cell face
    % horizontal velocities
    [face(1).u, face(1).u_old, face(1).u_temp] = ...
        deal(zeros(domain.nx+1, domain.ny+2));
    % vertical velocities
    [face(1).v, face(1).v_old, face(1).v_temp] = ...
        deal(zeros(domain.nx+2, domain.ny+1));
    % variables located at cell center
    % pressure, force and temporary variables
    [center(1).pres, center(1).force_x, center(1).force_y, ...
        center(1).temp1, center(2).temp2] = ...
        deal(zeros(domain.nx+2, domain.ny+2));
end