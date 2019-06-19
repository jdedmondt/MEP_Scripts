% NOTE: need a good BVP signal in order for this to make sense

ibi_array = table2array(IBI)
ibi_data_points = size(ibi_array, 1)

ibi_sample_rate = 1 % (Hz) found in csv file 
int_dur = 5;
ibi_interval_time = int_dur * 60 % seconds per interval
ibi_interval_length = ibi_sample_rate * ibi_interval_time % number of data points per interval

ibi_i_cnt = floor(ibi_data_points / ibi_interval_length) % number of intervals present in data

ibi_dp_start = 1

j = 1

while j <= ibi_i_cnt
    
    % set data point window
    
    ibi_dp_end = ibi_interval_length * j
    
    if j > 1
        ibi_dp_start = (j-1) * ibi_interval_length
    end
        
    % calculate RMSSD (root mean square of succsessive differences)

    ssd(j) = 0

    for i = ibi_dp_start:ibi_dp_end-1
        ssd(j) = ssd(j) + (ibi_array(i+1, 2) - ibi_array(i, 2))^2
    end
    
    clear i

    rmssd(j) = sqrt( ssd(j) / ibi_interval_length)

    % ln(rmssd)

    ln_rmssd(j) = log(rmssd(j))

    % calculate NN50

    NN50(j) = 0

    for i = ibi_dp_start:ibi_dp_end-1
        if abs(ibi_array(i, 2) - ibi_array(i+1, 2)) > 0.0005
            NN50(j) = NN50(j) + 1
        end
    end
    
    clear i

    % clalculate pNN50

    pNN50(j) = NN50(j) / ibi_interval_length

    % calculate SDNN

    sdnn(j) = std(ibi_array(ibi_dp_start:ibi_dp_end, 2))

    % calculate average

    ibi_avg(j) = mean(ibi_array(ibi_dp_start:ibi_dp_end, 2))

    % calculate median

    ibi_med(j) = median(ibi_array(ibi_dp_start:ibi_dp_end, 2))

    % calculate range

    ibi_rng(j) = range(ibi_array(ibi_dp_start:ibi_dp_end, 2))
    
    j = j + 1
end

clear j

% generate table with transposed matricies
ibi_T = table('rmssd', ln_rmssd', NN50', pNN50', sdnn', ibi_avg', ibi_med', ibi_rng')
ibi_T.Properties.VariableNames = ["RMSSD_s" "ln_RMSSD" "NN50" "pNN50_percent" "SDNN_s" ...
                              "AVERAGE_s" "MEDIAN_s" "RANGE_s"]
                          
writetable(ibi_T)
                       
% graph rmssd per interval
plot(1:int_dur:ibi_i_cnt*int_dur, rmssd(1:ibi_i_cnt))
grid on
title("RMSSD per interval")
xlabel("Time (minutes)")
ylabel("RMSSD (s)")
saveas(gcf, "ibi_rmssd.png")

% graph ln_rmssd per interval
plot(1:int_dur:ibi_i_cnt*int_dur, ln_rmssd(1:ibi_i_cnt))
grid on
title("ln(RMSSD) per interval")
xlabel("Time (minutes)")
ylabel("ln(RMSSD)")
saveas(gcf, "ibi_ln_rmssd.png")

% graph pNN50 per interval
plot(1:int_dur:ibi_i_cnt*int_dur, pNN50(1:ibi_i_cnt))
grid on
title("pNN50 per interval")
xlabel("Time (minutes)")
ylabel("pNN50 (%)")
saveas(gcf, "ibi_pnn50.png")

% graph sdnn per interval
plot(1:int_dur:ibi_i_cnt*int_dur, sdnn(1:ibi_i_cnt))
grid on
title("SDNN per interval")
xlabel("Time (minutes)")
ylabel("SDNN (s)")
saveas(gcf, "ibi_sdnn.png")

% graph average ibi per interval
plot(1:int_dur:ibi_i_cnt*int_dur, ibi_avg(1:ibi_i_cnt))
grid on
title("Average IBI per interval")
xlabel("Time (minutes)")
ylabel("Average IBI (s)")
saveas(gcf, "ibi_avg.png")

% graph median ibi per interval 
plot(1:int_dur:ibi_i_cnt*int_dur, ibi_med(1:ibi_i_cnt))
grid on
title("Median IBI per interval")
xlabel("Time (minutes)")
ylabel("Median IBI (s)")
saveas(gcf, "ibi_med.png")

% graph IBI range per interval
plot(1:int_dur:ibi_i_cnt*int_dur, ibi_rng(1:ibi_i_cnt))
grid on
title("Rangle of IBI per interval")
xlabel("Time (minutes)")
ylabel("IBI range (s)")
saveas(gcf, "ibi_rng.png")