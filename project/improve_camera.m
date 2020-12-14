    function P = improve_camera(u, U, P, inliers, n, lambda)
%     clc; clear all; close all
%     load('Ps.mat')
%     load('inliers.mat')
%     load('./data/data1.mat')

    U_homo =  euclidian_to_homo(U(:,inliers));
    u_homo =  euclidian_to_homo(u(:,inliers));
    u_homo = {u_homo};
    P = {P};
    
    [err,res] = ComputeReprojectionError(P, U_homo , u_homo);
%     histogram(res, 100)
%     hold on
%     title('Initial residuals')

    
    reproj_error = zeros(1,n+1);
    reproj_error(1) = err;
    for i = 1:n    
        %Computes the r and J matrices for the appou_homoimate linear least squares problem .
        [r,J] = LinearizeReprojErr(P,U_homo,u_homo);

        % Computes the LM update.
        C = J' * J + lambda * speye(size(J ,2));

        c = J' * r;
        deltav = -C\c;
        % Updates the variabels
        [P] = update_solution (deltav, P);

        % Save reprojection error
        [err,res] = ComputeReprojectionError(P, U_homo, u_homo);
        reproj_error(i+1) = err;
    end

%     figure
%     [err,res] = ComputeReprojectionError(P, U, u_homo);
%     histogram(res, 100)
%     hold on
%     title('Improved residuals')
% 
%     figure
%     plot(reproj_error)
%     title('Reprojection error')
end






























