
function [out_mean, out_max] = read_and_plot_rosbag(file_path, plotpts)
    bag = rosbag(file_path);
    odom = select(bag, 'Topic', '/frailbot2/odometry/filtered');
    odom_ts = timeseries(odom, 'Pose.Pose.Position.X', 'Pose.Pose.Position.Y');

    plot( odom_ts.Data(:,1), odom_ts.Data(:,2))
    odom_array = [odom_ts.Data(:,1), odom_ts.Data(:,2)];
    hold on;
    path_points = select(bag, 'Topic', '/frailbot2/path_points');
    pp = readMessages(path_points); 

    N_path = length(pp{1,1}.Points);
    path_x = zeros(N_path,1);
    path_y = zeros(N_path,1);

    for i = 1:N_path
        path_x(i) = pp{1,1}.Points(i).X;
        path_y(i) = pp{1,1}.Points(i).Y;
    end
    path_points =[path_x, path_y];
    if plotpts == 1
        plot(path_x,path_y, '.');
        legend('Filtered Position','Path Points');
    end
    [~,dist] = dsearchn(path_points,odom_array);
    hold off; 

    out_mean = mean(dist);
    out_max = max(dist);
end

%need time values
%need full path values
%need iterate over values