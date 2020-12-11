clc; clear all; close all
load('./assignment3data/compEx1Data.mat')
load('./assignment3data/compEx3Data.mat')
% img1 = imread('./assignment4data/house1.jpg');

%x{1} = inv(K)*x{1};
%x{2} = inv(K)*x{2};

load('P2')
P2_init = K*P2;
%P2_init = P2;
clear P2
P1_init = K*[eye(3), zeros(3,1)]; 
%P1_init = [eye(3), zeros(3,1)]; 
P_init = {P1_init, P2_init};

load('X')
X_init = [pflat(X); ones(1,2008)];
clear X

lambda = 10^-9;

% Compute initial residuals
[err,res] = ComputeReprojectionError(P_init, X_init, x);
histogram(res, 100)
hold on
title('Initial residuals')

U = X_init;
P = P_init;
n = 200;
reproj_error = zeros(1,n+1);
reproj_error(1) = err;
for i = 1:n    
    %Computes the r and J matrices for the appoximate linear least squares problem .
    [r,J] = LinearizeReprojErr(P,U,x);
    
    % Computes the LM update.
    C = J' * J + lambda * speye(size(J ,2));

    c = J' * r;
    deltav = -C\c;
    % Updates the variabels
    [P , U ] = update_solution (deltav, P, U);
    
    % Save reprojection error
    [err,res] = ComputeReprojectionError(P, U, x);
    reproj_error(i+1) = err;
end

figure
[err,res] = ComputeReprojectionError(P, U, x);
histogram(res, 100)
hold on
title('Improved residuals')

figure
plot(reproj_error)
title('Reprojection error')


save('P')

















