% read simulation parameters from input.txt 
function [domain,param,fluid,bubble]=read_input()
    disp('read input file');
    fid = fopen('input.txt');
    % solver parameters
    read_line = fgetl(fid); %#ok<*NASGU>
    read_line = regexp(fgetl(fid), '=', 'split');
    param(1).nsteps = str2double(read_line{2});
    read_line = regexp(fgetl(fid), '=', 'split');
    param(1).dt = str2double(read_line{2}); 
    read_line = regexp(fgetl(fid), '=', 'split');
    param(1).max_iter = str2double(read_line{2});
    read_line = regexp(fgetl(fid), '=', 'split');
    param(1).max_err = str2double(read_line{2});
    read_line = regexp(fgetl(fid), '=', 'split');
    param(1).beta = str2double(read_line{2});
    read_line = regexp(fgetl(fid), '=', 'split');
    read_line = fgetl(fid);    
    % numerical parameters
    read_line = regexp(fgetl(fid), '=', 'split');
    domain(1).lx = str2double(read_line{2});
    read_line = regexp(fgetl(fid), '=', 'split');
    domain(1).ly = str2double(read_line{2});
    read_line = regexp(fgetl(fid), '=', 'split');
    domain(1).nx = str2double(read_line{2});
    read_line = regexp(fgetl(fid), '=', 'split');
    domain(1).ny = str2double(read_line{2});
    read_line = regexp(fgetl(fid), '=', 'split');
    domain(1).gravx = str2double(read_line{2});
    read_line = regexp(fgetl(fid), '=', 'split');
    domain(1).gravy = str2double(read_line{2});
    read_line = fgetl(fid);
    % physical properties
    % dispersed phase
    read_line = fgetl(fid);
    read_line = fgetl(fid);    
    read_line = regexp(fgetl(fid), '=', 'split');
    fluid(1).rho = str2double(read_line{2});
    read_line = regexp(fgetl(fid), '=', 'split');
    fluid(1).mu = str2double(read_line{2});
    read_line = regexp(fgetl(fid), '=', 'split');
    fluid(1).surf = str2double(read_line{2});
    % continuous phase
    read_line = fgetl(fid);
    read_line = regexp(fgetl(fid), '=', 'split');
    fluid(2).rho = str2double(read_line{2});
    read_line = regexp(fgetl(fid), '=', 'split');
    fluid(2).mu = str2double(read_line{2});
    fluid(2).surf = fluid(1).surf;
    read_line = fgetl(fid);
    % bubble size and location
    read_line = fgetl(fid);    
    read_line = regexp(fgetl(fid), '=', 'split');
    bubble(1).rad = str2double(read_line{2});
    read_line = regexp(fgetl(fid), '=', 'split');
    bubble(1).x = str2double(read_line{2});
    read_line = regexp(fgetl(fid), '=', 'split');
    bubble(1).y = str2double(read_line{2});
    fclose(fid);
end
