% Camera 1
clc; clear all; close all
load('./assignment2data/compEx3Data.mat')
img1 = imread('./assignment2data/cube1.jpg');

x1 = x{1};
% x1 = x{1}(:, [1, 4, 13, 16, 25, 28, 31]); Xmodel = Xmodel(:, [1, 4, 13, 16, 25, 28, 31]);

x1_mean = mean(x1.');
mean (x{1 }(1:2 ,:) ,2)
x1_std = std(x1.');
N = [1/x1_std(1) 0 -x1_mean(1)/x1_std(1)
     0 1/x1_std(2) -x1_mean(2)/x1_std(2)
     0 0 1];
% N = eye(3)

x1_normalized = N*x1; 

figure
axis equal
title('Normalized x-y for x{1}')
hold on
x1_normalized_euclidian = pflat(x1_normalized);
scatter(x1_normalized_euclidian(1,:), x1_normalized_euclidian(2,:))


% Solve the ||Mv|| problem
X = [Xmodel;ones(1, size(Xmodel, 2))];
n_points = size(x1,2);
n_rows = 3*size(x1,2);
n_cols = size(x1,2)*3 + size(x1,2);
M = zeros(n_rows, n_cols);
for i=1:n_points
    % Add X
    start_row_X = (i-1)*3 + 1;
    for j=0:2
        start_col_X = j*size(X,1) + 1;
        end_col_X = j*size(X,1) + size(X,1);
        M(start_row_X+j, start_col_X:end_col_X) = X(:,i).';
    end
    
    % Add x
    start_row_x = start_row_X;
    end_row_x = start_row_x + 2;
    col_x = i + 12;
    M(start_row_x:end_row_x, col_x) = -x1_normalized(:,i); 
end

[U,S,V] = svd(M);
v = V(:,end);

% What is smallest singular value?
Mv = norm(M*v);

% Extract P from v
P = -[v(1:4).'
     v(5:8).'
     v(9:12).'];

% Unnormalize the camera
P_unnormalized1 = N^-1*P;

% Move the 3D points into 2D and compare them to the measured points
xmodel = P_unnormalized1*X;
xmodel_euclidian = pflat(xmodel);
figure
hold on
axis equal
title('PX and measured x')
axis ij
imagesc(img1)
scatter(xmodel_euclidian(1,:), xmodel_euclidian(2,:), '*')
scatter(x1(1,:), x1(2,:))
legend('PX', 'x_{measured}')

% Plot the camera and the model points Why doesnt the camera show up?
figure
hold on
axis equal
title('The camera and Xmodel')
plot3(Xmodel(1,:) , Xmodel(2,:), Xmodel(3,:), '.')
plotcams({P_unnormalized1}) 

K1 = rq(P_unnormalized1);
K1 = K1/K1(end,end);

P1 = P_unnormalized1;
save('P1.mat', 'P1')


% Optional part
erms = @(x_proj)sqrt(1/size(x1, 2)*norm(pflat(x1)-pflat(x_proj), 'fro')^2);
rms_error = erms(xmodel)


%%
% Camera 2
clc; clear all; close all
load('./assignment2data/compEx3Data.mat')
img2 = imread('./assignment2data/cube2.jpg');

x2 = x{2};
x2_mean = mean(x2.');
x2_std = std(x2.');
N = [1/x2_std(1) 0 -x2_mean(1)/x2_std(1)
     0 1/x2_std(2) -x2_mean(2)/x2_std(2)
     0 0 1];

x2_normalized = N*x2; 

figure
axis equal
title('Normalized x-y for x{2}')
hold on
x2_normalized_euclidian = pflat(x2_normalized);
scatter(x2_normalized_euclidian(1,:), x2_normalized_euclidian(2,:))


% Solve the ||Mv|| problem
X = [Xmodel;ones(1, 37)];
n_points = size(X,2);
n_rows = 3*size(X,2);
n_cols = size(X,1)*3 + size(X,2);
M = zeros(n_rows, n_cols);
for i=1:n_points
    % Add X
    start_row_X = (i-1)*3 + 1;
    for j=0:2
        start_col_X = j*size(X,1) + 1;
        end_col_X = j*size(X,1) + size(X,1);
        M(start_row_X+j, start_col_X:end_col_X) = X(:,i).';
    end
    
    % Add x
    start_row_x = start_row_X;
    end_row_x = start_row_x + 2;
    col_x = i + 12;
    M(start_row_x:end_row_x, col_x) = -x2_normalized(:,i); 
end

[U,S,V] = svd(M);
v = V(:,end);

% What is smallest singular value?
Mv = norm(M*v);

% Extract P from v
P = -[v(1:4).'
     v(5:8).'
     v(9:12).'];

% Unnormalize the camera.
P_unnormalized2 = N^-1*P;

% Move the 3D points into 2D and compare them to the measured points
xmodel = P_unnormalized2*X;
xmodel_euclidian = pflat(xmodel);
figure
hold on
axis equal
axis ij
title('PX and measured x')
imagesc(img2)
scatter(xmodel_euclidian(1,:), xmodel_euclidian(2,:), '*')
scatter(x2(1,:), x2(2,:))
legend('PX', 'x_{measured}')

% Plot the camera and the model points Why doesnt the camera show up?
figure
axis equal
title('The camera and Xmodel')
hold on
plot3(Xmodel(1,:) , Xmodel(2,:), Xmodel(3,:), '.')
plotcams({P_unnormalized2}) 

K2 = rq(P_unnormalized2);
K2 = K2/K2(end,end);


P2 = P_unnormalized2;
save('P2.mat', 'P2')






