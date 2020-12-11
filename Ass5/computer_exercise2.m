clc; clear all; close all
load ('P')
load('./assignment5data/compEx2Data.mat')
im1 = imread('./assignment5data/kronan1.JPG');
im2 = imread('./assignment5data/kronan2.JPG');

% Selects suitable depths for the planesweep algorithm
d = linspace (5 ,11 ,200);
% rescales the images to incease speed .
sc = 0.25;
% Compute normalized cross correlations for all the depths
[ncc , outside_image ] = compute_ncc (d,im2 ,P{2} , im1 , segm_kronan1 ,P{1} ,3 , sc );
% Select the best depth for each pixel
[maxval , maxpos ] = max(ncc ,[] ,3);
% Print the result
disp_result (im2 ,P{2} , segm_kronan2 ,d( maxpos ) ,0.25 , sc)