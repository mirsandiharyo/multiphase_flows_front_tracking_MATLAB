%% 
% A two-dimensional gas-liquid multiphase flows using a front-tracking type
% method. A set of Navier-Stokes equation is solved on a eulerian grid 
% using a second order projection method. The fluid properties are advected 
% by lagrangian marker points. The time marching is second order by using 
% predictor-corrector method. The code can be used to simulate a bubble 
% rising in a rectangular box.
% Created by: Haryo Mirsandi

%% initialization
% clean output folder
mkdir output;
delete output/bub_*;

% read input file
[domain, param, fluid_prop, bubble] = read_input();

% initialize variables (grid, velocity, pressure, and force)
[face, center] = initialize_variables(domain);

% initialize the physical properties
[fluid] = initialize_physical_properties(domain, center, fluid_prop, bubble);

% set the initial front (gas-liquid interface)
[bubble] = initialize_front(domain, bubble);

%% start time-loop
param.time = 0.0;

% visualize the initial condition
visualize_results(domain, face, center, fluid, bubble, fluid_prop, ...
    param.time, 0);

for nstep=1:param.nstep
    % store second order variables
    [face, fluid, bubble] = store_old_variables(domain, face, fluid, bubble);

    for substep=1:2  % second order loop
        % calculate the surface tension force at the front (lagrangian grid)
        % and distribute it to eulerian grid
        [face.force_x, face.force_y] = deal(zeros(domain.nx+2, domain.ny+2));
        for n=1:domain.nbub
            [face] = calculate_surface_tension(domain, bubble(n), ...
                fluid_prop, face);
        end
        
        % update the tangential velocity at boundaries
        [face] = update_wall_velocity(domain, face);

        % calculate the (temporary) velocity
        [face] = calculate_temporary_velocity(param, domain, fluid_prop, ...
            fluid, face);

        % solve pressure
        [center.pres] = solve_pressure(domain, param, fluid, face, ...
            center.pres);
        
        % correct the velocity by adding the pressure gradient
        [face] = correct_velocity(domain, param, center, fluid, face);
        
        % update the front location
        for n=1:domain.nbub
            [bubble(n)] = update_front_location(param, domain, face, bubble(n));
        end
        
        % update physical properties
        [fluid.rho] = update_density(domain, param, fluid_prop, bubble, ...
            fluid.rho);
        [fluid.mu] = update_viscosity(fluid_prop, fluid.rho);  
    end
    % store second order variables
	[face, fluid, bubble] = store_2nd_order_variables(domain, face, fluid, ...
        bubble);
    
    % restructure the front
    for n=1:domain.nbub
        [bubble(n)] = restructure_front(domain, bubble(n));
    end
    
    % visualize the results
    param.time = param.time+param.dt;
    if mod(nstep, param.out_freq) == 0
        visualize_results(domain, face, center, fluid, bubble, fluid_prop, ...
            param.time, nstep);
    end
end
%% end time-loop
disp('program finished');
