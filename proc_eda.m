% process electrodermal activity data

% convert table to array
eda_array = table2array(EDA);

% calculate the change in EDA
eda_diff_array = diff(eda_array);

% calculcate data window information
eda_data_points = size(eda_array, 1);

eda_sample_rate = 4; % Hz
int_dur = 5; % duration of interval in minites
eda_interval_time = int_dur * 60; % duration of interval in seconds 
eda_interval_length = eda_sample_rate * eda_interval_time; % duration of interval in # data points

eda_i_cnt = floor(eda_data_points / eda_interval_length); % intervals present in data

eda_dp_start = 1;

j = 1;

while j <= eda_i_cnt
    % set data window
    eda_dp_end = eda_interval_length * j;
    
    if j > 1
        eda_dp_start = (j - 1) * eda_interval_length;
    end    
  
    % calculate average EDA
    eda_avg(j) = mean(eda_array(eda_dp_start:eda_dp_end));
    
    % calculate average delata_EDA
    eda_diff_avg(j) = mean(eda_diff_array(eda_dp_start:eda_dp_end-1));
    
    % calculate standard deviation
    eda_std(j) = std(eda_array(eda_dp_start:eda_dp_end));
    
    % increment data window
    j = j + 1;
end

% create table from transposed matricies
eda_T = table(eda_avg', eda_std', eda_diff_avg');
eda_T.Properties.VariableNames = ["AVERAGE" "STD_DEV" "AVG_DELTA_EDA"]

writetable(eda_T)

% graph average eda per interval
plot(1:int_dur:eda_i_cnt*int_dur, eda_avg(1:eda_i_cnt))
grid on 
title("Average EDA per interval")
xlabel("Time (minutes)")
ylabel("EDA (\muS)")
saveas(gcf, "eda_avg.png")

% graph standard deviation of eda per interval 
plot(1:int_dur:eda_i_cnt*int_dur, eda_std(1:eda_i_cnt))
grid on
title("Standard deviation of EDA")
xlabel("Time (minutes)")
ylabel("EDA (\muS)")
saveas(gcf, "eda_std.png")

% graph change in EDA per interval
plot(1:int_dur:eda_i_cnt*int_dur, eda_diff_avg(1:eda_i_cnt))
grid on
title("Average change in EDA per interval")
xlabel("Time (minutes)")
ylabel("Change in EDA (\muSs^{-1})")
saveas(gcf, "eda_diff_avg.png")

