% initialize fluid properties 
function [rho, rho_old, mu, mu_old]= ...
    initialize_physical_properties(domain, fluid, bubble)
    % initialize the density and viscosity using values from the 
    % continuous phase
    [rho, rho_old] = deal(zeros(domain.nx+2, domain.ny+2)+fluid(2).rho);
    [mu, mu_old]   = deal(zeros(domain.nx+2, domain.ny+2)+fluid(2).mu);
    % set the physical properties inside the discrete phase (bubble)
    for i=2:domain.nx+1
       for j=2:domain.ny+1
          if ( (domain.x(i)-bubble.x)^2+(domain.y(j)-bubble.y)^2 < bubble.rad^2)
              rho(i,j)=fluid(1).rho;
              mu(i,j)=fluid(1).rho;
          end
       end
    end
    pcolor(rho);
end
