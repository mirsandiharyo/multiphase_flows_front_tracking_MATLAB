%% 
% A two-dimensional gas-liquid multiphase flows using a front-tracking type
% method. A set of Navier-Stokes equation is solved on a eulerian grid 
% using a second order projection method. The fluid properties are advected 
% by lagrangian marker points. The code can be used to simulate a bubble 
% rising in a rectangular box.
% Created by: Haryo Mirsandi
% clear all;

%% define variables
param  = struct('nstep',{},'time',{},'dt',{},'max_iter',{},'max_err',{}, ...
    'beta',{});
domain = struct('lx',{},'ly',{},'nx',{},'ny',{},'dx',{},'dy',{}, ...
    'gravx',{},'gravy',{});
fluid_prop  = struct('rho',{},'mu',{},'sigma',{});
bubble = struct('rad',{},'pnt',{},'cent_x','cent_y,{}','x',{},'y',{}, ...
    'x_old',{},'y_old',{});
face   = struct('x',{},'y',{},'u',{},'v',{},'u_old',{},'v_old',{}, ...
    'u_temp',{},'v_temp',{});
center = struct('press',{},'force_x',{},'force_y',{});
fluid  = struct('rho',{},'rho_old',{},'mu',{},'mu_old',{});

%% read input file
[domain,param,fluid_prop,bubble] = read_input();

%% initialize variables (liquid is at rest at the beginning)
[face, center] = initialize_variables(domain);

%% initialize the physical properties
[fluid] = initialize_physical_properties(domain, face, fluid_prop, bubble);

%% set the front (gas-liquid interface)
[bubble] = initialize_front(bubble);

%% start time-loop
param.time = 0.0;
for nstep=1:param.nstep

    % store second order variables
    [face, fluid, bubble] = store_old_variables(face, fluid, bubble);

    for substep=1:2  % second order loop
        % calculate the surface tension force at the front (lagrangian grid)
        % and distribute it to eulerian grid
        [center.force_x, center.force_y] = calculate_surface_tension ...
            (domain, bubble, fluid_prop);

        % update the tangential velocity at boundaries
        [face] = update_wall_velocity(domain, face);
        
        % calculate the (temporary) velocity
        [face] = calculate_temporary_velocity(param, domain, fluid_prop, ...
            fluid, center, face);
        
        % solve pressure
        [center.pres] = solve_pressure(domain, param, fluid, face);
        
        % correct the velocity to satisfy continuity equation
        [face] = correct_velocity(domain, param, center, fluid, face);
        
        % update the front location 
        [bubble] = update_front_location(param, domain, face, bubble);

        % update physical properties
        [fluid] = update_density(domain, param, fluid_prop, bubble, fluid);
        [fluid] = update_viscosity(domain, fluid_prop, fluid);
        
        % store second order variables
        [face, fluid, bubble] = store_2nd_order_variables(face, fluid, bubble);
    end
    % restructure the front
    
    % visualize the results
    param.time = param.time+param.dt;
    visualize_results(domain, face, fluid, bubble, fluid_prop, param.time)
%% end time-loop
end
disp('program finished');
