% store second order variables
function[face, fluid, bubble] = store_2nd_order_variables(domain, face, ...
    fluid, bubble)
    face.u = 0.5*(face.u+face.u_old);
    face.v = 0.5*(face.v+face.v_old);
    fluid.rho = 0.5*(fluid.rho+fluid.rho_old);
    fluid.mu = 0.5*(fluid.mu+fluid.mu_old);
    for n=1:domain.nbub
        bubble(n).x = 0.5*(bubble(n).x+bubble(n).x_old);
        bubble(n).y = 0.5*(bubble(n).y+bubble(n).y_old);
    end
end