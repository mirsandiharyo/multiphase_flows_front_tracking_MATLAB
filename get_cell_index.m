% fetch the indices of the eulerian cell located on the left of a given point
function[index_x, index_y] = get_cell_index(x, y, dx, dy, dir)
    switch dir
        case 1 % x-dir
            index_x = floor(x/dx)+1;
            index_y = floor((y+0.5*dy)/dy)+1;             
        case 2 % y-dir
            index_x = floor((x+0.5*dx)/dx)+1; 
            index_y = floor(y/dy)+1;
        otherwise
            error("direction error inside get_cell_index");
    end
end