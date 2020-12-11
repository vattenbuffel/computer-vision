clc; clear all; close all
load('./assignment4data/compEx1Data.mat')
img1 = imread('./assignment4data/house1.jpg');
img2 = imread('./assignment4data/house2.jpg');

X = X./X(end,:);

meanX = mean(X ,2); % Computes the mean 3D point
Xtilde = (X - repmat(meanX ,[1 size(X, 2)]));
% Subtracts the mean from the 3D points
M = Xtilde (1:3 ,:)* Xtilde (1:3 ,:).'; % Computes the matrix from Exercise 2
[V,D] = eig(M); % Computes eigenvalues and eigenvectors of M

% Calculate d
abc = V(:,1);
a = abc(1);
b = abc(2);
c = abc(3);

meanX_euclidian = pflat(meanX);
d = -(abc.'*meanX_euclidian);
abcd = [abc;d].';
abcd = abcd ./norm(abc);


% Calculate erms
X_euclidian = pflat(X);
m = size(X,2);
e_rms = sqrt(1/m * sum((abcd*[X_euclidian;ones(1,m)]).^2/sum(abc.^2)));


% Calculate distances and plot a histogram
distances = abs(sum(abcd.'.*[X_euclidian;ones(1,m)]));
hist(distances, 100);
hold on
title('Distance between rms plane and points')

% Ransac
biggest_consensus_set = -1;
best_plane = [];
best_inliers_included = [];
for i = 1:7000
    randind = randperm(m, 3);
    plane = null(X(:, randind).');
    % Computes a plane from a sample set.
    
    plane = plane./ norm(plane(1:3));
    % Makes sure that the plane normal has a unit length norm
    
    inliers = abs(plane' * [X_euclidian;ones(1,m)]) <= 0.1;
    % Finds the the indices for which the distance to the plane is less than 0.1.
    % Note : Works only if the 4th coordinate of all the points in X are 1, and the plane has unit normal.
    
    
    % Check if the new plane is the best plane
    if (biggest_consensus_set < sum(inliers))
        biggest_consensus_set = sum(inliers);
        best_plane = plane;
        best_inliers_included = inliers;
    end
end
RMS = sqrt(sum((best_plane' * [X_euclidian;ones(1,m)]).^2)/sum(best_plane(1:3).^2)/ size(X ,2)); % Computes the RMS error. 

% Calculate distances and plot a histogram
distances = abs(sum(best_plane.*[X_euclidian;ones(1,m)]));
figure
hist(distances, 100);
hold on
title('Distance between ransac plane and points')


% Project the inliers into the cameras
x_cam1 = P{1}*X(:,best_inliers_included);
x_cam1_euclidian = pflat(x_cam1);
figure
hold on
axis equal
title('image 1 and projcted points')
axis ij
imagesc(img1)
plot(x_cam1_euclidian(1,:), x_cam1_euclidian(2,:), 'r*','MarkerSize',5,'LineWidth',2)


x_cam2 = P{2}*X(:,best_inliers_included);
x_cam2_euclidian = pflat(x_cam2);
figure
hold on
axis equal
title('image 2 and projcted points')
axis ij
imagesc(img2)
plot(x_cam2_euclidian(1,:), x_cam2_euclidian(2,:), 'r*','MarkerSize',5,'LineWidth',2)


% Calculate the mapping homography
P2_hat = inv(K)*P{2};
R = P2_hat(1:3,1:3);
t = P2_hat(:,end);
pi_small = pflat(best_plane);
H = (R-t*pi_small.');
H_unnormalized = K*H*inv(K);

% plot the points in img1
figure
hold on
axis equal
title('x in img1')
axis ij
imagesc(img1)
plot(x(1,:), x(2,:), 'r*','MarkerSize',10,'LineWidth',2)


% plot the points in img2
figure
hold on
axis equal
title('x in img2')
axis ij
imagesc(img2)
%x = inv(K)*x;
x_img2 = H_unnormalized*x;
%x_img2 = x_img2 ./ x_img2(end, :);
%x_img2 = K*x_img2;
x_img2_euclidian = pflat(x_img2);
plot(x_img2_euclidian(1,:), x_img2_euclidian(2,:), 'r*','MarkerSize',10,'LineWidth',2)

















