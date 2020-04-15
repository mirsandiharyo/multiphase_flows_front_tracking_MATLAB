% calculate the weight coefficients of a point with respect to its location
% inside the eulerian cell
function[coeff_x, coeff_y] = get_weight_coeff(x, y, dx, dy, index_x, ...
    index_y, dir)
    switch dir
        case 1 % x-dir 
            coeff_x = x/dx-index_x+1;
            coeff_y = (y+0.5*dy)/dy-index_y+1;
        case 2 % y-dir         
            coeff_x = (x+0.5*dx)/dx-index_x+1; 
            coeff_y = y/dy-index_y+1;   
        otherwise
            error("direction error inside get_weight_coeff");
    end
end