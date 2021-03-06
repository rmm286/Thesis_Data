myDir = uigetdir; %gets directory
myFiles = dir(fullfile(myDir,'*.bag')); %gets all wav files in struct
plotpoints = 1;
for k = 1:length(myFiles)
  if k == 1
      plotpoints = 1;
  end
  
  baseFileName = myFiles(k).name;
  fullFileName = fullfile(myDir, baseFileName);
  fprintf(1, 'Now reading %s\n', baseFileName);
  
  figure(1);
  
  [out_mean, out_max] = read_and_plot_rosbag(fullFileName, plotpoints);
  legend('Filtered Position','Path Points');
  hold on;
  plotpoints = input("0/1 for next");
  %close all;
end