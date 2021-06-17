mean_lat = [];
max_lat = [];
mean_heading = [];
max_heading = [];
plan_time_gpf = [];
track_time_gpf = [];

myDir = "C:\Users\Rayne\OneDrive\Documents\Master's Thesis\Thesis_Data\test_2"; %gets directory
myFiles = dir(fullfile(myDir,'gpops*False.bag')); %gets all wav files in struct
plotpoints = 1;

for k = 1:length(myFiles)
  if k == 1
      plotpoints = 1;
  end
  
  baseFileName = myFiles(k).name;
  bag = fullfile(myDir, baseFileName);
  time_data = fullfile(myDir,"testing_data_"+ baseFileName(1:length(baseFileName)-4)+".txt");
  state_waypoints = fullfile(myDir , "state_waypoints_"+baseFileName(1:length(baseFileName)-4)+".txt");
  fprintf(1, 'Now reading %s\n', baseFileName);
   
  [dist_mean, dist_max, lateral_dist_mean, lateral_dist_max, heading_mean, heading_max, plan_time, track_time] = read_and_plot_rosbag(bag, plotpoints, time_data,state_waypoints);
  %hold on;
  %plotpoints = input("0/1 for next");
  mean_lat(k) = lateral_dist_mean;
  max_lat(k) = lateral_dist_max;
  mean_heading(k) = heading_mean;
  max_heading(k) = heading_max;
  plan_time_gpf(k) = plan_time;
  track_time_gpf(k) = track_time;
  close all;
end


% mean(mean_lat)
% mean(max_lat)
% mean(mean_heading)
% mean(max_heading)

mean_lat = [];
max_lat = [];
mean_heading = [];
max_heading = [];
plan_time_gpt = [];
track_time_gpt = [];

myDir = "C:\Users\Rayne\OneDrive\Documents\Master's Thesis\Thesis_Data\test_2"; %gets directory
myFiles = dir(fullfile(myDir,'gpops*True.bag')); %gets all wav files in struct
plotpoints = 1;

for k = 1:length(myFiles)
  if k == 1
      plotpoints = 1;
  end
  
  baseFileName = myFiles(k).name;
  bag = fullfile(myDir, baseFileName);
  time_data = fullfile(myDir,"testing_data_"+ baseFileName(1:length(baseFileName)-4)+".txt");
  state_waypoints = fullfile(myDir , "state_waypoints_"+baseFileName(1:length(baseFileName)-4)+".txt");
  fprintf(1, 'Now reading %s\n', baseFileName);
   
  [dist_mean, dist_max, lateral_dist_mean, lateral_dist_max, heading_mean, heading_max, plan_time, track_time] = read_and_plot_rosbag(bag, plotpoints, time_data,state_waypoints);
  %hold on;
  %plotpoints = input("0/1 for next");
  mean_lat(k) = lateral_dist_mean;
  max_lat(k) = lateral_dist_max;
  mean_heading(k) = heading_mean;
  max_heading(k) = heading_max;
  plan_time_gpt(k) = plan_time;
  track_time_gpt(k) = track_time;
  close all;
end

mean_lat = [];
max_lat = [];
mean_heading = [];
max_heading = [];
plan_time_bmf = [];
track_time_bmf = [];

myDir = "C:\Users\Rayne\OneDrive\Documents\Master's Thesis\Thesis_Data\test_2"; %gets directory
myFiles = dir(fullfile(myDir,'backman*False.bag')); %gets all wav files in struct
plotpoints = 1;

for k = 1:length(myFiles)
  if k == 1
      plotpoints = 1;
  end
  
  baseFileName = myFiles(k).name;
  bag = fullfile(myDir, baseFileName);
  time_data = fullfile(myDir,"testing_data_"+ baseFileName(1:length(baseFileName)-4)+".txt");
  state_waypoints = fullfile(myDir , "state_waypoints_"+baseFileName(1:length(baseFileName)-4)+".txt");
  fprintf(1, 'Now reading %s\n', baseFileName);
   
  [dist_mean, dist_max, lateral_dist_mean, lateral_dist_max, heading_mean, heading_max, plan_time, track_time] = read_and_plot_rosbag(bag, plotpoints, time_data,state_waypoints);
  %hold on;
  %plotpoints = input("0/1 for next");
  mean_lat(k) = lateral_dist_mean;
  max_lat(k) = lateral_dist_max;
  mean_heading(k) = heading_mean;
  max_heading(k) = heading_max;
  plan_time_bmf(k) = plan_time;
  track_time_bmf(k) = track_time;
  close all;
end

mean_lat = [];
max_lat = [];
mean_heading = [];
max_heading = [];
plan_time_bmt = [];
track_time_bmt = [];

myDir = "C:\Users\Rayne\OneDrive\Documents\Master's Thesis\Thesis_Data\test_2"; %gets directory
myFiles = dir(fullfile(myDir,'backman*True.bag')); %gets all wav files in struct
plotpoints = 1;

for k = 1:length(myFiles)
  if k == 1
      plotpoints = 1;
  end
  
  baseFileName = myFiles(k).name;
  bag = fullfile(myDir, baseFileName);
  time_data = fullfile(myDir,"testing_data_"+ baseFileName(1:length(baseFileName)-4)+".txt");
  state_waypoints = fullfile(myDir , "state_waypoints_"+baseFileName(1:length(baseFileName)-4)+".txt");
  fprintf(1, 'Now reading %s\n', baseFileName);
   
  [dist_mean, dist_max, lateral_dist_mean, lateral_dist_max, heading_mean, heading_max, plan_time, track_time] = read_and_plot_rosbag(bag, plotpoints, time_data,state_waypoints);
  %hold on;
  %plotpoints = input("0/1 for next");
  mean_lat(k) = lateral_dist_mean;
  max_lat(k) = lateral_dist_max;
  mean_heading(k) = heading_mean;
  max_heading(k) = heading_max;
  plan_time_bmt(k) = plan_time;
  track_time_bmt(k) = track_time;
  close all;
end

figure(1);
hold on;
plot(1:0.5:4, track_time_gpf, '--*');
plot(1:0.5:4, track_time_gpt, '-*');
plot(1:0.5:4, track_time_bmf, '--o');
plot(1:0.5:4, track_time_bmt, '-o');
hold off;
title('Path Time Tracked');
ylabel('Final Time (s)');
xlabel('Distance Start to Goal (m)');
legend('GPOPS rev allowed', 'GPOPS fwd only', 'Backman rev allowed', 'Backman fwd only');

figure(2);
hold on;
plot(1:0.5:4, plan_time_gpf, '--*');
plot(1:0.5:4, plan_time_gpt, '-*');
plot(1:0.5:4, plan_time_bmf, '--o');
plot(1:0.5:4, plan_time_bmt, '-o');
hold off;
title('Path Time Planned');
ylabel('Final Time (s)');
xlabel('Distance Start to Goal (m)');
legend('GPOPS rev allowed', 'GPOPS fwd only', 'Backman rev allowed', 'Backman fwd only');

