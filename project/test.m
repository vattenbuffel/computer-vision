clc; clear all; close all
% load ('P')
% load('./assignment5data/compEx2Data.mat')
% im1 = imread('./assignment5data/kronan1.JPG');
load('./data/data1.mat')


% Sample 3 correspondences and find candidate camera matrices for one object
obj_idx = 1;
n_inliers_max = -1;
P_best = [];
n_iterations = 100;
threshold = 0.05;

for i = 1:n_iterations
    % Get candidate cameras
    ind = randsample(size(U{obj_idx}, 2), 3);
    Ps = minimalCameraPose(pextend(u{obj_idx}(:, ind)), U{obj_idx}(:, ind));
    
    % Calculate number of inliers
    for p_index = 1:size(Ps)
       P = Ps(p_index);
       x = P*U{obj_idx};
       n_inliers = ((x-u).^2).^(0.5) < threshold;
       
       if n_inliers > n_inliers_max
          n_inliers_max = n_inliers;
          P_best = P;
       end
       
    end

end











