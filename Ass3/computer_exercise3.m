clc; clear all; close all
load('./assignment3data/compEx1Data.mat')
load('./assignment3data/compEx3Data.mat')
img2 = imread('./assignment3data/kronan2.jpg');

P1 = [eye(3) zeros(3,1)];

% Normalize using K^-1
x1_normalized = K^-1*x{1};
x2_normalized = K^-1*x{2};

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

% Find a solution
[U,S,V] = svd(M);
v = V(:,end);

% Make sure the minimum singular value and ||Mv|| are small
S_diag = diag(S);
assert(abs(S_diag(end)) < 10) 
assert(norm(M*v) < 10) 

E_hat = reshape(v, [3 3]).';
[U,S,V] = svd(E_hat);

% Make sure det(U*V^T) = 1
if abs(det(U*V.') + 1) < 10^-10
   V(:,end) = -V(:,end);  
    
end
assert(abs(det(U*V.') - 1) < 10^-10)

E = U*diag([1 1 0])*V.';

% Save parameters for future exercies
save('E_comp3.mat', 'E')
E_svd.V=V;
E_svd.U=U;
save('E_svd_comp3.mat', 'E_svd')

% Check the epipolar constraints 
assert(sum(abs(diag(x2_normalized.'*E*x1_normalized))) < 10) 

% Calculate F
F = (K^-1).'*E*K^-1;

% Compute epipolar lines
l = F*x{1};
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
%and there corresponding lines , and plots in a histogram
figure
distances = abs(sum(l.*x {2}));
hist(distances, 100);
mean_distance = mean(distances);









