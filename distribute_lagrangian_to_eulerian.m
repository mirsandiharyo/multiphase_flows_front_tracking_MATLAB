% distribute a value from a lagrangian point to neighboring eulerian cells
function[cell] = distribute_lagrangian_to_eulerian(domain, cell, loc_x, ...
    loc_y, value, dir)
    if dir==1  % distribution in x-dir
     	% get the eulerian cell index
        index_x = floor(loc_x/domain.dx)+1;
        index_y = floor((loc_y+0.5*domain.dy)/domain.dy)+1;        
        % calculate the weighing coefficient 
        coeff_x = loc_x/domain.dx-index_x+1;
        coeff_y = (loc_y+0.5*domain.dy)/domain.dy-index_y+1;
        % assign the grid size
        d1 = domain.dx;
        d2 = domain.dy;
    elseif dir==2 % distribution in y-dir
     	% get the eulerian cell index        
        index_x = floor((loc_x+0.5*domain.dx)/domain.dx)+1; 
        index_y = floor(loc_y/domain.dy)+1;
        % calculate the weighing coefficient         
        coeff_x = (loc_x+0.5*domain.dx)/domain.dx-index_x+1; 
        coeff_y = loc_y/domain.dy-index_y+1;   
        % assign the grid size
        d1 = domain.dy;
        d2 = domain.dx;
    else
        error("direction error inside distribute_lagrangian_to_eulerian");
    end
  
    % distribute the force to the surrounding eulerian cells
    cell(index_x  ,index_y  ) = cell(index_x  ,index_y  ) + ...
        (1.0-coeff_x)*(1.0-coeff_y)*value/d1/d2;
    cell(index_x+1,index_y  ) = cell(index_x+1,index_y  ) + ...
        coeff_x*(1.0-coeff_y)*value/d1/d2;
    cell(index_x  ,index_y+1) = cell(index_x  ,index_y+1) + ... 
        (1.0-coeff_x)*coeff_y*value/d1/d2;      
    cell(index_x+1,index_y+1) = cell(index_x+1,index_y+1) + ...
        coeff_x*coeff_y*value/d1/d2;
end