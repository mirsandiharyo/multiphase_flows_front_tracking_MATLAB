% update the viscosity field using harmonic averaging
function[fluid] = update_viscosity(domain,fluid_prop,fluid)
    % reinitialize viscosity field
    fluid.mu = zeros(domain.nx+2,domain.ny+2);
    % update viscosity
    fluid.mu = bsxfun(@minus,fluid.rho,fluid_prop(2).rho);
    fluid.mu = bsxfun(@times,fluid.mu, ...
        (fluid_prop(1).mu-fluid_prop(2).mu)/ ...
        (fluid_prop(1).rho-fluid_prop(2).rho));
    fluid.mu = bsxfun(@plus,fluid.mu, fluid_prop(2).mu);  
end