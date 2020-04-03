%% 
% A two-dimensional gas-liquid multiphase flows using a front-tracking type
% method. A Navier-Stokes equation is solved and the fluid properties are 
% advected by a front-tracking scheme. The code can be used to simulate a 
% bubble rising in a rectangular box.
% Created by: Haryo Mirsandi
clear all;

%% read input file
domain = struct('lx',{},'ly',{},'nx',{},'ny',{},'gravx',{},'gravy',{});
param  = struct('nsteps',{},'dt',{},'max_iter',{},'max_err',{},'beta',{});
fluid  = struct('rho',{},'mu',{},'surf',{});
bubble = struct('rad',{},'x',{},'y',{});

[domain,param,fluid,bubble]=read_input();

%% initialize variables


%% set the grid

%% set the front (gas-liquid interface)

%% set the physical properties

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
