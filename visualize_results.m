function[]=visualize_results(domain, face, fluid, bubble, fluid_prop, time)
    % calculate velocity at cell center 
    u_center(1:domain.nx+1,1:domain.ny+1) = 0.5* ...
        (face.u(1:domain.nx+1,2:domain.ny+2)+ ...
         face.u(1:domain.nx+1,1:domain.ny+1));
    v_center(1:domain.nx+1,1:domain.ny+1) = 0.5* ...
        (face.v(2:domain.nx+2,1:domain.ny+1)+ ...
         face.v(1:domain.nx+1,1:domain.ny+1));
    % calculate phase fraction     
    alpha = bsxfun(@minus,fluid.rho,fluid_prop(2).rho);
    alpha = bsxfun(@times,alpha,1/(fluid_prop(1).rho-fluid_prop(2).rho));  
    % create the grid (cell center)
    grid_x = linspace(0, domain.nx, domain.nx+1)*domain.dx;
    grid_y = linspace(0, domain.ny, domain.ny+1)*domain.dy;
    hold off, 
    % plot contour of density field    
    contour(face.x,face.y,flipud(rot90(fluid.rho)),'linewidth',1), ...
    axis equal, axis([0 domain.lx 0 domain.ly]);
    hold on;
    % plot phase field    
    imagesc(face.x,face.y,flipud(rot90(alpha)),'AlphaData',0.9),
    colormap('jet'),colorbar,caxis([0 1]);
    % set colorbar title
    ph = colorbar;
    colorTitleHandle = get(ph,'Title');
    caption = 'Phase fraction';
    set(colorTitleHandle ,'String',caption,'FontSize', 10);
    % plot velocity vector    
    quiver(grid_x,grid_y,flipud(rot90(u_center)),flipud(rot90(v_center)),'r');
    % plot the marker points
    plot(bubble.x,bubble.y,'k','linewidth',2);
    % set title
    caption = sprintf('Time = %f', time);
	title(caption, 'FontSize', 10);     
    pause(0.01)
end