% generate comparative graphs for Sean, Roger, and Jack datapoints

int_cnt = 12 % max interval count to graph
int_dr = 5 % minutes

% ACCELERATI0N

% to be done; not sure what metrics to graph 

% EDA

Jack_eda_arr = table2array(JackedaT)
Roger_eda_arr = table2array(RogeredaT)
Sean_eda_arr = table2array(SeanedaT)

% plot EDA average
grid on
plot(1:int_dr:int_cnt*int_dr, Jack_eda_arr(1:int_cnt, 1));
hold on;
plot(1:int_dr:int_cnt*int_dr, Roger_eda_arr(1:int_cnt, 1));
hold on; 
plot(1:int_dr:int_cnt*int_dr, Sean_eda_arr(1:int_cnt, 1));
title("Average EDA per interval", "fontsize", 16);
xlabel("Time (minutes)", "fontsize", 16);
ylabel("EDA (\muS)", "fontsize", 16);
legend("Subject 3", "Subject 2", "Subject 1");

saveas(gcf, "group_eda_avg.png");
hold off

% plot EDA standard deviation

grid on
plot(1:int_dr:int_cnt*int_dr, Jack_eda_arr(1:int_cnt, 2));
hold on;
plot(1:int_dr:int_cnt*int_dr, Roger_eda_arr(1:int_cnt, 2));
hold on; 
plot(1:int_dr:int_cnt*int_dr, Sean_eda_arr(1:int_cnt, 2));
title("Standard deviation of EDA per interval", "fontsize", 16);
xlabel("Time (minutes)", "fontsize", 16);
ylabel("EDA (\muS)", "fontsize", 16);
legend("Subject 3", "Subject 2", "Subject 1", "fontsize", 12);

saveas(gcf, "group_eda_stddev.png");
hold off

% plot average change in EDA per interval

grid on
plot(1:int_dr:int_cnt*int_dr, Jack_eda_arr(1:int_cnt, 3));
hold on;
plot(1:int_dr:int_cnt*int_dr, Roger_eda_arr(1:int_cnt, 3));
hold on; 
plot(1:int_dr:int_cnt*int_dr, Sean_eda_arr(1:int_cnt, 3));
title("Average \DeltaEDA per interval", "fontsize", 16);
xlabel("Time (minutes)", "fontsize", 16);
ylabel("EDA (\muS\?)", "fontsize", 16);
legend("Subject 3", "Subject 2", "Subject 1", "fontsize", 12);

saveas(gcf, "group_eda_delta.png");
hold off




% HEART RATE
Jack_hr_arr = table2array(JackhrT)
Roger_hr_arr = table2array(RogerhrT)
Sean_hr_arr = table2array(SeanhrT)

% plot heart rate average

grid on
plot(1:int_dr:int_cnt*int_dr, Jack_hr_arr(1:int_cnt, 1));
hold on;
plot(1:int_dr:int_cnt*int_dr, Roger_hr_arr(1:int_cnt, 1));
hold on; 
plot(1:int_dr:int_cnt*int_dr, Sean_hr_arr(1:int_cnt, 1));
title("Average HR per interval", "fontsize", 16);
xlabel("Time (minutes)", "fontsize", 16);
ylabel("Heart Rate (BPM)", "fontsize", 16);
legend("Subject 3", "Subject 2", "Subject 1", "fontsize", 12);

saveas(gcf, "group_hr_avg.png");
hold off

% plot heart rate std_dev

grid on
plot(1:int_dr:int_cnt*int_dr, Jack_hr_arr(1:int_cnt, 2));
hold on;
plot(1:int_dr:int_cnt*int_dr, Roger_hr_arr(1:int_cnt, 2));
hold on; 
plot(1:int_dr:int_cnt*int_dr, Sean_hr_arr(1:int_cnt, 2));
title("HR standard deviation per interval", "fontsize", 16);
xlabel("Time (minutes)", "fontsize", 16);
ylabel("Heart Rate (BPM)", "fontsize", 16);
legend("Subject 3", "Subject 2", "Subject 1", "fontsize", 12);

saveas(gcf, "group_hr_stddev.png");
hold off

% TEMPERATURE

Jack_temp_arr = table2array(JackhrT)
Roger_temp_arr = table2array(RogerhrT)
Sean_temp_arr = table2array(SeanhrT)

% plot average temperature

grid on
plot(1:int_dr:int_cnt*int_dr, Jack_temp_arr(1:int_cnt, 1));
hold on;
plot(1:int_dr:int_cnt*int_dr, Roger_temp_arr(1:int_cnt, 1));
hold on; 
plot(1:int_dr:int_cnt*int_dr, Sean_temp_arr(1:int_cnt, 1));
title("Average temperature per interval", "fontsize", 16);
xlabel("Time (minutes)", "fontsize", 16);
ylabel("Temperature (C)", "fontsize", 16);
legend("Subject 3", "Subject 2", "Subject 1", "fontsize", 12);

saveas(gcf, "group_temp_avg.png");
hold off

% temperture standard deviation

grid on 
plot(1:int_dr:int_cnt*int_dr, Jack_temp_arr(1:int_cnt, 2));
hold on;
plot(1:int_dr:int_cnt*int_dr, Roger_temp_arr(1:int_cnt, 2));
hold on; 
plot(1:int_dr:int_cnt*int_dr, Sean_temp_arr(1:int_cnt, 2));
title("Standard deviation of temperature per interval", "fontsize", 16);
xlabel("Time (minutes)", "fontsize", 16);
ylabel("Temperature (C)", "fontsize", 16);
legend("Subject 3", "Subject 2", "Subject 1", "fontsize", 12);

saveas(gcf, "group_temp_stddev.png");
hold off


