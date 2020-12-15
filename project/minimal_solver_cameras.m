function Ps = minimal_solver_cameras(u, U)
    Ps = [];
     
    for obj_idx = 1:7

        n_points = size(U{obj_idx}, 2);
        ind = randsample(n_points, 3);
        P = minimalCameraPose(pextend(u{obj_idx}(:, ind)), U{obj_idx}(:, ind));
        if size(P,2) > 1% Hur ska det här hanteras?
            P = P{1}; 
        end
        Ps = [Ps {P}];
    end
        
end