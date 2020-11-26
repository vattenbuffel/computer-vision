clc; clear all; close all
load('./assignment3data/compEx1Data.mat')
%img1 = imread('./assignment2data/cube1.jpg');
img2 = imread('./assignment3data/kronan2.jpg');



% Calculate normalization matrices
x1_mean = mean(x{1}.');
x1_std = std(x{1}.'); 
N1 = [1/x1_std(1) 0 -x1_mean(1)/x1_std(1)
      0 1/x1_std(2) -x1_mean(2)/x1_std(2)
      0 0 1];
% N1 = eye(3);
x1_normalized = N1*x{1}; 

x2_mean = mean(x{2}.');
x2_std = std(x{2}.'); 
N2 = [1/x2_std(1) 0 -x2_mean(1)/x2_std(1)
      0 1/x2_std(2) -x2_mean(2)/x2_std(2)
      0 0 1];
% N2 = eye(3);
x2_normalized = N2*x{2}; 

% Create M in the eight point algorithm
M = [];
for i=1:size(x{1},2)
    points_in_img2 = x2_normalized(:,i); 
    x_in_2 = points_in_img2(1); 
    y_in_2 = points_in_img2(2); 
    z_in_2 = points_in_img2(3);
    
    points_in_img1 = x1_normalized(:,i); 
    x_in_1 = points_in_img1(1); 
    y_in_1 = points_in_img1(2); 
    z_in_1 = points_in_img1(3);
    
    next_row = [x_in_2*x_in_1 x_in_2*y_in_1 x_in_2*z_in_1 y_in_2*x_in_1 y_in_2*y_in_1 y_in_2*z_in_1 z_in_2*x_in_1 z_in_2*y_in_1 z_in_2*z_in_1];
    
    M = [M;
         next_row];
end

% Find a non-noisy solution
[U,S,V] = svd(M);
v = V(:,end);
F_hat = reshape(v, [3 3]).';
[U,S,V] = svd(F_hat);
S(end,end) = 0;
F = U*S*V.';

% Make sure det(F) = 0
assert(abs(det(F)) < 10^-10)

% Minimum singular value is 0
Mv = norm(M*v); % This is small

% Check epipolar constraints
assert(sum(abs(diag(x2_normalized.'*F*x1_normalized))) < 10) 

% Compute unnormalized F
F_unnormalized = N2.'*F*N1;
F_unnormalized = F_unnormalized/F_unnormalized(3,3);

% Compute epipolar lines
l = F_unnormalized*x{1};
l = l./sqrt(repmat(l(1,:).^2+l(2,:).^2,[3, 1]));


% Plot epipolar lines, the corresponding points and the image
hold on
axis equal
title('Points, epipolar lines and image2')
axis ij
imagesc(img2)

% Chose 20 random points
random_indices = floor(rand(1,20)*size(l,2)+1);
x2_euclidian = pflat(x{2});
plot(x2_euclidian(1,random_indices), x2_euclidian(2,random_indices), 'r*','MarkerSize',10,'LineWidth',2);
rital(l(:,random_indices))
legend('points', 'epipolar lines corresponding to the points')
xlim([0 2000])


% Computes all the the distances between the points
%and their corresponding lines , and plots in a histogram
figure
distances = abs(sum(l.*x {2}));
hist(distances ,100);
mean_distance = mean(distances);
























