% distribute a value from a lagrangian point to neighboring eulerian cells
function[cell] = distribute_lagrangian_to_eulerian(domain, cell, x, y, value, dir)
	% assign the grid size
    switch dir
        case 1 % x-dir
            d1 = domain.dx;
            d2 = domain.dy;    
        case 2 % y-dir
            d1 = domain.dy;
            d2 = domain.dx;   
        otherwise
            error("direction error inside distribute_lagrangian_to_eulerian");
    end
	% get the eulerian cell indices
    [index_x, index_y] = get_cell_index(x, y, domain.dx, domain.dy, dir); 
	% calculate the weighing coefficients
    [coeff_x, coeff_y] = get_weight_coeff(x, y, domain.dx, domain.dy, ...
        index_x, index_y, dir); 
  
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