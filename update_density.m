% update the density field using the density jump at the lagrangian
% interface
function[rho] = update_density(domain, param, fluid_prop, bubble, rho)
    % initialize the variables to store the density jump
    [face_x, face_y] = deal(zeros(domain.nx+2, domain.ny+2));
    % distribute the density jump to the eulerian grid
    for i=2:bubble.pnt+1
        % density jump in x-direction
        force_x = -0.5*(bubble.y(i+1)-bubble.y(i-1))* ...
            (fluid_prop(1).rho-fluid_prop(2).rho);  
        face_x = distribute_lagrangian_to_eulerian(domain, ...
            face_x, bubble.x(i), bubble.y(i), force_x, 1);
        
        % density jump in y-direction
        force_y = 0.5*(bubble.x(i+1)-bubble.x(i-1))* ...
            (fluid_prop(1).rho-fluid_prop(2).rho); 
        face_y = distribute_lagrangian_to_eulerian(domain, ...
            face_y, bubble.x(i), bubble.y(i), force_y, 2);
    end
    
    % construct the density field using SOR
    for iter=1:param.max_iter
        old_rho = rho;
        for i=2:domain.nx+1
            for j=2:domain.ny+1
                rho(i,j) = (1.0-param.beta)*rho(i,j)+ ...
                    param.beta*0.25* ...
                   (rho(i+1,j  )+rho(i-1,j  )+ ...
                    rho(i  ,j+1)+rho(i  ,j-1)+...
                    domain.dx*face_x(i-1,j  )- ...
                    domain.dx*face_x(i  ,j  )+ ...
                    domain.dy*face_y(i  ,j-1)- ...
                    domain.dy*face_y(i  ,j  ));
            end
        end
        if max(max(abs(old_rho-rho))) < param.max_err
            break
        end
    end    
end