% set globals
dur_min = .5;
dur_sec = 60 * dur_min;

% useful constants
acc_sr = 32; % hertz
eda_sr = 4; % hertz
hr_sr = 1; % hertz
temp_sr = 4; % hertz 

% generate data groups
split


% proc_acc
% proc_eda
% proc_hr
% proc_ibi
% proc_temp

% clean up workspace
vars = {"dur_min", "dur_sec", "acc_sr", "eda_sr", "hr_sr", "temp_sr", "vars"};
clear(vars{:});
