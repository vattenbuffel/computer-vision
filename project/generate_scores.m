function [scores_ms, scores_ms_ransac, scores_ms_ransac_LM] = generate_scores(nr, should_plot)

    % Get the required data
    [im1, u, U, poses, bounding_boxes] = load_data(nr);

    % Parameters for the code
    ransac_threshold = 0.001; % 0.001 and 0.005 both seem good
    n_iterations_RANSAC = 1000;
    n_iterations_LM = 1000;
    lambda_LM = 10^-5;

    classes = ["ape", "can", "cat", "duck", "eggbox", "glue", "holepuncher"];

    % Just minimal solver camera
    fprintf("Error with just ms\n")
    Ps = minimal_solver_cameras(u, U);
    scores_ms = get_scores(Ps, should_plot, bounding_boxes, poses, im1, 'ms');
    
    
    % Find ransac cameras and inliers
    Ps = {};
    inliers = {};

    for obj_idx = 1:size(U, 2)
        [P, inlier] = get_best_ransac_camera(obj_idx, ransac_threshold, U, u, n_iterations_RANSAC);
        Ps{obj_idx} = P;
        inliers{obj_idx} = inlier;

%         if should_plot
%             figure
%             axis ij
%             inlier_points = U{obj_idx}(:,inliers{obj_idx});
%             plot3(inlier_points(1,:), inlier_points(2,:), inlier_points(3,:), '.')
%             title('Ransac inliers')
%             legend(append(classes(obj_idx), ' - inliers'))
%         end
    end

    fprintf("Error with ransac\n")
    scores_ms_ransac = get_scores(Ps, should_plot, bounding_boxes, poses, im1, 'ms&ransac');


    fprintf("Error with ransac and refinement(LM)\n")
    % Improve the cameras matrix using LM
    Ps = improve_cameras(u, U, Ps, inliers, n_iterations_LM, lambda_LM);
    
    scores_ms_ransac_LM = get_scores(Ps, should_plot, bounding_boxes, poses, im1, 'ms&ransac&LM');
    
end

function scores = get_scores(Ps, should_plot, bounding_boxes, poses, im1, fig_title)
    P_est = Ps;
    if should_plot
        draw_bounding_boxes (im1 , poses , P_est , bounding_boxes);
        hold on
        title(fig_title)
    end
    % Compute ( and print out ) the score for each estimated object pose .
    scores = eval_pose_estimates ( poses , P_est , bounding_boxes );
end