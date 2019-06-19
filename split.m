% split.m: split csv files into raw data accoring to clip timestamps

% timestamps
starts = [0*60+10 4*60+9 9*60+9 13*60+19 18*60+51 19*60+23 21*60+30 26*60+48]; % start timestamps of each clip in seconds
ends = [4*60+8 6*60+3 13*60+18 17*60+53 19*60+22 20*60+55 26*60+47 29*60+40]; % end timestamps of each clip in seconds

% get raw data
acc_raw = table2array(ACC);
eda_raw = table2array(EDA);
hr_raw = table2array(HR);
temp_raw = table2array(TEMP);

% process acc
for i = 1:8
    acc_x{i} = acc_raw(starts(i)*acc_sr:ends(i)*acc_sr, 1);
    acc_y{i} = acc_raw(starts(i)*acc_sr:ends(1)*acc_sr, 2);
    acc_z{i} = acc_raw(starts(i)*acc_sr:ends(1)*acc_sr, 3);
end

% process eda 
for i = 1:8
    eda{i} = eda_raw(starts(i)*eda_sr:ends(i)*eda_sr);
end

% process hr
for i = 1:8
    hr{i} = hr_raw(starts(i)*hr_sr:ends(i)*hr_sr);
end

% process temp
for i = 1:8
    temp{i} = temp_raw(starts(i)*temp_sr:ends(i)*temp_sr);
end

% clean up workspace
vars = {"starts", "ends", "acc_raw", "eda_raw", "hr_raw", "temp_raw"};
clear(vars{:});
