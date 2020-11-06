clc; clear all; close all;

load('./assignment1data/compEx4.mat')
U_non_flat = U;
U = pflat(U);
plot3 (U (1 ,:) , U (2 ,:), U (3 ,:) , ' . ');
hold on

center1 = pflat(null(P1));
M1 = P1(1:3, 1:3);
m1 = M1(3,:);
v1 = det(M1)*m1;
quiver3 (center1(1) ,center1(2) ,center1(3) ,v1(1) ,v1(2) ,v1(3) ,10/det(M1))

center2 = pflat(null(P2));
M2 = P2(1:3, 1:3);
m2 = M2(3,:);
v2 = det(M2)*m2;
quiver3 (center2(1) ,center2(2) ,center2(3) ,v2(1) ,v2(2) ,v2(3) ,10/det(M2))


figure
img = imread('./assignment1data/compEx4im1.jpg');
imagesc(img)
colormap gray
U1 = P1*U_non_flat;
U1 = pflat(U1);
hold on
plot (U1 (1 ,:) , U1 (2 ,:), ' . ');
axis equal


figure
img = imread('./assignment1data/compEx4im2.jpg');
imagesc(img)
colormap gray
U2 = P2*U_non_flat;
U2 = pflat(U2);
hold on
plot (U2 (1 ,:) , U2 (2 ,:), ' . ');
axis equal

