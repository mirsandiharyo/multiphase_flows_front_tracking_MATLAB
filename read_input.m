% read simulation parameters from input.txt 
function [domain, param, fluid_prop, bubble] = read_input()
    disp('choose the input file (.txt)');
    [input_name, file_path] = uigetfile('.txt');
    origin_path = pwd;
    cd(file_path);
    fid = fopen(input_name);
    cd(origin_path);
    % solver parameters
    read_line = fgetl(fid); %#ok<*NASGU>
    read_line = regexp(fgetl(fid), '=', 'split');
    param(1).nstep = str2double(read_line{2});
    read_line = regexp(fgetl(fid), '=', 'split');
    param(1).dt = str2double(read_line{2}); 
    read_line = regexp(fgetl(fid), '=', 'split');
    param(1).max_iter = str2double(read_line{2});
    read_line = regexp(fgetl(fid), '=', 'split');
    param(1).max_err = str2double(read_line{2});
    read_line = regexp(fgetl(fid), '=', 'split');
    param(1).beta = str2double(read_line{2});
    read_line = regexp(fgetl(fid), '=', 'split');
    param(1).out_freq = str2double(read_line{2});
    read_line = fgetl(fid);
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
    domain(1).dx = domain(1).lx/domain(1).nx;
    domain(1).dy = domain(1).ly/domain(1).ny;    
    read_line = fgetl(fid);
    % physical properties
    % dispersed phase
    read_line = fgetl(fid);
    read_line = fgetl(fid);    
    read_line = regexp(fgetl(fid), '=', 'split');
    fluid_prop(1).rho = str2double(read_line{2});
    read_line = regexp(fgetl(fid), '=', 'split');
    fluid_prop(1).mu = str2double(read_line{2});
    read_line = regexp(fgetl(fid), '=', 'split');
    fluid_prop(1).sigma = str2double(read_line{2});
    % continuous phase
    read_line = fgetl(fid);
    read_line = regexp(fgetl(fid), '=', 'split');
    fluid_prop(2).rho = str2double(read_line{2});
    read_line = regexp(fgetl(fid), '=', 'split');
    fluid_prop(2).mu = str2double(read_line{2});
    fluid_prop(2).sigma = fluid_prop(1).sigma;
    read_line = fgetl(fid);
    % bubble size and location
    read_line = fgetl(fid);
    read_line = regexp(fgetl(fid), '=', 'split');
    domain(1).nbub = str2double(read_line{2});
    for i=1:domain.nbub
        read_line = regexp(fgetl(fid), '=', 'split');
        bubble(i).rad = str2double(read_line{2});
        read_line = regexp(fgetl(fid), '=', 'split');
        bubble(i).cent_x = str2double(read_line{2});
        read_line = regexp(fgetl(fid), '=', 'split');
        bubble(i).cent_y = str2double(read_line{2});
        read_line = regexp(fgetl(fid), '=', 'split');
        bubble(i).pnt = str2double(read_line{2});
    end
    fclose(fid);
end
