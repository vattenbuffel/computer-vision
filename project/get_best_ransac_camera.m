function [P_best, inliers_max] = get_best_ransac_camera(obj_idx, threshold, U, u, n_iterations)
    n_inliers_max = -1;
    P_best = [];
    inliers_max = [];
    
    root_error = @(x, y) (sum((x-y).^2)).^(0.5);

    for i = 1:n_iterations 
        % Get candidate cameras
        n_points = size(U{obj_idx}, 2);
         ind = randsample(n_points, 6); % 11 degrees of freedom?
        P = resection(U{obj_idx}(:, ind), u{obj_idx}(:, ind));
        
       
        % Calculate number of inliers
       x = P*euclidian_to_homo(U{obj_idx});
       inliers = root_error(pflat(x), u{obj_idx}) < threshold;
       n_inliers = sum(inliers);

        % Calibrate
        K = rq(P);
        P = inv(K)*P;

        if abs(det(P(:,1:3)) - 1) > 10^-5
            continue
        end

       
        if n_inliers > n_inliers_max
          n_inliers_max = n_inliers;
          P_best = P;
          inliers_max = inliers;
        end
    end
end

























