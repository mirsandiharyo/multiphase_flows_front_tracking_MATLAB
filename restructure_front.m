% restructure the front to maintain the quality of the interface
function[bubble] = restructure_front(domain, bubble)
    bubble.x_old = bubble.x;
    bubble.y_old = bubble.y;
    j = 1;
    for i=2:bubble.pnt+1
        % check the distance
        dst = sqrt(((bubble.x_old(i)-bubble.x(j))/domain.dx)^2 + ...
                   ((bubble.y_old(i)-bubble.y(j))/domain.dy)^2);        
        if (dst > 0.5) % too big
         	% add marker points
            j = j+1;
            bubble.x(j) = 0.5*(bubble.x_old(i)+bubble.x(j-1));
            bubble.y(j) = 0.5*(bubble.y_old(i)+bubble.y(j-1));
            j = j+1;
            bubble.x(j) = bubble.x_old(i);
            bubble.y(j) = bubble.y_old(i);
        elseif (dst < 0.25) % too small
            % do nothing  
        else
            j = j+1;
            bubble.x(j) = bubble.x_old(i);
            bubble.y(j) = bubble.y_old(i);
        end
    end
    bubble.pnt = j-1;
    bubble.x(1) = bubble.x(bubble.pnt+1);
    bubble.y(1) = bubble.y(bubble.pnt+1);
    bubble.x(bubble.pnt+2) = bubble.x(2);
    bubble.y(bubble.pnt+2) = bubble.y(2);
end