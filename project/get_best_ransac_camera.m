
% Loop over all the images and exract ransac best cameras and inliers.
% Maybe not loop  over all?
function [P_best, inliers] = get_best_ransac_camera(obj_idx, threshold, U, u)
    n_inliers_max = -1;
    P_best = [];
    n_iterations = 1000; % Calculate how many this should be somehow
    
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
           n_inliers = sum(root_error(pflat(x), u{obj_idx}) < threshold);

           if n_inliers > n_inliers_max
              n_inliers_max = n_inliers;
              P_best = P;
           end

        end

    end
    
    % Get the inliers
    x = P_best * euclidian_to_homo(U{obj_idx});
    inlier_idx = root_error(pflat(x), u{obj_idx}) < threshold;
    inliers = U{obj_idx}(:,inlier_idx);
end