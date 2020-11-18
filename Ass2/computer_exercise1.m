clc; clear all; close all
load('./assignment2data/compEx1Data.mat')
% img = imread('./assignment1data/compEx5.jpg');

% Plot the 3D points and the cameras
figure
axis equal
hold on
title('3D points of scene')

X_euclidian = pflat(X);
plot3(X_euclidian(1,:) , X_euclidian(2,:), X_euclidian(3,:), '.')
plotcams(P)


% Project the 3D images into one of the cameras
figure
axis equal
hold on
colormap gray
title('image, 2D points and projected 3D points')
camera_nr = 1;

img = imread ( append('./assignment2data/', imfiles {camera_nr}));
imagesc(img)

% Extract the points which are visible from the chosen camera
visible = isfinite (x{camera_nr }(1 ,:));
% Plot the points
plot (x{camera_nr}(1 , visible ), x{camera_nr}(2 , visible ), ' * ' );
% Move the 3D points into the camera
x_image_plane = pflat(P{camera_nr}*X(:, visible));
plot(x_image_plane(1,:) , x_image_plane(2,:), '.')


% Create new solutions using 2 projective transforms
T1 = [1 0 0 0
      0 4 0 0
      0 0 1 0
      1/10 1/10 0 1];
T2 =[1 0 0 0
     0 1 0 0
     0 0 1 0
     1/16 1/16 0 1];

P_T1 = P;
P_T2 = P;
for i = 1:9
    P_T1{i} = P{i}*T1;
    P_T2{i} = P{i}*T2;
end
 
X_T1 = T1^-1*X;
X_T2 = T2^-1*X;

% Plot the new 3D cooridnates and cameras
figure
hold on
axis equal
title('new 3D cooridnates and cameras T1')
X_T1_euclidian = pflat(X_T1);
plot3(X_T1_euclidian(1,:) , X_T1_euclidian(2,:), X_T1_euclidian(3,:), '.')
plotcams(P_T1) 

figure
hold on
axis equal
title('new 3D cooridnates and cameras T2')
X_T2_euclidian = pflat(X_T2);
plot3(X_T2_euclidian(1,:) , X_T2_euclidian(2,:), X_T2_euclidian(3,:), '.')
plotcams(P_T2) 



 
% Project the new 3D images into one of the new cameras and plot them with
% the image points and the image
figure
axis equal
hold on
colormap gray
title('image, 2D points and projected new 3D points')
camera_nr = 1;

imagesc(img)

% Plot the points
plot (x{camera_nr}(1 , visible ), x{camera_nr}(2 , visible ), ' * ' );
% Move the new 3D points into the camera
x_image_plane_T1 = pflat(P_T1{camera_nr}*X_T1(:, visible));
plot(x_image_plane_T1(1,:) , x_image_plane_T1(2,:), '.')
 
 
 
 
 
 
 

