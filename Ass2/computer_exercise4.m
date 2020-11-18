clc; clear all; close all;

img1 = imread('./assignment2data/cube1.jpg');
img2 = imread('./assignment2data/cube2.jpg');

% Extract features using sift
[f1 d1] = vl_sift(single(rgb2gray(img1)),'PeakThresh',1);
[f2 d2] = vl_sift(single(rgb2gray(img2)),'PeakThresh',1);

% Plot features together with the image
hold on
axis ij
title('cube1.jpg and sift features')
imagesc(img1)
vl_plotframe(f1);

% Compute matching features
[matches , scores ] = vl_ubcmatch (d1 ,d2 );

% Get the matching features
x1 = [f1(1, matches(1 ,:)); f1(2, matches(1 ,:))];
x2 = [f2(1, matches(2 ,:)); f2(2, matches(2 ,:))];

perm = randperm ( size ( matches ,2));
figure 
imagesc([img1 img2]);
hold on;
plot ([x1(1, perm (1:10)); x2(1, perm(1:10)) + size(img1, 2)] , ...
[x1(2, perm(1:10)); x2(2, perm(1:10))], '-');
hold off;
