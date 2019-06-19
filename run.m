% run.m: master script

% make graphs folder
mkdir("graphs");

% set globals
dur_min = .1;
dur_sec = 60 * dur_min;
clip_n = 8;

% useful constants
acc_sr = 32; % hertz
eda_sr = 4; % hertz
hr_sr = 1; % hertz
temp_sr = 4; % hertz 

% generate data groups
split

% process data
proc_acc
proc_eda
proc_hr
% proc_ibi
proc_temp

% clean up workspace
vars = {"dur_min", "dur_sec", "clip_n", "acc_sr", "eda_sr", "hr_sr", "temp_sr", "vars"};
clear(vars{:});
