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
% proc_acc
proc_eda
proc_hr
% proc_ibi
proc_temp

% convert features to tables
for i = 1:clip_n
    eda_T(1:size(eda{i}, 1), i)  = eda{i};
    eda_avg_T(1:size(eda_avg{i}, 2), i) = eda_avg{i}';
    eda_diff_avg_T(1:size(eda_diff_avg{i}, 2), i) = eda_diff_avg{i}';
end

% clean up workspace
vars = {"dur_min", "dur_sec", "clip_n", "acc_sr", "eda_sr", "hr_sr", "temp_sr", "vars"};
clear(vars{:});
