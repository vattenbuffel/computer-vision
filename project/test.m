clc; clear all; close all
% load ('P')
% load('./assignment5data/compEx2Data.mat')
% im1 = imread('./assignment5data/kronan1.JPG');
load('./data/data1.mat')


threshold = 0.005; % 0.001 and 0.005 both seem good
obj_idx = 2;

[P, inliers] = get_best_ransac_camera(obj_idx, threshold, U, u);


plot3(inliers(1,:), inliers(2,:), inliers(3,:), 'o')






