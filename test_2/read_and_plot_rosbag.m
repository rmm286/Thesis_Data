
function [dist_mean, dist_max, lateral_dist_mean, lateral_dist_max, heading_mean, heading_max, plan_time, track_time] = read_and_plot_rosbag(file_path, plotpts, time_data, state_waypoints)
    %read bag
    bag = rosbag(file_path);
    odom = select(bag, 'Topic', '/frailbot2/odometry/filtered');
    odom_ts = timeseries(odom, 'Pose.Pose.Position.X', 'Pose.Pose.Position.Y');
    odom_array = [odom_ts.Data(:,1), odom_ts.Data(:,2)];
    
    %read path points
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
    
    %read head info
    heading_quat_ts = timeseries(odom, 'Pose.Pose.Orientation.X', 'Pose.Pose.Orientation.Y', 'Pose.Pose.Orientation.Z', 'Pose.Pose.Orientation.W');
    heading_euler_ts = quat2eul(heading_quat_ts.Data);
    heading_track = heading_euler_ts(:,3);
    
    %read state waypoints
    waypoints_file = fopen(state_waypoints);
    waypoints = fscanf(waypoints_file,'%f');
    waypoints = reshape(waypoints, [],5);
    heading_plan = waypoints(:,3);
    
    %read time
    times_file = fopen(time_data);
    track_time = fscanf(times_file,'%f');
    num_pts = length(waypoints);
    plan_time = num_pts*0.2;
    
    % outputs
    [K,dist] = dsearchn(path_points,odom_array);
    dist_mean = mean(dist);
    dist_max = max(dist);
    lateral_dist = zeros(length(K),1);
    heading_error = zeros(length(K),1);
    
    for j = 1:length(K)
        v = path_points(K(j),:) - odom_array(j,:);
        omega = atan2(v(2), v(1));
        beta = heading_plan(K(j)) + pi/2.0;
        lateral_dist(j) = abs(dist(j)*cos(omega-beta));
        heading_error(j) = abs(heading_plan(K(j)) - heading_track(j));
        if heading_error(j) > 3.14
            heading_error(j) = abs(heading_error(j) - 2.0*pi);
        end
    end
    
    lateral_dist_mean = mean(lateral_dist);
    lateral_dist_max = max(lateral_dist);
    heading_mean = mean(heading_error);
    heading_max = max(heading_error); 
    
    %plot
    figure(1);
    plot(odom_ts.Data(:,1), odom_ts.Data(:,2))
    hold on;
    if plotpts == 1
        plot(path_x,path_y, '.');
        legend('Filtered Position','Path Points');
    end
    hold off;
    xlabel('X (m)');
    ylabel('Y (m)');
    
    figure(2);
    plot((1:length(K))*0.0275,lateral_dist);
    title('Lateral Error');
    xlabel('Time (s)');
    ylabel('Distance (m)');
    
    figure(3);
    plot((1:length(K))*0.0275,heading_error);
    title('Heading Error');
    xlabel('Time (s)');
    ylabel('Error (rad)');
    
end