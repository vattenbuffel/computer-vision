function Ps = improve_cameras(us, Us, Ps_init, inliers, n, lambda)
    
    Ps = {};
    for i = 1:size(Us,2)
        u = us{i};
        U = Us{i};
        P = Ps_init{i};
        inlier = inliers{i};
        Ps{i} = improve_camera(u, U, P, inlier, n, lambda); 
    end
    
    % Somehow the structure of Ps is whack
    for i = 1:size(Us, 2)
        Ps{i} = Ps{i}{1};
    end


end