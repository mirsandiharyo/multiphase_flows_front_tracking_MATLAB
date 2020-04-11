% advect the location of marker points using the interpolated velocity
% field
function[bubble] = update_front_location(param, domain, face, bubble)
    % interpolate the velocity from the eulerian grid to the location of
    % marker point   
    [u_x, u_y] = deal(zeros(1,bubble.pnt+2));
    for i=2:bubble.pnt+1
        % interpolate velocity in x-direction
        u_x(i) = interpolate_velocity(domain, face.u, bubble.x(i), ...
            bubble.y(i), 1);
        % interpolate velocity in y-direction
        u_y(i) = interpolate_velocity(domain, face.v, bubble.x(i), ...
            bubble.y(i), 2);
    end
    
	% advect the marker point 
	for i=2:bubble.pnt+1
        bubble.x(i) = bubble.x(i)+param.dt*u_x(i);
        bubble.y(i) = bubble.y(i)+param.dt*u_y(i);
	end
    bubble.x(1) = bubble.x(bubble.pnt+1);
    bubble.y(1) = bubble.y(bubble.pnt+1);
    bubble.x(bubble.pnt+2) = bubble.x(2);
    bubble.y(bubble.pnt+2) = bubble.y(2);   
end