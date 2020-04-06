% initialize the front (lagrangian marker points)
function [bubble] = initialize_front(bubble)
    % initialize the marker points position
    [bubble.x, bubble.y, bubble.x_old, bubble.y_old] = ...
        deal(zeros(1,bubble.pnt+2));
    % determine the location of the initial spherical bubble
    for i=1:bubble.pnt+2
        bubble.x(i) = bubble.cent_x-bubble.rad*sin(2.0*pi*(i-1) ...
            /(bubble.pnt));
        bubble.y(i) = bubble.cent_y+bubble.rad*cos(2.0*pi*(i-1) ...
            /(bubble.pnt));
    end
end


