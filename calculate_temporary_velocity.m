% calculate the temporary velocities without accounting for the pressure
% (first step of the second order projection method)
function[face] = calculate_temporary_velocity(param, domain, ...
    fluid_prop, fluid, face)
    % temporary u velocity (advection term)
    for i=2:domain.nx
        for j=2:domain.ny+1
            face.u_temp(i,j) = face.u(i,j)+param.dt*(-0.25* ...
                (((face.u(i+1,j  )+face.u(i  ,j  ))^2- ...
                  (face.u(i  ,j  )+face.u(i-1,j  ))^2)/domain.dx+ ...
                 ((face.u(i  ,j+1)+face.u(i  ,j  ))* ...
                  (face.v(i+1,j  )+face.v(i  ,j  ))- ...
                  (face.u(i  ,j  )+face.u(i  ,j-1))* ...
                  (face.v(i+1,j-1)+face.v(i  ,j-1)))/domain.dy)+ ...
                   face.force_x(i,j)/ ...
                  (0.5*(fluid.rho(i+1,j)+fluid.rho(i,j)))- ...
                  (1.0 -fluid_prop(2).rho/ ...
                  (0.5*(fluid.rho(i+1,j)+fluid.rho(i,j))))*domain.gravx);
        end
    end

    % temporary v velocity (advection term)
    for i=2:domain.nx+1
        for j=2:domain.ny
            face.v_temp(i,j) = face.v(i,j)+param.dt*(-0.25* ...
                (((face.u(i  ,j+1)+face.u(i  ,j  ))* ...
                  (face.v(i+1,j  )+face.v(i  ,j  ))- ...
                  (face.u(i-1,j+1)+face.u(i-1,j  ))* ...
                  (face.v(i  ,j  )+face.v(i-1,j  )))/domain.dx+ ...
                 ((face.v(i  ,j+1)+face.v(i  ,j  ))^2- ...
                  (face.v(i  ,j  )+face.v(i  ,j-1))^2)/domain.dy)+ ...
                   face.force_y(i,j)/ ...
                  (0.5*(fluid.rho(i,j+1)+fluid.rho(i,j)))- ...
                  (1.0 -fluid_prop(2).rho/ ...
                  (0.5*(fluid.rho(i,j+1)+fluid.rho(i,j))))*domain.gravy);
        end
    end

    % temporary u velocity (diffusion term)
    for i=2:domain.nx
        for j=2:domain.ny+1
            face.u_temp(i,j) = face.u_temp(i,j)+param.dt*((1./domain.dx)*2.* ...
            (fluid.mu(i+1,j  )*(1./domain.dx)*(face.u(i+1,j  )-face.u(i  ,j  )) - ... 
             fluid.mu(i  ,j  )*(1./domain.dx)*(face.u(i  ,j  )-face.u(i-1,j  )))+ ...
             (1./domain.dy)*(0.25* ...
            (fluid.mu(i  ,j  )+fluid.mu(i+1,j  )+ ...          
             fluid.mu(i+1,j+1)+fluid.mu(i  ,j+1))* ...                              
            ((1./domain.dy)*(face.u(i  ,j+1)-face.u(i  ,j  ))+ ... 
             (1./domain.dx)*(face.v(i+1,j  )-face.v(i  ,j  )))-0.25* ...
            (fluid.mu(i  ,j  )+fluid.mu(i+1,j  )+ ...
             fluid.mu(i+1,j-1)+fluid.mu(i  ,j-1))* ...
            ((1./domain.dy)*(face.u(i  ,j  )-face.u(i  ,j-1))+ ...
             (1./domain.dx)*(face.v(i+1,j-1)-face.v(i  ,j-1)))))/ ...
             (0.5*(fluid.rho(i+1,j)+fluid.rho(i,j)));
        end
    end

    % temporary v velocity (diffusion term)
    for i=2:domain.nx+1
        for j=2:domain.ny
            face.v_temp(i,j) = face.v_temp(i,j)+param.dt*((1./domain.dx)*(0.25* ...
            (fluid.mu(i  ,j  )+fluid.mu(i+1,j  )+ ...
             fluid.mu(i+1,j+1)+fluid.mu(i,j+1  ))* ...
            ((1./domain.dy)*(face.u(i  ,j+1)-face.u(i  ,j  ))+ ...                    
             (1./domain.dx)*(face.v(i+1,j  )-face.v(i  ,j  )))-0.25* ...              
            (fluid.mu(i  ,j  )+fluid.mu(i  ,j+1)+ ...                                
             fluid.mu(i-1,j+1)+fluid.mu(i-1,j  ))* ...                                
            ((1./domain.dy)*(face.u(i-1,j+1)-face.u(i-1,j  ))+ ...
             (1./domain.dx)*(face.v(i  ,j  )-face.v(i-1,j  ))))+ ...
             (1./domain.dy)*2.* ...
            (fluid.mu(i  ,j+1)*(1./domain.dy)*(face.v(i  ,j+1)-face.v(i  ,j  ))- ...  
             fluid.mu(i  ,j  )*(1./domain.dy)*(face.v(i  ,j  )-face.v(i  ,j-1))))/ ...
             (0.5*(fluid.rho(i,j+1)+fluid.rho(i,j)));                                   
        end
    end
end