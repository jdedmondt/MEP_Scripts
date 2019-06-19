% process temperature data

% convert table to array
temp_array = table2array(TEMP)

% calculcate data window information
temp_data_points = size(temp_array, 1)

temp_sample_rate = 4 % Hz
int_dur = 1;
temp_interval_time = int_dur * 60 % 5 minutes 
temp_interval_length = temp_sample_rate * temp_interval_time

temp_i_cnt = floor(temp_data_points / temp_interval_length)

temp_dp_start = 1

% smooth data
temp_array = smooth(temp_array)

j = 1

while j <= temp_i_cnt
    % set data window
    temp_dp_end = temp_interval_length * j + 1
    
    if j > 1
        temp_dp_start = (j - 1) * temp_interval_length + 1
    end
    
    % calculate average temperature 
    temp_avg(j) = mean(temp_array(temp_dp_start:temp_dp_end, 1))
    
    % calculte standard deviation 
    temp_std(j) = std(temp_array(temp_dp_start:temp_dp_end, 1))
    
    % increment data window
    j = j + 1
end

% create table from transposed matricies
temp_T = table(temp_avg', temp_std')
temp_T.Properties.VariableNames = ["AVERAGE" "STD_DEV"]

writetable(temp_T)

% graph raw temp data
plot(linspace(1, temp_interval_time*temp_i_cnt/60, temp_interval_length*temp_i_cnt), temp_array(1:temp_interval_length*temp_i_cnt))
grid on
title("temp")
xlabel("Time (minutes)")
ylabel("temp (°C)")
saveas(gcf, "temp_raw.png")

% graph average temperatures for each interval
plot(1:int_dur:temp_i_cnt*int_dur, temp_avg(1:temp_i_cnt))
grid on 
title("Averge temperature per interval")
xlabel("Time (minutes)")
ylabel("Temperature (C)")
saveas(gcf, "temp_avg.png")

% graph standard deviations for each interval
plot(1:int_dur:temp_i_cnt*int_dur, temp_std(1:temp_i_cnt))
grid on
title("Standard deviation in temperature per interval")
xlabel("Time (minutes)")
ylabel("Temperature (C)")
saveas(gcf, "temp_std.png")