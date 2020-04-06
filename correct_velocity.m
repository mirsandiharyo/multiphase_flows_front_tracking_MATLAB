% correct the velocity to satisfy continuity equation
function[face] = correct_velocity(domain, param, center, fluid, face)
    % correct velocity in x-direction
    for i=2:domain.nx
        for j=2:domain.ny+1
            face.u(i,j) = face.u_temp(i,j)-param.dt*(2.0/domain.dx)* ...
                (center.pres(i+1,j)-center.pres(i,j))/ ...
                (fluid.rho(i+1,j)+fluid.rho(i,j));
        end
    end
    % correct velocity in x-direction
    for i=2:domain.nx+1
        for j=2:domain.ny
            face.v(i,j) = face.v_temp(i,j)-param.dt*(2.0/domain.dy)* ...
                (center.pres(i,j+1)-center.pres(i,j))/ ...
                (fluid.rho(i,j+1)+fluid.rho(i,j));
        end
    end
end
