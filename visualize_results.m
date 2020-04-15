% visualize the phase fraction field, velocity vector, velocity contour and
% marker points
function[] = visualize_results(domain, face, center, fluid, bubble, ...
    fluid_prop, time, nstep)
    % calculate velocity at cell center 
    u_center(1:domain.nx+1,1:domain.ny+1) = 0.5* ...
        (face.u(1:domain.nx+1,2:domain.ny+2)+ ...
         face.u(1:domain.nx+1,1:domain.ny+1));
    v_center(1:domain.nx+1,1:domain.ny+1) = 0.5* ...
        (face.v(2:domain.nx+2,1:domain.ny+1)+ ...
         face.v(1:domain.nx+1,1:domain.ny+1));
    vel_mag = sqrt(u_center.^2 + v_center.^2);
    % calculate phase fraction     
    alpha = bsxfun(@minus,fluid.rho,fluid_prop(2).rho);
    alpha = bsxfun(@times,alpha,1/(fluid_prop(1).rho-fluid_prop(2).rho));
    % create the grid
    grid_x = linspace(0, domain.nx, domain.nx+1)*domain.dx;
    grid_y = linspace(0, domain.ny, domain.ny+1)*domain.dy;
    hold off, 
    % plot contour of velocity magnitude    
    contour(grid_x,grid_y,flipud(rot90(vel_mag)),'linewidth',1.5), ...
    axis equal, axis([0 domain.lx 0 domain.ly]);
    hold on;
    % plot phase field
    imagesc(center.x,center.y,flipud(rot90(alpha)),'AlphaData',0.9),
    colormap('jet'),colorbar,caxis([0 1]);
    % set colorbar title
    ph = colorbar;
    colorTitleHandle = get(ph,'Title');
    caption = 'Phase fraction';
    set(colorTitleHandle ,'String',caption,'FontSize', 10);
    % plot velocity vector    
    quiver(grid_x,grid_y,flipud(rot90(u_center)),flipud(rot90(v_center)),'w');
    % plot the marker points
    h = plot(bubble.x(1:bubble.pnt),bubble.y(1:bubble.pnt),'k','linewidth',2);
    % set title
    caption = sprintf('Time = %f s', time);
	title(caption, 'FontSize', 10);     
    pause(0.001)
    % save the plot     
    caption = sprintf('output/bub_%03d.png',nstep);
    saveas(h, caption);
end