% update the tangential velocity at boundaries
function[face] = update_wall_velocity(domain,face)
    % the domain is currently assumed as a box with no-slip boundary
    % condition
    u_south = 0;
    u_north = 0;
    v_west = 0;
    v_east = 0;
    face.u(1:domain.nx+1,1) = 2*u_south-face.u(1:domain.nx+1,2);
    face.u(1:domain.nx+1,domain.ny+2) = ...
        2*u_north-face.u(1:domain.nx+1,domain.ny+1);
    face.v(1,1:domain.ny+1) = 2*v_west -face.v(2,1:domain.ny+1);
    face.v(domain.nx+2,1:domain.ny+1) = ...
        2*v_east -face.v(domain.nx+1,1:domain.ny+1);
end