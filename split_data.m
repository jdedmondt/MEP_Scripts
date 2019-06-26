% split.m: split csv files into raw data accoring to clip timestamps

% timestamps
OFF_1 = 29*60+40;
OFF_2 = 29*60+40+28*60+10;

starts = [00*60+10 04*60+09 09*60+09 13*60+19 18*60+51 19*60+23 21*60+30 26*60+48 ...
          00*60+25 04*60+25 06*60+20 10*60+26 15*60+41 16*60+27 18*60+00 23*60+19 ...
          00*60+10 04*60+08 05*60+50 09*60+57 15*60+00 15*60+30 17*60+20 22*60+40]; % start timestamps of each clip in seconds
ends = [04*60+08 06*60+03 13*60+18 17*60+53 19*60+22 20*60+55 26*60+47 29*60+40 ...
        04*60+24 05*60+44 10*60+25 15*60+00 16*60+26 17*60+44 23*60+17 28*60+10 ...
        04*60+07 05*60+28 08*60+55 14*60+35 15*60+28 17*60+00 22*60+39 25*60+10]; % end timestamps of each clip in seconds

% get raw data
acc_raw = table2array(ACC);
eda_raw = table2array(EDA);
hr_raw = table2array(HR);
temp_raw = table2array(TEMP);

% process acc
for i = 1:clip_n
    if (i < 9)
        OFFSET = 0;
    elseif (i < 17)
        OFFSET = OFF_1;
    elseif (i < clip_n+1)
        OFFSET = OFF_2;
    end
    e = (ends(i) + OFFSET)*acc_sr;
    if (e > size(acc_raw, 1))
        e = size(acc_raw, 1);
    end
    acc_x{i} = acc_raw((starts(i)+OFFSET)*acc_sr:e, 1);
    acc_y{i} = acc_raw((starts(i)+OFFSET)*acc_sr:e, 2);
    acc_z{i} = acc_raw((starts(i)+OFFSET)*acc_sr:e, 3);
end

% process eda 
for i = 1:clip_n
    if (i < 9)
        OFFSET = 0;
    elseif (i < 17)
        OFFSET = OFF_1;
    elseif (i < clip_n+1)
        OFFSET = OFF_2;
    end
    e = (ends(i) + OFFSET)*eda_sr;
    if (e > size(eda_raw, 1))
        e = size(eda_raw, 1);
    end
    eda{i} = eda_raw((starts(i)+OFFSET)*eda_sr:e);
end

% process hr
for i = 1:clip_n
    if (i < 9)
        OFFSET = 0;
    elseif (i < 17)
        OFFSET = OFF_1;
    elseif (i < clip_n+1)
        OFFSET = OFF_2;
    end
    e = (ends(i) + OFFSET)*hr_sr;
    if (e > size(hr_raw, 1))
        e = size(hr_raw, 1);
    end
    hr{i} = hr_raw((starts(i)+OFFSET)*hr_sr:e);
end

% process temp
for i = 1:clip_n
    if (i < 9)
        OFFSET = 0;
    elseif (i < 17)
        OFFSET = OFF_1;
    elseif (i < clip_n+1)
        OFFSET = OFF_2;
    end
    e = (ends(i) + OFFSET)*temp_sr;
    if (e > size(temp_raw, 1))
        e = size(temp_raw, 1);
    end
    temp{i} = temp_raw((starts(i)+OFFSET)*temp_sr:e);
end

% clean up workspace
vars = {"starts", "ends", "acc_raw", "eda_raw", "hr_raw", "temp_raw", "i", "vars"};
clear(vars{:});
