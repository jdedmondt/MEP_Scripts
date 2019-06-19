% proc_eda.m: process the eda data

% calculate utility vars
int_len = dur_sec * eda_sr;

% signal processing
for i = 1:clip_n
    eda{i} = smooth(eda{i});
end

% perform sliding data window analysis on each clip
for i = 1:clip_n
    
    % calculate how many data intervals can be extracted from each slice
    int_cnt(i) = floor(size(eda{i}, 1)/int_len);
    
    start_n = 1;
    end_n = int_len;
    
    for j = 1:int_cnt(i)
        eda_diff{i}{j} = diff(eda{i}(start_n:end_n))';
        eda_avg{i}(j) = mean(eda{i}(start_n:end_n));
        eda_diff_avg{i}(j) = mean(diff(eda{i}(start_n:end_n)));
        % eda_std{i}(i) = std(eda{i}(start_n:end_n)); % something weird
        % happening here 
        
        start_n = end_n;
        end_n = end_n + int_len;
    end
end

% graph results
for i = 1:clip_n
    
    % eda_avg
    plot(1:int_cnt(i), eda_avg{i});
    grid on;
    title("Average EDA for clip " + i);
    xlabel("Time (" + dur_sec + "second intervals)");
    ylabel("EDA (\muS)");
    saveas(gcf, "graphs/eda_avg_c" + i + ".png");
    
    % eda_diff_avg
    plot(1:int_cnt(i), eda_diff_avg{i});
    grid on;
    title("Average \DeltaEDA for clip " + i);
    xlabel("Time (" + dur_sec + "second intervals)");
    ylabel("EDA/s (\muS/s)");
    saveas(gcf, "graphs/eda_diff_avg_c" + i + ".png");
    
end

% clean up workspace
vars = {"int_len", "i", "int_cnt", "start_n", "end_n", "j", "vars"};
clear(vars{:});
