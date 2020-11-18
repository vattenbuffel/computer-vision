clc; clear all; close all

% Load the saved parameters
load('./assignment2data/compEx3Data.mat')
load('P1.mat')
load('P2.mat')
load('x1_matching.mat')
load('x2_matching.mat')
img1 = imread('./assignment2data/cube1.jpg');
img2 = imread('./assignment2data/cube2.jpg');


% Triangulate using simplified DLT
n_rows = 2*3;
n_cols = 4+2;
M = zeros(n_rows, n_cols);
M(:, 1:4) = [P1;P2];

points_3D = [];

for i =  1 : size(x1, 2)
    M(1:3, 5) = -[x1(:,i); 1];
    M(4:6, 6) = -[x2(:,i); 1];
         
    [U,S,V] = svd(M);
    
    v = V(:,end);
    X = -v(1:4);
    points_3D = [points_3D X];
end

% Project the points back into 2D and plot them together with the sift
% points
points_2D_euclidian_cam1 = pflat(P1*points_3D);

figure
axis ij
title('Triangulated points together with sift points, camera 1')
hold on
axis equal
imagesc(img1)
scatter(points_2D_euclidian_cam1(1,:), points_2D_euclidian_cam1(2,:))
scatter(x1(1,:), x1(2,:), '*')
legend('DLT points', 'SIFT')

points_2D_euclidian_cam2 = pflat(P2*points_3D);
figure
axis ij
axis equal
title('Triangulated points together with sift points, camera 2')
hold on
imagesc(img1)
scatter(points_2D_euclidian_cam2(1,:), points_2D_euclidian_cam2(2,:))
scatter(x2(1,:), x2(2,:), '*')
legend('DLT points', 'SIFT')


% Normalize and triangulate using simplified DLT
K1 = rq(P1);
K1 = K1/K1(3,3);
K1_inv = K1^-1;
K2 = rq(P2);
K2 = K2/K2(3,3);
K2_inv = K2^-1;

M(:, 1:4) = [K1_inv*P1; K2_inv*P2];

points_3D = [];

for i =  1 : size(x1, 2)
    M(1:3, 5) = K1_inv*-[x1(:,i); 1];
    M(4:6, 6) = K2_inv*-[x2(:,i); 1];
         
    [U,S,V] = svd(M);
    
    v = V(:,end);
    X = -v(1:4);
    points_3D = [points_3D X];
end

% Project the points back into 2D and plot them together with the sift
% points
points_2D_euclidian_cam1 = pflat(P1*points_3D);

figure
axis ij
title('Normalized and triangulated points together with sift points, camera 1')
hold on
xlim([0 2000])
imagesc(img1)
scatter(points_2D_euclidian_cam1(1,:), points_2D_euclidian_cam1(2,:))
scatter(x1(1,:), x1(2,:), '*')
legend('DLT points', 'SIFT')

points_2D_euclidian_cam2 = pflat(P2*points_3D);
figure
axis ij
xlim([0 2000])
title('Normalized and triangulated points together with sift points, camera 2')
hold on
imagesc(img1)
scatter(points_2D_euclidian_cam2(1,:), points_2D_euclidian_cam2(2,:))
scatter(x2(1,:), x2(2,:), '*')
legend('DLT points', 'SIFT')


% Calculate reprojection error
good_points = (sqrt(sum((x1-points_2D_euclidian_cam1(1:2,:)).^2))<3&...
               sqrt(sum((x2-points_2D_euclidian_cam2(1:2,:)).^2))<3);

points_3D_good = points_3D(:, good_points);
points_3D_good_euclidian = pflat(points_3D_good);

% Plot the good 3D points, the cameras and the cube model
figure
hold on
title('good 3D points, the cameras and the cube model')
plot3(Xmodel(1,:) , Xmodel(2,:), Xmodel(3,:), '.')
plot3(points_3D_good_euclidian(1,:) , points_3D_good_euclidian(2,:), points_3D_good_euclidian(3,:), '.')
plotcams({P1, P2}) 
legend('Cube model', 'Good 3D points', 'Cameras')













