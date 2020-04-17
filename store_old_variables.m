% store the old variables for second order scheme
function[face, fluid, bubble] = store_old_variables(domain, face, fluid, bubble)
    face.u_old = face.u;
    face.v_old = face.v;
    fluid.rho_old = fluid.rho;
    fluid.mu_old = fluid.mu;
    for n=1:domain.nbub
        bubble(n).x_old = bubble(n).x;
        bubble(n).y_old = bubble(n).y;
    end
end