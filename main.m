%% 
% A two-dimensional gas-liquid multiphase flows using a front-tracking type
% method. A set of Navier-Stokes equation is solved on an eulerian grid and 
% the fluid properties are advected by a front-tracking (lagrangian) scheme. 
% The code can be used to simulate a bubble rising in a rectangular box.
% Created by: Haryo Mirsandi
clear all;

%% define variables
param  = struct('nsteps',{},'dt',{},'max_iter',{},'max_err',{},'beta',{});
domain = struct('lx',{},'ly',{},'nx',{},'ny',{},'gravx',{},'gravy',{});
fluid_prop  = struct('rho',{},'mu',{},'surf',{});
bubble = struct('rad',{},'pnt',{},'cent_x','cent_y,{}','x',{},'y',{}, ...
    'x_old',{},'y_old',{},'u',{},'v',{},'tan_x',{},'tan_y',{});
face   = struct('x',{},'y',{},'u',{},'v',{},'u_old',{},'v_old',{}, ...
    'u_temp',{},'v_temp',{});
center = struct('press',{},'force_x',{},'force_y',{},'u',{},'v',{}, ...
    'temp1',{},'temp2',{});
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
for is=1:nstep,is
%     % store second order variables
%     [bubble] = store_old_variables(bubble);
%     u_old = u;
%     v_old = u;
%     rho_old = rho;
%     mu_old = mu;
%     bubble.x_old = bubble.x;
%     bubble.y_old = bubble.y;
    for substep=1:2  % second order loop
        % calculate the surface tension force at the front (lagrangian grid)

        % distribute the surface tension force from lagrangian
        % to eulerian grid

        % update the tangential velocity at boundaries

        % calculate the (temporary) velocities

        % calculate source term and the coefficient for pressure field

        % solve pressure

        % update velocities to satisfy continuity equation

        % update the front location

        % distribute interfacial gradient

        % update physical properties
  end
% reconstruct the interface

% plot the results

%% end time-loop
end
disp('program finished');
