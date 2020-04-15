% update the viscosity field using harmonic averaging
function[mu] = update_viscosity(fluid_prop, rho)
    mu = bsxfun(@minus,rho,fluid_prop(2).rho);
    mu = bsxfun(@times,mu,(fluid_prop(1).mu-fluid_prop(2).mu)/ ...
        (fluid_prop(1).rho-fluid_prop(2).rho));
    mu = bsxfun(@plus,mu,fluid_prop(2).mu);  
end