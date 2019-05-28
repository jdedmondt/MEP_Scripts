hr_array = table2array(HR)
hr_data_points = size(hr_array, 1)

hr_sample_rate = 1 % (Hz) found in csv file 
int_dur = 5;
hr_interval_time = int_dur * 60 % seconds per interval
hr_interval_length = hr_sample_rate * hr_interval_time % number of data points per interval

% FIXME: as it stands, there is a collection of data points left out near
% the end of the array due to the way interval counting is handled. 
hr_i_cnt = floor(hr_data_points / hr_interval_length) % number of intervals present in data

dp_start = 1

j = 1

while j <= hr_i_cnt
    
    % set data point window
    
    dp_end = hr_interval_length * j
    
    if j > 1
        dp_start = (j-1) * hr_interval_length
    end
    
    % calculate meanRate
    
    hr_avg(j) = mean(hr_array(dp_start:dp_end, 1))
    
    % calculate sdRate
    
    hr_std(j) = std(hr_array(dp_start:dp_end, 1))
    
    % increment data window
    j = j + 1
end

% generate table with transposed matricies
hr_T = table(hr_avg', hr_std')
hr_T.Properties.VariableNames = ["AVERAGE" "STD_DEV"]

writetable(hr_T)

clear j

% graph avg hr per interval
plot(1:int_dur:hr_i_cnt*int_dur, hr_avg(1:hr_i_cnt))
grid on
title("Average heart rate per interval")
xlabel("Time (minutes)")
ylabel("Heart rate (BPM)")
saveas(gcf, "hr_avg.png")

% graph of standard deviation of hr per interval
plot(1:int_dur:hr_i_cnt*int_dur, hr_std(1:hr_i_cnt))
grid on
title("Standard deviation of heart rate per interval")
xlabel("Time (minutes)")
ylabel("Heart rate (BPM)")
saveas(gcf, "hr_std.png")