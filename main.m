%% 
% A two-dimensional gas-liquid multiphase flows using a front-tracking type
% method. A set of Navier-Stokes equation is solved on an eulerian grid and 
% the fluid properties are advected by a front-tracking (lagrangian) scheme. 
% The code can be used to simulate a bubble rising in a rectangular box.
% Created by: Haryo Mirsandi
clear all;

%% read input file
domain = struct('lx',{},'ly',{},'nx',{},'ny',{},'x',{},'y',{}, ...
    'gravx',{},'gravy',{});
param  = struct('nsteps',{},'dt',{},'max_iter',{},'max_err',{},'beta',{});
fluid  = struct('rho',{},'mu',{},'surf',{});
bubble = struct('rad',{},'pnt',{},'cent_x','cent_y,{}','x',{},'y',{}, ...
    'x_old',{},'y_old',{},'u',{},'v',{},'tan_x',{},'tan_y',{});

[domain,param,fluid,bubble] = read_input();

%% initialize variables (liquid is at rest in the beginning)
% horizontal velocities
[u, u_temp, u_old] = deal(zeros(domain.nx+1, domain.ny+2));
% vertical velocities
[v, v_temp, v_old] = deal(zeros(domain.nx+2, domain.ny+1));
% pressure, force and temporary variables
[pres, force_x, force_y, temp1, temp2] = ...
    deal(zeros(domain.nx+2, domain.ny+2));
% center velocities (for plotting)
[u_ctr, v_ctr] = deal(zeros(domain.nx+1, domain.ny+1));

%% set the grid (staggered)
domain.x = linspace(-0.5, domain.nx+2-1.5, domain.nx+2)* ...
    (domain.lx/domain.nx);
domain.y = linspace(-0.5, domain.ny+2-1.5, domain.ny+2)* ...
    (domain.ly/domain.ny);

%% initialize the physical properties
[rho, rho_old, mu, mu_old] = ...
    initialize_physical_properties(domain, fluid, bubble);

%% set the front (gas-liquid interface)
[bubble] = initialize_front(bubble);

%% start time-loop

% calculate the surface tension force at the front (lagrangian grid)

% distribute the surface tension force from lagrangian to eulerian grid

% update the tangential velocity at boundaries

% calculate the (temporary) velocities

% calculate source term and the coefficient for pressure field

% solve pressure

% update velocities to satisfy continuity equation
 
% update the front location

% distribute interfacial gradient

% update physical properties

% reconstruct the interface

% plot the results

%% end time-loop

disp('program finished');
