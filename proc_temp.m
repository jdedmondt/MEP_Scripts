% proc_temp.m: process temperature data

% calculate utility vars
int_len = dur_sec * temp_sr;

% signal processing
for i = 1:clip_n
    temp{i} = smooth(temp{i});
end

% perform sliding data window analysis on each clip
for i = 1:clip_n

    % calculate how many data intervals can be extracted from each slice
    int_cnt(i) = floor(size(temp{i}, 1)/int_len);
    
    start_n = 1;
    end_n = int_len;
    
    for j = 1:int_cnt(i)
        temp_avg{i}(j) = mean(temp{i}(start_n:end_n));
        
        start_n = end_n;
        end_n = end_n + int_len;
    end
end

% graph results
for i = 1:clip_n
    
    % temp_avg
    plot(1:int_cnt(i), temp_avg{i});
    grid on;
    title("Average temperature for clip " + i);
    xlabel("Time (" + dur_sec + " second intervals)");
    ylabel("Temperature (°C)");
    saveas(gcf, "graphs/temp_avg_c" + i + ".png");
end

% clean up workspace
vars = {"int_len", "i", "int_cnt", "start_n", "end_n", "j", "vars"};
clear(vars{:});
