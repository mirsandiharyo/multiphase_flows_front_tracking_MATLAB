% advect the location of marker points using the interpolated velocity
% field
function[bubble] = update_front_location(param, domain, face, bubble)
    % interpolate the velocity from the eulerian grid to the location of
    % marker point
    for i=2:bubble.pnt+1
        % marker location in x direction
        % get the eulerian cell index
        cell_x = floor(bubble.x(i)/domain.dx)+1;
        cell_y = floor((bubble.y(i)+0.5*domain.dy)/domain.dy)+1;
        % calculate the weighing coefficient
        coeff_x = bubble.x(i)/domain.dx-cell_x+1;
        coeff_y = (bubble.y(i)+0.5*domain.dy)/domain.dy-cell_y+1;
        % interpolate the velocity
        u_x = (1.0-coeff_x)*(1.0-coeff_y)*face.u(cell_x  ,cell_y  )+ ...
                   coeff_x *(1.0-coeff_y)*face.u(cell_x+1,cell_y  )+ ...
              (1.0-coeff_x)*     coeff_y *face.u(cell_x  ,cell_y+1)+ ...
                   coeff_x *     coeff_y *face.u(cell_x+1,cell_y+1);
        % advect the marker point
        bubble.x(i) = bubble.x(i)+param.dt*u_x;
        % marker location in y direction
        % get the eulerian cell index        
        cell_x = floor((bubble.x(i)+0.5*domain.dx)/domain.dx)+1; 
        cell_y = floor(bubble.y(i)/domain.dy)+1;
        % calculate the weighing coefficient        
        coeff_x = (bubble.x(i)+0.5*domain.dx)/domain.dx-cell_x+1;
        coeff_y = bubble.y(i)/domain.dy-cell_y+1;
        % interpolate the velocity        
        u_y = (1.0-coeff_x)*(1.0-coeff_y)*face.v(cell_x  ,cell_y  )+ ...
                   coeff_x *(1.0-coeff_y)*face.v(cell_x+1,cell_y  )+ ...
              (1.0-coeff_x)*     coeff_y *face.v(cell_x  ,cell_y+1)+ ...
                   coeff_x *     coeff_y *face.v(cell_x+1,cell_y+1);
        % advect the marker point
        bubble.y(i) = bubble.y(i)+param.dt*u_y;
   end
    bubble.x(1) = bubble.x(bubble.pnt+1);
    bubble.y(1) = bubble.y(bubble.pnt+1);
    bubble.x(bubble.pnt+2) = bubble.x(2);
    bubble.y(bubble.pnt+2) = bubble.y(2);    
end