clc; clear all; close all;

load('./assignment1data/compEx5.mat')
img = imread('./assignment1data/compEx5.jpg');

imagesc(img)
colormap gray
axis equal
hold on

P1 = K*[eye(3) zeros(3,1)];

corners_euclidian = pflat(corners);
plot ( corners_euclidian (1 ,[1: end 1]) , corners_euclidian (2 ,[1: end 1]) , ' *- ' ); 


figure
axis ij
axis equal
normalized_corner = (K^-1)*corners;
normalized_corners_euclidian = pflat(normalized_corner);
plot ( normalized_corners_euclidian (1 ,[1: end 1]) , normalized_corners_euclidian (2 ,[1: end 1]) , ' *- ' ) 

figure
axis ij
axis equal
hold on

P2 = [eye(3) zeros(3,1)];
syms s1 s2 s3 s4
U = [normalized_corner; s1 s2 s3 s4];
s = solve(v.'*U == zeros(4,1));
s = double([s.s1 s.s2 s.s3 s.s4]);
U = [normalized_corner; s];
U_euclidian = pflat(U);
plot3(U_euclidian (1 ,[1: end 1]) , U_euclidian (2 ,[1: end 1]), U_euclidian (3 ,[1: end 1]) , ' *- ' ) 


camera_center = null(P2);
M = P2(1:3, 1:3);
m = M(3,:);
principial_axis = det(M)*m;
quiver3 (camera_center(1) ,camera_center(2) ,camera_center(3) ,principial_axis(1) ,principial_axis(2) ,principial_axis(3) ,1/det(M))

R =     [cos(pi/9) 0 -sin(pi/9)
         0 1 0
         sin(pi/9) 0 cos(pi/9)];
     
t = [0 0 -1].';
H = R-t*pflat(v).';
corners_new = H*normalized_corner;
corners_new_euclidian = pflat(corners_new);

figure
axis ij
axis equal
hold on
plot(corners_new_euclidian (1 ,[1: end 1]) , corners_new_euclidian (2 ,[1: end 1]), ' *- ' ) 


figure
close all
hold on
axis equal
H_tot = K*H*(K^-1);
tform = projective2d(H_tot.');
[im_new , RB] = imwarp (img , tform);
imshow (im_new, RB );

     
     
     
     
     
     
     
     