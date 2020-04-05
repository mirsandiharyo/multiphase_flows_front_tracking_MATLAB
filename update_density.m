% update the density field using the normal gradient at the lagrangian
% interface
function[fluid] = update_density(domain, param, fluid_prop, bubble, fluid)
    % initialize the force
    [center_x, center_y] = deal(zeros(domain.nx+2, domain.ny+2));
    % distribute the interfacial gradient to the eulerian grid
    for i=2:bubble.pnt+1
        % calculate normal vector in x-direction
        force_x = -0.5*(bubble.y(i+1)-bubble.y(i-1))* ...
            (fluid_prop(1).rho-fluid_prop(2).rho);  
        % get the eulerian cell index
        cell_x = floor(bubble.x(i)/domain.dx)+1;
        cell_y = floor((bubble.y(i)+0.5*domain.dy)/domain.dy)+1;
        % calculate the weighing coefficient 
        coeff_x = bubble.x(i)/domain.dx-cell_x+1;
        coeff_y = (bubble.y(i)+0.5*domain.dy)/domain.dy-cell_y+1;
        % distribute the force to the surrounding eulerian cell   
        center_x(cell_x,cell_y) = center_x(cell_x,cell_y) + ...
            (1.0-coeff_x)*(1.0-coeff_y)*force_x/domain.dx/domain.dy;
        center_x(cell_x+1,cell_y) = center_x(cell_x+1,cell_y) + ...
            coeff_x*(1.0-coeff_y)*force_x/domain.dx/domain.dy;
        center_x(cell_x,cell_y+1) = center_x(cell_x,cell_y+1) + ... 
            (1.0-coeff_x)*coeff_y*force_x/domain.dx/domain.dy;      
        center_x(cell_x+1,cell_y+1) = center_x(cell_x+1,cell_y+1) + ...
            coeff_x*coeff_y*force_x/domain.dx/domain.dy;
        % calculate normal vector in y-direction
        force_y = 0.5*(bubble.x(i+1)-bubble.x(i-1))* ...
            (fluid_prop(1).rho-fluid_prop(2).rho); 
        % get the eulerian cell index        
        cell_x = floor((bubble.x(i)+0.5*domain.dx)/domain.dx)+1; 
        cell_y = floor(bubble.y(i)/domain.dy)+1;
        % calculate the weighing coefficient         
        coeff_x = (bubble.x(i)+0.5*domain.dx)/domain.dx-cell_x+1; 
        coeff_y = bubble.y(i)/domain.dy-cell_y+1; 
        % distribute the force to the surrounding eulerian cell           
        center_y(cell_x,cell_y) = center_y(cell_x,cell_y) + ...
            (1.0-coeff_x)*(1.0-coeff_y)*force_y/domain.dy/domain.dx;
        center_y(cell_x+1,cell_y) = center_y(cell_x+1,cell_y) + ...
            coeff_x*(1.0-coeff_y)*force_y/domain.dy/domain.dx;      
        center_y(cell_x,cell_y+1) = center_y(cell_x,cell_y+1) + ...
            (1.0-coeff_x)*coeff_y*force_y/domain.dy/domain.dx;
        center_y(cell_x+1,cell_y+1) = center_y(cell_x+1,cell_y+1) + ...
            coeff_x*coeff_y*force_y/domain.dy/domain.dx;
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