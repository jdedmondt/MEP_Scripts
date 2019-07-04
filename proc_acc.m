% proc_acc.m: extract features from accelerometer data

int_len = dur_sec * acc_sr;

% convert scale from 1/64g to 1g
for i = 1:clip_n
    for j = 1:size(acc_x{i})
        acc_x{i}(j) = acc_x{i}(j)/64;
    end
    for j = 1:size(acc_y{i})
        acc_y{i}(j) = acc_y{i}(j)/64;
    end
    for j = 1:size(acc_z{i})
        acc_z{i}(j) = acc_z{i}(j)/64;
    end
end

% run signal processing
for i = 1:clip_n
    acc_x_p{i} = smooth(acc_x{i});
    acc_y_p{i} = smooth(acc_y{i});
    acc_z_p{i} = smooth(acc_z{i});
    acc{i}(:, 1) = acc_x_p{i}(:)';
    acc{i}(:, 2) = acc_y_p{i}(:)'; 
    acc{i}(:, 3) = acc_z_p{i}(:)';
end

for i = 1:clip_n
    
    int_cnt(i) = floor(size(acc{i}, 1)/int_len)
    
    start_n = 1;
    end_n = int_len
    
    for j = 1:int_cnt(i)
        
        x = mean(acc{i}(start_n:end_n, 1));
        y = mean(acc{i}(start_n:end_n, 2));
        z = mean(acc{i}(start_n:end_n, 3));
  
        bias(j, 1) = x;
        bias(j, 2) = y;
        bias(j, 3) = z;
    
        % calculate the tilt angles of the bias vector
        theta_1(j) = atan(bias(j, 2)/bias(j, 3));
        theta_2(j) = atan(bias(j, 1) / ( bias(j, 2) * sin(theta_1(j)) + bias(j, 1)*cos(theta_1(j))));
        
        % tilt compensated acceleration vector
        rm = [  cos(theta_1(j))     -sin(theta_1(j))*sin(theta_2(j))    -cos(theta_1(j))*cos(theta_2(j));...
            0                   cos(theta_1(j))                     -sin(theta_1(j));...
            sin(theta_2(j))     sin(theta_1(j))*cos(theta_2(j))     cos(theta_1(j))*cos(theta_2(j)); ];
        for k = start_n:end_n
            a_1{k} = rm * [acc{i}(k, 1) acc{i}(k, 2) acc{i}(k, 3)]';
        end
        
        % calculate bias of vertical compontent of a_1
        for k = start_n:end_n
            mat = cell2mat(a_1(start_n:end_n))';
            a_1zb(k) = mean(mat(:, 3));
        end
        
        % calculate a_2
        for k = start_n:end_n
            mat = cell2mat(a_1(k))';
            a_2{k} = [mat(1) mat(2) (mat(3)-a_1zb(k))];
        end
    
        % horizontal acceleration
        for k = start_n:end_n
            mat = cell2mat(a_2(k));
            a_h(k) = sqrt(mat(1)^2 + mat(2)^2);
        end
   
        % vertical acceleration
        for k = start_n:end_n
            mat = cell2mat(a_2(k));
            a_v(k) = abs(mat(3));
        end
        
        % calculate horizontal energy 
        e_h(i) = trapz(a_h);
    
        % calculate vertical energy
        e_v(i) = trapz(a_v);
        
        start_n = end_n;
        end_n = end_n + int_len;
    end

% calculate activity 
acc_activity_v(i) = var(e_v);
acc_activity_h(i) = var(e_h);
end

% clean workspace
vars = {"i", "vars"};
clear(vars{:});

