% proc_acc.m: extract features from accelerometer data

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
end

% clean workspace
vars = {"i", "vars"};
clear(vars{:});

