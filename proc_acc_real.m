% process accelerometer data

% convert table to array
acc_array = table2array(ACC)

% calculcate data window information
acc_data_points = size(acc_array, 1)

% get magnitude of vector
for i = 1:acc_data_points
    acc_array_mag(i) = sqrt(acc_array(i, 1)^2 + acc_array(i, 2)^2 + acc_array(i, 3)^2)
end

% process data window information 

acc_sample_rate = 32 % Hz
acc_interval_time = 5 * 60 % 5 minutes 
acc_interval_length = acc_sample_rate * acc_interval_time

acc_i_cnt = floor(acc_data_points / acc_interval_length)

acc_dp_start = 1

j = 1

while j <= 1
    
    % set data window
    acc_dp_end = acc_interval_length * j + 1
    
    if j > 1
        acc_dp_start = (j - 1) * acc_interval_length + 1
    end
    
    % calculate activity
    activity(j) = var(acc_array_net(acc_dp_start:acc_dp_end))
    
    % calculate mobility
    
    % calculate 
    
    % increment the data window
    j = j + 1

end



