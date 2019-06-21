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
split_data

% process data
% proc_acc
proc_eda
proc_hr
% proc_ibi
proc_temp

% convert features to table

names = array2table([0 0 1 1 2 2 3 3 ]');

MASTER_DATA = [cell2table(eda', 'VariableNames', {'var1'}) ...
               cell2table(eda_avg', 'VariableNames', {'var2'}) ...
               cell2table(hr', 'VariableNames', {'var3'}) ... 
               cell2table(hr_avg', 'VariableNames', {'var4'}) ...
               cell2table(temp', 'VariableNames', {'var5'}) ...
               cell2table(temp_avg', 'VariableNames', {'var6'}) ...
               names]

% clean up workspace
vars = {"dur_min", "dur_sec", "clip_n", "acc_sr", "eda_sr", "hr_sr", "temp_sr", "vars"};
clear(vars{:});
