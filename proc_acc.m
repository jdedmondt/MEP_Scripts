% process accelerometer data 

% convert table to array
acc_array = table2array(ACC)

% calculcate data window information
acc_data_points = size(acc_array, 1)

acc_sample_rate = 32 % Hz
int_dur = 5; % duration of data window in minutes
acc_interval_time = int_dur * 60 % duration of data window in seconds
acc_interval_length = acc_sample_rate * acc_interval_time % duration of data window in # data points

acc_i_cnt = floor(acc_data_points / acc_interval_length) % number of intervals present in the data

acc_dp_start = 1
j = 1

% convert units from 1/64g to 1g
for i = 1:acc_interval_length*acc_i_cnt
    acc_array(i, 1) = acc_array(i, 1)/64;
    acc_array(i, 2) = acc_array(i, 2)/64;
    acc_array(i, 3) = acc_array(i, 3)/64;
end

while j <= acc_i_cnt
    
    % set data window
    acc_dp_end = acc_interval_length * j + 1;
    
    if j > 1
        acc_dp_start = (j - 1) * acc_interval_length + 1;
    end
    
    clear i

    % calculate bias vector
    x = mean(acc_array(acc_dp_start:acc_dp_end, 1));
    y = mean(acc_array(acc_dp_start:acc_dp_end, 2));
    z = mean(acc_array(acc_dp_start:acc_dp_end, 3));
  
    bias(j, 1) = x;
    bias(j, 2) = y;
    bias(j, 3) = z;
    
    % calculate the tilt angles of the bias vector
    theta_1(j) = atan(bias(j, 2)/bias(j, 3));
    theta_2(j) = atan(bias(j, 1) / ( bias(j, 2) * sin(theta_1(j)) + bias(j, 1)*cos(theta_1(j))));
      
    % calculate tilt compensated acceleration vector 
    rm = [  cos(theta_1(j))     -sin(theta_1(j))*sin(theta_2(j))    -cos(theta_1(j))*cos(theta_2(j));...
            0                   cos(theta_1(j))                     -sin(theta_1(j));...
            sin(theta_2(j))     sin(theta_1(j))*cos(theta_2(j))     cos(theta_1(j))*cos(theta_2(j)); ];
    for i = acc_dp_start:acc_dp_end
        a_1{i} = rm * [acc_array(i, 1) acc_array(i, 2) acc_array(i, 3)]';
    end
    
    % calculate bias of vertical compontent of a_1
    for i = acc_dp_start:acc_dp_end
        mat = cell2mat(a_1(acc_dp_start:acc_dp_end))';
        a_1zb(i) = mean(mat(:, 3));
    end
    
    % calculate a_2
    for i = acc_dp_start:acc_dp_end
        mat = cell2mat(a_1(i))';
        a_2{i} = [mat(1) mat(2) (mat(3)-a_1zb(i))];
    end
    
    % horizontal acceleration
    for i = acc_dp_start:acc_dp_end
        mat = cell2mat(a_2(i));
        a_h(i) = sqrt(mat(1)^2 + mat(2)^2);
    end
   
    % vertical acceleration
    for i = acc_dp_start:acc_dp_end
        mat = cell2mat(a_2(i));
        a_v(i) = abs(mat(3));
    end
    
    % calculate horizontal energy 
    e_h(j) = trapz(a_h);
    
    % calculate vertical energy
    e_v(j) = trapz(a_v);
    
    % incrememt data window
    j = j + 1

end

% calculate activity 
acc_activity_v = var(e_v);
acc_activity_h = var(e_h);
    
% calculate mobility
acc_mobility_v = sqrt(var(diff(e_v))/var(e_v));
acc_mobility_h = sqrt(var(diff(e_h))/var(e_h));
    
% calculate complexity
acc_complexity_v = sqrt(var(diff(e_v, 2))/var(diff(e_v)))/acc_mobility_v;
acc_complexity_h = sqrt(var(diff(e_h, 2))/var(diff(e_v)))/acc_mobility_h;

% generate table
acc_T = table(bias(:, 1), bias(:, 2), bias(:, 3), theta_1', theta_2', e_v', e_h')
acc_T.Properties.VariableNames = ["BIAS_X" "BIAS_Y" "BIAS_Z" "TILT_ANGLE_1" "TILT_ANGLE_2" ...
    "ENG_V" "ENG_H"]

% generate separate table for hjorth parameters

acc_hjorth_T = table(acc_activity_v, acc_activity_h, acc_mobility_v, acc_mobility_h, ...
        acc_complexity_v, acc_complexity_h)
    
acc_hjorth_T.Properties.VariableNames = ["ACTIVITY_V" "ACTIVITY_H" "MOBILITY_V" "MOBILITY_H" ...
    "COMPLEXITY_V" "COMPLEXITY_H"]

writetable(acc_T)
writetable(acc_hjorth_T)

% graph bias vector per interval
plot(1:int_dur:acc_i_cnt*int_dur, bias(:, 1))
hold on
plot(1:int_dur:acc_i_cnt*int_dur, bias(:, 2))
hold on
plot(1:int_dur:acc_i_cnt*int_dur, bias(:, 3))
grid on
title("Bias vector per interval")
xlabel("Time (minutes)")
ylabel("(?)")
legend("x", "y", "z")
saveas(gcf, "acc_bias.png")
hold off

% graph vertical energy per interval
plot(1:int_dur:acc_i_cnt*int_dur, e_v(1:acc_i_cnt))
grid on 
title("Vertical energy per interval")
xlabel("Time (minutes)")
ylabel("Energy (?)")
saveas(gcf, "acc_e_v.png")

% graph horizontal energy per interval
plot(1:int_dur:acc_i_cnt*int_dur, e_h(1:acc_i_cnt))
grid on 
title("Horizontal energy per interval")
xlabel("Time (minutes)")
ylabel("Energy (?)")
saveas(gcf, "acc_e_h.png")
