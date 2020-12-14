clc; clear all; close all
load('./data/data1.mat')
im1 = imread('./data/img1.JPG');

% Parameters for the code
ransac_threshold = 0.001; % 0.001 and 0.005 both seem good
n_iterations_RANSAC = 1000;
n_iterations_LM = 1000;
lambda_LM = 10^-1;

classes = ["ape", "can", "cat", "duck", "eggbox", "glue", "holepuncher"];

% Find ransac cameras and inliers
Ps = {};
inliers = {};

for obj_idx = 1:size(U, 2)
    [P, inlier] = get_best_ransac_camera(obj_idx, ransac_threshold, U, u, n_iterations_RANSAC);
    Ps{obj_idx} = P;
    inliers{obj_idx} = inlier;
    
    figure
    axis ij
    inlier_points = U{obj_idx}(:,inliers{obj_idx});
    plot3(inlier_points(1,:), inlier_points(2,:), inlier_points(3,:), '.')
    title(classes(obj_idx))
end



figure
plot(u{1}(1,:), u{1}(2,:), '.')
hold on
x_hat = pflat(Ps{1}*pextend(U{1}));
plot(x_hat(1,:), x_hat(2,:), '.')

x_pose = pflat(poses{1}*pextend(U{1}));
plot(x_pose(1,:), x_pose(2,:), '.')
legend('u', 'u_{hat}', 'poses*X')


% Improve the cameras matrix using LM
Ps = improve_cameras(u, U, Ps, inliers, n_iterations_LM, lambda_LM);






P_est = Ps; % cell array with your final pose estimates for each object .
% Plot bounding boxes of all objects , overlayed on image .
% You can try out the plotting fucntionality immediately ,
% by setting 
draw_bounding_boxes (im1 , poses , P_est , bounding_boxes );

% Compute ( and print out ) the score for each estimated object pose .
scores = eval_pose_estimates ( poses , P_est , bounding_boxes );
    
    
    
    
    
    
    
    
    