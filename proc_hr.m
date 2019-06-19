% proc_hr.m: process heart rate data

% calculate utility vars
int_len = dur_sec * hr_sr;

% signal processing
for i = 1:clip_n
    hr{i} = smooth(hr{i});
end

% perform sliding data window analysis on each clip
for i = 1:clip_n
    
    % calculate how many data intervals can be extraced from each slice
    int_cnt(i) = floor(size(hr{i}, 1)/int_len);
    
    start_n = 1;
    end_n = int_len;
    
    for j = 1:int_cnt(i)
        hr_avg{i}(j) = mean(hr{i}(start_n:end_n));
        
        start_n = end_n;
        end_n = end_n + int_len;
    end
end

% graph results
for i = 1:clip_n
    
    % hr_avg
    plot(1:int_cnt(i), hr_avg{i});
    grid on;
    title("Average heart rate for clip " + i);
    xlabel("Time (" + dur_sec + "second intervals");
    ylabel("Heart rate (BPM)");
    saveas(gcf, "graphs/hr_avg_c" + i + ".png");
end


% clean up workspace
vars = {"int_len", "i", "int_cnt", "start_n", "end_n", "j", "vars"};
clear(vars{:});