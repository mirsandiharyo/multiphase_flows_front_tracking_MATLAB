% initialize the front (lagrangian marker points)
function [bubble] = initialize_front(domain, bubble)
    for n=1:domain.nbub
        % initialize the marker points position
        [bubble(n).x, bubble(n).y, bubble(n).x_old, bubble(n).y_old] = ...
            deal(zeros(1,bubble(n).pnt+2));
        % determine the location of the initial spherical bubble
        for i=1:bubble(n).pnt+2
            bubble(n).x(i) = bubble(n).cent_x-bubble(n).rad*sin(2.0*pi*(i-1) ...
                /(bubble(n).pnt));
            bubble(n).y(i) = bubble(n).cent_y+bubble(n).rad*cos(2.0*pi*(i-1) ...
                /(bubble(n).pnt));
        end
    end
end


