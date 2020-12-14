function P = resection(U, u)

    U = euclidian_to_homo(U);
    u = euclidian_to_homo(u);
    
    n_points = size(u,2);
    n_rows = 3*size(u,2);
    n_cols = 12 + size(u,2);
    M = zeros(n_rows, n_cols);
    for i=1:n_points
        % Add X
        start_row_X = (i-1)*3 + 1;
        for j=0:2
            start_col_X = j*size(U,1) + 1;
            end_col_X = j*size(U,1) + size(U,1);
            M(start_row_X+j, start_col_X:end_col_X) = U(:,i).';
        end

        % Add x
        start_row_x = start_row_X;
        end_row_x = start_row_x + 2;
        col_x = i + 12;
        M(start_row_x:end_row_x, col_x) = -u(:,i); 
    end

    [U,S,V] = svd(M);
    v = V(:,end);

    % Extract P from v
    P = -[v(1:4).'
         v(5:8).'
         v(9:12).'];

end