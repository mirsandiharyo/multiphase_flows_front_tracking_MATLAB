% interpolate velocities located on eulerian cells to a lagrangian marker point
function[vel] = interpolate_velocity(domain, face_vel, loc_x, loc_y, dir)
    if dir==1  % interpolation in x-dir
        % get the eulerian cell index
        index_x = floor(loc_x/domain.dx)+1;
        index_y = floor((loc_y+0.5*domain.dy)/domain.dy)+1;
        % calculate the weighing coefficient
        coeff_x = loc_x/domain.dx-index_x+1;
        coeff_y = (loc_y+0.5*domain.dy)/domain.dy-index_y+1;      
    elseif dir==2  % interpolation in y-dir
        % marker location in y direction
        % get the eulerian cell index        
        index_x = floor((loc_x+0.5*domain.dx)/domain.dx)+1; 
        index_y = floor(loc_y/domain.dy)+1;
        % calculate the weighing coefficient        
        coeff_x = (loc_x+0.5*domain.dx)/domain.dx-index_x+1;
        coeff_y = loc_y/domain.dy-index_y+1;        
    else
        error("direction error inside interpolate_velocity");
    end
    
    % interpolate the surrounding velocities to the marker location
    vel = (1.0-coeff_x)*(1.0-coeff_y)*face_vel(index_x  ,index_y  )+ ...
               coeff_x *(1.0-coeff_y)*face_vel(index_x+1,index_y  )+ ...
          (1.0-coeff_x)*     coeff_y *face_vel(index_x  ,index_y+1)+ ...
               coeff_x *     coeff_y *face_vel(index_x+1,index_y+1);  
end