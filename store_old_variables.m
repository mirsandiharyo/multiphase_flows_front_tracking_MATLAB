% store the old variables for second order scheme
function[face, fluid, bubble] = store_old_variables(face, fluid, bubble)
    face.u_old = face.u;
    face.v_old = face.v;
    fluid.rho_old = fluid.rho;
    fluid.mu_old = fluid.mu;
    bubble.x_old = bubble.x;
    bubble.y_old = bubble.y;
end