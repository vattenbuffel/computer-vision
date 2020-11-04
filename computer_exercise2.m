% close all
clc; clear all; clf

% Read the image and plot it as gray
img = imread('./assignment1data/compEx2.jpg');
imagesc(img)
colormap gray

% Read the points ,convert them to R^2, and plot them
load('./assignment1data/compEx2.mat')
p1_euclidian = pflat(p1);
p2_euclidian = pflat(p2);
p3_euclidian = pflat(p3);
hold on
% Why is this incorrect?
% scatter(p1(:,1), p1(:,2), 100, 'red', 'filled')
% scatter(p2(:,1), p2(:,2), 100, 'blue', 'filled')
% scatter(p3(:,1), p3(:,2), 100, 'green', 'filled')

scatter(p1_euclidian(1,:), p1_euclidian(2,:), 100, 'red', 'filled')
scatter(p2_euclidian(1,:), p2_euclidian(2,:), 100, 'blue', 'filled')
scatter(p3_euclidian(1,:), p3_euclidian(2,:), 100, 'green', 'filled')

% Compute L1, L2 and L3
syms a b c
L = [a b c].';

% The line which goes through x1 and x2 satisfies:
% L^T*x1 = L^T*x2 = 0

% Compute L1
x1 = p1(:,1);
x2 = p1(:,2);
sol = solve([L.'*x1; L.'*x2] == zeros(2,1));
L1 = [a sol.b sol.c].' / sol.c;
L1 = double(L1);

% Compute L2
x1 = p2(:,1);
x2 = p2(:,2);
sol = solve([L.'*x1; L.'*x2] == zeros(2,1));
L2 = [a sol.b sol.c].' / sol.c;
L2 = double(L2);

% Compute L3
x1 = p3(:,1);
x2 = p3(:,2);
sol = solve([L.'*x1; L.'*x2] == zeros(2,1));
L3 = [a sol.b sol.c].' / sol.c;
L3 = double(L3);

rital([L1 L2 L3])

% Compute the point at which L2 and L3 cross
% This point, x, satisfies:
% L2^T*x = L3^T*x = 0, this can also be calculated as the nullspace of
% [L1^T; L2^T]
syms x1 x2 lambda
x = [x1;x2;lambda];
M = [L2 L3].';
x_cross = null(M); 

x_cross_euclidian = pflat(x_cross);
scatter(x_cross_euclidian(1), x_cross_euclidian(2), 100,  'c', 'filled')

% Add legend
legend('P1', 'P2', 'P3', 'L1', 'L2', 'L3', 'Cross point of L2 and L3')


% Distance between L1 and cross point
d = abs(L1.'*[x_cross_euclidian; 1])/sqrt(L1(1)^2 + L2(2)^2);
fprintf("The distance between L1 and the cross point between L2 and L3 is %f l.u.\n", d)






