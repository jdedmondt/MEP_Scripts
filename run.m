% run.m: master script

% make graphs folder
mkdir("graphs");

% set globals
dur_min = .1;
dur_sec = 60 * dur_min;
sessions = 3;
clip_n = 8*sessions;

% useful constants
acc_sr = 32; % hertz
eda_sr = 4; % hertz)
hr_sr = 1; % hertz
temp_sr = 4; % hertz 

% merge CSV files
ACC = [ACC_1; ACC_2; ACC_3];
EDA = [EDA_1;EDA_2;EDA_3];
HR = [HR_1;HR_2;HR_3];
TEMP = [TEMP_1;TEMP_2;TEMP_3];

% generate data groups
split_data

% process data
% proc_acc
proc_eda
proc_hr
% proc_ibi
proc_temp

% generate feature table which will be sent to the classifier
%gen_table

% clean up workspace
vars = {"dur_min", "dur_sec", "clip_n", "acc_sr", "eda_sr", "hr_sr", "temp_sr", "vars"};
clear(vars{:});
