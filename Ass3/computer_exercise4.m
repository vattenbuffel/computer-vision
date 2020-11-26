clc; clear all; close all

load('E_comp3.mat')
load('E_svd_comp3.mat')
load('./assignment3data/compEx3Data.mat')
load('./assignment3data/compEx1Data.mat')
img2 = imread('./assignment3data/kronan2.jpg');

P1 = [eye(3) zeros(3,1)];

% % Normalize using K^-1
x1_normalized = K^-1*x{1};
x2_normalized = K^-1*x{2};


% Extract P2 from E
U = E_svd.U;
V = E_svd.V;
W = [0 -1 0
     1 0 0
     0 0 1]; 
u3 = U(:,3);

% There are 4 possible P2s
P2{1} = [U*W*V.' u3]; 
P2{2} = [U*W*V.' -u3];
P2{3} = [U*W.'*V.' u3];
P2{4} = [U*W.'*V.' -u3];

% Calculate the 3D points from P2 using DLT
n_rows = 2*3;
n_cols = 4+2;
K_inv = inv(K);

M0 = zeros(n_rows, n_cols);
M = {[], [], [], []};
points_3D = [];
for i=1:4
    M{i} = M0;
    M{i}(:, 1:4) = [P1;P2{i}];
    points_3D{i} = [];
end

for i =  1 : size(x1_normalized, 2)
    for j=1:4
        M{j}(1:3, 5) = -x1_normalized(:,i);
        M{j}(4:6, 6) = -x2_normalized(:,i);

        [U,S,V] = svd(M{j});

        v = V(:,end);
        X = -v(1:4);
        points_3D{j} = [points_3D{j} X]; 
    end
end


for i=1:4
    X_euclidian{i} = pflat(points_3D{i});
end

% plot the 3D points and cameras
for i=1:4
    figure
    hold on
    axis equal
    title_ = append('3D points, P{2_', string(i), '}');
    title(title_)
    axis ij
    plot3(X_euclidian{i}(1,:), X_euclidian{i}(2,:), X_euclidian{i}(3,:), '.')
    plotcams({P1 P2{i}})
    xlabel('x')
    ylabel('y')
    zlabel('z')
end


% P24 is the correct P2 matrix
% Project back into 2D
correct_index = 4;
x_cam_2 = K*P2{correct_index}*points_3D{correct_index};
x_cam_2_euclidian = pflat(x_cam_2);

figure
hold on
axis equal
axis ij
title_ = append('2D points, P{2_', string(correct_index), '}');
title(title_)
imagesc(img2)    
scatter(x_cam_2_euclidian(1,:), x_cam_2_euclidian(2,:), 'o')
scatter(x{2}(1,:), x{2}(2,:), '*')
legend('Projected 3D points', 'Image points')
































