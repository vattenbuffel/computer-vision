clc; clear all; close all
load('./assignment1data/compEx1.mat')

% Convert the points from P^2 to R^2
x2 = pflat(x2D);
plot(x2(1,:), x2(2,:))
title('P^2 to R^2')

% Convert the points from P^3 to R^3
figure
x3 = pflat(x3D);
plot3(x3(1,:), x3(2,:), x3(3,:))
title('P^3 to R^3')
