clc; clear all; close all
load('./assignment3data/compEx1Data.mat')
%img1 = imread('./assignment2data/cube1.jpg');
img2 = imread('./assignment3data/kronan2.jpg');
load('fundamental_matrix_from_comp1.mat')
F = F_unnormalized;

P1 = [eye(3) zeros(3,1)];

% Calculate P2
e2 = null(F_unnormalized.');
e2x = skew(e2);
P2 = [e2x*F e2];

% Normalize the image points
x1_mean = mean(x{1}.');
x1_std = std(x{1}.'); 
N1 = [1/x1_std(1) 0 -x1_mean(1)/x1_std(1)
      0 1/x1_std(2) -x1_mean(2)/x1_std(2)
      0 0 1];
  
x1_normalized = N1*x{1}; 

x2_mean = mean(x{2}.');
x2_std = std(x{2}.'); 
N2 = [1/x2_std(1) 0 -x2_mean(1)/x2_std(1)
      0 1/x2_std(2) -x2_mean(2)/x2_std(2)
      0 0 1];
  
x2_normalized = N2*x{2}; 


% Calculate the 3D points using DLT
n_rows = 2*3;
n_cols = 4+2;
M = zeros(n_rows, n_cols);
M(:, 1:4) = [N1*P1;N2*P2];

points_3D = [];

for i =  1 : size(x1_normalized, 2)
    M(1:3, 5) = -x1_normalized(:,i);
    M(4:6, 6) = -x2_normalized(:,i);
         
    [U,S,V] = svd(M);
    
    v = V(:,end);
    X = -v(1:4);
    points_3D = [points_3D X];
end

% Project 3D points into camera 2
x_cam_2 = P2*points_3D;
x_cam_2_euclidian = pflat(x_cam_2);

% Plot everything
hold on
axis equal
title('image points, projected 3D points and image 2')
axis ij
imagesc(img2)
scatter(x_cam_2_euclidian(1,:), x_cam_2_euclidian(2,:), 'o')
scatter(x{2}(1,:), x{2}(2,:), '*')
legend('Projected 3D points', 'Image points')

% plot the 3D points
figure
hold on
%axis equal
title('3D points')
axis ij
points_3D_euclidian = pflat(points_3D);
plot3(points_3D_euclidian(1,:), points_3D_euclidian(2,:), points_3D_euclidian(3,:), '.')


















