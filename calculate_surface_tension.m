% calculate the surface tension force on the lagrangian grid and distribute
% it to the surrounding eulerian grid cells
function[face] = calculate_surface_tension(domain, bubble, ...
    fluid_prop, face)
    % initialize the variables to store the tangent vector
    [tan_x, tan_y] = deal(zeros(bubble.pnt+2, bubble.pnt+2));
    
    % calculate the tangent vector
    for i=1:bubble.pnt+1
        dist = sqrt((bubble.x(i+1)-bubble.x(i))^2 + ...
            (bubble.y(i+1)-bubble.y(i))^2);
        tan_x(i) = (bubble.x(i+1)-bubble.x(i))/dist;
        tan_y(i) = (bubble.y(i+1)-bubble.y(i))/dist;
    end
    tan_x(bubble.pnt+2) = tan_x(2);
    tan_y(bubble.pnt+2) = tan_y(2);
    
    % distribute the surface tension force to the eulerian grid
    for i=2:bubble.pnt+1
        % force in x-direction
        force_x = fluid_prop(1).sigma*(tan_x(i)-tan_x(i-1));
        face.force_x = distribute_lagrangian_to_eulerian(domain, ...
            face.force_x, bubble.x(i), bubble.y(i), force_x, 1);
        
        % force in y-direction
        force_y = fluid_prop(1).sigma*(tan_y(i)-tan_y(i-1));
        face.force_y = distribute_lagrangian_to_eulerian(domain, ...
            face.force_y, bubble.x(i), bubble.y(i), force_y, 2);
    end   
end
