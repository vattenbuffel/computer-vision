clc; clear all; close all
load('./data/data1.mat')

classes = ["ape", "can", "cat", "duck", "eggbox", "glue", "holepuncher"];

% Find ransac cameras and inliers
Ps = {};
inliers = {};
threshold = 0.005; % 0.001 and 0.005 both seem good


for obj_idx = 1:size(U, 2)

    [P, inlier] = get_best_ransac_camera(obj_idx, threshold, U, u);
    Ps{obj_idx} = P;
    inliers{obj_idx} = inlier;
    
    figure
    axis ij
    plot3(inlier(1,:), inlier(2,:), inlier(3,:), 'o')
    title(classes(obj_idx))
end