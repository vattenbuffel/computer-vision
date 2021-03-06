clc; clear all; close all;

load('./assignment1data/compEx5.mat')
img = imread('./assignment1data/compEx5.jpg');

imagesc(img)
colormap gray
axis equal
hold on

P1 = K*[eye(3) zeros(3,1)];

% Calculate the corners and plot them
corners_euclidian = pflat(corners);
plot ( corners_euclidian (1 ,[1: end 1]) , corners_euclidian (2 ,[1: end 1]) , ' *- ' ); 


% Normalize the corners and plot them
figure
axis ij
axis equal
normalized_corner = (K^-1)*corners;
normalized_corners_euclidian = pflat(normalized_corner);
plot ( normalized_corners_euclidian (1 ,[1: end 1]) , normalized_corners_euclidian (2 ,[1: end 1]) , ' *- ' ) 

% Compute the location of the corners in 3D and plot them
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

% Calculate the center and principal axis of the orginal camera and plot 
camera_center = null(P2);
M = P2(1:3, 1:3);
m = M(3,:);
principial_axis = det(M)*m;
quiver3 (camera_center(1) ,camera_center(2) ,camera_center(3) ,principial_axis(1) ,principial_axis(2) ,principial_axis(3) ,1/det(M))



% Plot the 3D corners, original camera and new camera
figure
axis ij
axis equal
hold on

plot3(U_euclidian (1 ,[1: end 1]) , U_euclidian (2 ,[1: end 1]), U_euclidian (3 ,[1: end 1]) , ' *- ' ) 
quiver3 (camera_center(1) ,camera_center(2) ,camera_center(3) ,principial_axis(1) ,principial_axis(2) ,principial_axis(3) ,1/det(M))

R =     [cos(pi/9) 0 -sin(pi/9)
         0 1 0
         sin(pi/9) 0 cos(pi/9)];

camera_center_new = [-1 0 0].';
M_new = R;
m_new = R(3,:);
principial_axis_new = det(M_new)*m_new;
quiver3 (camera_center_new(1) ,camera_center_new(2) ,camera_center_new(3) ,principial_axis_new(1) ,principial_axis_new(2) ,principial_axis_new(3) ,1/det(M))

legend('Corners', 'Original camera', 'New camera')

% Plot the corners from the new camera
figure
axis ij
axis equal
hold on

% Calculate the homography mapping the cameras
% Start by calculating t:
% P = [R t]
% null(P) = P * camera_center = 0

syms t1 t2 t3
P_new = [R [t1;t2;t3]];
sol = solve(P_new*[camera_center_new; 1] == 0);
t = [sol.t1; sol.t2; sol.t3];
t = double(t);

% Calculate the homography based on exercise 6 and transform the corners
H = R-t*pflat(v).';
corners_new = H*normalized_corner;
corners_new_euclidian = pflat(corners_new);

plot(corners_new_euclidian (1 ,[1: end 1]) , corners_new_euclidian (2 ,[1: end 1]), ' *- ' ) 

% Transform the 3D points using the homography
corners_3D_to_2D = pflat(H*pflat(U));
plot(corners_3D_to_2D (1 ,[1: end 1]) , corners_3D_to_2D (2 ,[1: end 1]), ' *- ' ) 
legend('Normalized corner to 2D view', '3D corners to 2D view')

% Transofrm the image into the view of the new camera and plot it
figure
hold on
axis equal
H_tot = K*H*(K^-1);
tform = projective2d(H_tot.');
[im_new , RB] = imwarp (img , tform);
imshow (im_new, RB );

     
     
     
     
     
     
     
     