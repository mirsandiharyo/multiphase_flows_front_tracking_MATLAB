% update the density field using the normal gradient at the lagrangian
% interface
function[fluid] = update_density(domain, param, fluid_prop, bubble, fluid)
    % initialize the force
    [center_x, center_y] = deal(zeros(domain.nx+2, domain.ny+2));
    % distribute the interfacial gradient to the eulerian grid
    for i=2:bubble.pnt+1
        % normal vector in x-direction
        force_x = -0.5*(bubble.y(i+1)-bubble.y(i-1))* ...
            (fluid_prop(1).rho-fluid_prop(2).rho);  
        center_x = distribute_lagrangian_to_eulerian(domain, ...
            center_x, bubble.x(i), bubble.y(i), force_x, 1);
        
        % normal vector in y-direction
        force_y = 0.5*(bubble.x(i+1)-bubble.x(i-1))* ...
            (fluid_prop(1).rho-fluid_prop(2).rho); 
        center_y = distribute_lagrangian_to_eulerian(domain, ...
            center_y, bubble.x(i), bubble.y(i), force_y, 2);
    end
    % construct the density field
    for iter=1:param.max_iter
        old_rho = fluid.rho;
        for i=2:domain.nx+1
            for j=2:domain.ny+1
                fluid.rho(i,j) = (1.0-param.beta)*fluid.rho(i,j)+ ...
                    param.beta*0.25* ...
                   (fluid.rho(i+1,j  )+fluid.rho(i-1,j  )+ ...
                    fluid.rho(i  ,j+1)+fluid.rho(i  ,j-1)+...
                    domain.dx*center_x(i-1,j  )- ...
                    domain.dx*center_x(i  ,j  )+ ...
                    domain.dy*center_y(i  ,j-1)- ...
                    domain.dy*center_y(i  ,j  ));
            end
        end
        if max(max(abs(old_rho-fluid.rho))) < param.max_err
            break
        end
    end    
end