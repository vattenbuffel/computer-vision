function [P_best, inliers_max] = get_best_ransac_camera(obj_idx, threshold, U, u, n_iterations)
    n_inliers_max = -1;
    P_best = [];
    inliers_max = [];

    root_error = @(x, y) (sum((x-y).^2)).^(0.5);

    for i = 1:n_iterations 
        % Get candidate cameras
        n_points = size(U{obj_idx}, 2);
        ind = randsample(n_points, 3);
        Ps = minimalCameraPose(pextend(u{obj_idx}(:, ind)), U{obj_idx}(:, ind));

        % Calculate number of inliers
        for p_index = 1:size(Ps,2)
           P = Ps{p_index};
           x = P*euclidian_to_homo(U{obj_idx});
           inliers = root_error(pflat(x), u{obj_idx}) < threshold;
           n_inliers = sum(inliers);

           if n_inliers > n_inliers_max
              n_inliers_max = n_inliers;
              inliers_max = inliers;
              P_best = P;
           end
        end
    end
    
    % Make sure the camera is calibrated, ie P = [R t]
    P_best = rq(P_best)\P_best;
    
    % Make sure that R is actually a rotation matrix, det(R) = 1
    R = P_best(:, 1:3);
    if ~(abs(det(R) - 1) < 10^-5)
        P_best = -P_best;
    end

end 