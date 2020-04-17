% initialize physical properties 
function [fluid] = ...
    initialize_physical_properties(domain, center, fluid_prop, bubble)
    % initialize the density and viscosity using values from the 
    % continuous phase
    [fluid(1).rho, fluid(1).rho_old] = ...
        deal(zeros(domain.nx+2, domain.ny+2)+fluid_prop(2).rho);
    [fluid(1).mu, fluid(1).mu_old] =  ...
        deal(zeros(domain.nx+2, domain.ny+2)+fluid_prop(2).mu);
    
    % set the physical properties inside the discrete phase (bubble) with
    % an initial spherical shape
    for i=2:domain.nx+1
       for j=2:domain.ny+1
           for n=1:domain.nbub
              if ((center.x(i)-bubble(n).cent_x)^2+ ...
                  (center.y(j)-bubble(n).cent_y)^2 < bubble(n).rad^2)
                  fluid(1).rho(i,j) = fluid_prop(1).rho;
                  fluid(1).mu(i,j)  = fluid_prop(1).mu;
              end
           end
       end
    end
end