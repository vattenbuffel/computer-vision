clc; clear all; close all
load('./assignment4data/compEx1Data.mat')
img_a = imread('./assignment4data/a.jpg');
img_b = imread('./assignment4data/b.jpg');

[fA dA] = vl_sift(single(rgb2gray(img_a)) );
[fB dB] = vl_sift(single(rgb2gray(img_b)) );
matches = vl_ubcmatch(dA ,dB );
xA = fA(1:2 , matches(1 ,:));
xB = fB(1:2 , matches(2 ,:));
xA_homo = [xA; ones(1, size(xA,2))];
xB_homo = [xB; ones(1, size(xA,2))];


% Estimate H using ransac
H_best = [];
inliers_n_best = -1;
inliers_best = [];

n_points = 4;
n_rows = 2*n_points; 
n_cols = 9;

for i = 1:1000 
    rand_inds = randi(size(xA,2), [1,n_points]);
    points_img_a = xA(:, rand_inds); % Will be treated as img1
    points_img_b = xB(:, rand_inds); % Will be treated as img2

    points_img_a_homo = [points_img_a; ones(1, n_points)];
    points_img_b_homo = [points_img_b; ones(1, n_points)];

    x_img1 = points_img_a(1,:);
    y_img1 = points_img_a(2,:);
    u_img2 = points_img_b(1,:);
    v_img2 = points_img_b(2,:);

    % Create the M matrix
    M = zeros(n_rows, n_cols);
    p = linspace(1,n_rows, n_rows);
    p_odd = p.*mod(p,2);
    p_odd(p_odd == 0) = [];
    p_even= p.*mod(p+1,2);
    p_even(p_even == 0) = [];

    M(p_odd, 1) = x_img1;
    M(p_odd, 2) = y_img1;
    M(p_odd, 3) = 1;
    M(p_even, 4) = x_img1;
    M(p_even, 5) = y_img1;
    M(p_even, 6) = 1;

    odd_rows_right = -points_img_a_homo.'.*u_img2.';
    even_rows_right = -points_img_a_homo.'.*v_img2.';
    M(p_odd, 7:end) = odd_rows_right;
    M(p_even, 7:end) = even_rows_right;

    [U,S,V] = svd(M);
    v = V(:,end);
    H = reshape(v,[3,3]).';

    % Calculate inliers
    distances = sqrt(sum((pflat(xB_homo) - pflat(H*xA_homo)).^2));
    inliers = distances < 5;
    inliers_n = sum(inliers);

    if (inliers_n > inliers_n_best)
        H_best = H;
        inliers_n_best = inliers_n;
        inliers_best = inliers;
    end
end

% Transform the image

% Creates a transfomation that matlab can use for images
% Note : imtransform uses the transposed homography
tform = maketform('projective', H_best');

% Finds the bounds of the transformed image
transfbounds = findbounds(tform, [1 1; size(img_a, 2) size(img_a, 1)]);

% Computes bounds of a new image such that both the old ones will fit.
xdata = [min([transfbounds(:, 1);1]) max([transfbounds(:, 1);size(img_b, 2)])];
ydata = [min([transfbounds(:, 2);1]) max([transfbounds(:, 2);size(img_b, 1)])];

% Computes bounds of a new image such that both the old ones will fit.
[img_a_new] = imtransform(img_a, tform, 'xdata', xdata, 'ydata', ydata);

% Transform the image using bestH
tform2 = maketform('projective', eye(3));

% Creates a larger version of img_b
[img_b_new] = imtransform(img_b, tform2, 'xdata', xdata, 'ydata', ydata, 'size', size(img_a_new));

% Writes both images in the new image. 
%(A somewhat hacky solution is needed since pixels outside the valid image
% area are not allways zero ...)
img_ab = img_b_new;
img_ab(img_b_new<img_a_new) = img_a_new(img_b_new<img_a_new);

imagesc(img_ab)














