% store second order variables
function[face, fluid, bubble] = store_2nd_order_variables(face, fluid, bubble)
    face.u = 0.5*(face.u+face.u_old);
    face.v = 0.5*(face.v+face.v_old);
    fluid.rho = 0.5*(fluid.rho+fluid.rho_old);
    fluid.mu = 0.5*(fluid.mu+fluid.mu_old);
    bubble.x = 0.5*(bubble.x+bubble.x_old);
    bubble.y = 0.5*(bubble.y+bubble.y_old);
end