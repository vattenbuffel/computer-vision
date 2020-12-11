clc; clear all; close all

lambda = 1;
xc = [1;1];

w = 2;
h = 2;

% from x to p
x1 = [0;0];
r = norm(x1-xc);
x1_hat = xc + (1/(1+lambda*r^2))*(x1-xc);

x2 = [2;2];
r = norm(x2-xc);
x2_hat = xc + (1/(1+lambda*r^2))*(x2-xc);

% p to x
syms r
r_hat1 = norm(x1_hat);
r_eq1 = r_hat1 + r_hat1*lambda*r^2 - r;
r1 = double(solve(r_eq1));

% r = 1-sqrt(1-4*lambda*r_hat1);
% r = r/(2*lambda*r_hat1);

x11 = xc + r1(1)*x1_hat/r_hat1
x12 = xc + r1(2)*x1_hat/r_hat1


r_hat2 = norm(x2_hat);
r_eq2 = r_hat2+r_hat2*lambda*r^2 - r;
r2 = double(solve(r_eq2));
x21 = xc + r2(1)*x2_hat/r_hat2
x22 = xc + r2(2)*x2_hat/r_hat2



%%
clc; clear all; close all

lambda = 1;
w = 2;
h = 2;

% from x to p
xc = [1;1];
x1 = ([0;0]-xc)/(w+h);
x2 = ([2;2]-xc)/(w+h);

r1 = norm(x1);
r2 = norm(x2);

p1 = (1/(1+lambda*r1^2))*x1;
p2= (1/(1+lambda*r2^2))*x2;

% p to x
syms r
r_hat1 = norm(p1);
r_eq1 = r_hat1+r_hat1*lambda*r^2 - 1;
r1 = vpa(solve(r_eq1),5);
r1 = r1(1);

r_hat2 = norm(p2);
r_eq2 = r_hat2+r_hat2*lambda*r^2 - 1;
r2 = vpa(solve(r_eq2),5);
r2 = r2(1);

x_hat1 = (r1*p1) * (w+h);
corr_term = -x_hat1;
x_hat1 = x_hat1 + corr_term

x_hat2 = (r2*p2 + corr_term)*(w+h)







%%
clc; clear all; close all;

x_max = 720;
y_max = 1280;

lambda = -2.4076156756677483;
xc = [x_max/2; y_max/2];
xd1 = [x_max/2;0]-xc;
xd2 = [x_max;y_max/2]-xc;
xd3 = [x_max/2;y_max]-xc;
xd4 = [0;y_max/2]-xc;
xd5 = [0;0]-xc;
xd6 = [128;391]-xc;

% xd to xu
fu = @(x) x/(1+lambda*norm(x)^2);

xu1 = fu(xd1);
xu2 = fu(xd2);
xu3 = fu(xd3);
xu4 = fu(xd4);
xu5 = fu(xd5);
xu6 = fu(xd6);


% xu to xd
xd1_hat = calc_xd_hat(xu1, lambda, xc);
xd2_hat = calc_xd_hat(xu2, lambda, xc);
xd3_hat = calc_xd_hat(xu3, lambda, xc);
xd4_hat = calc_xd_hat(xu4, lambda, xc);
xd5_hat = calc_xd_hat(xu5, lambda, xc);
xd6_hat = calc_xd_hat(xu6, lambda, xc);





%%
clc; clear all; close all;

x_max = 20;
y_max = 20;

lambda = -2.4076156756677483;
xc = [x_max/2; y_max/2];

xd = [repmat(linspace(0,x_max-1, x_max), 1,20);
     reshape(repmat(linspace(0,y_max-1, y_max).', 1,20).', [1,400]);];

scatter(xd(1,:), xd(2,:), '*')
hold on 
 
xd = xd - xc;


% xd to xu
xu = xd./(1+lambda*sum(xd.^2));

% xu to xd
xd_hat = [];
for i = 1:x_max*y_max
   xd_hat = [xd_hat calc_xd_hat(xu(:,i), lambda, xc)]; 
end

scatter(xd_hat(1,:), xd_hat(2,:))
legend('xd', 'xd_{hat}')

%%
clc; clear all; close all;

x_max = 20;
y_max = 20;

lambda = -2.4076156756677483;
xc = [x_max/2; y_max/2];

xd_extreme = [0 x_max x_max 0 ;
              0 0 y_max y_max];
          
scatter(xd_extreme(1,:), xd_extreme(2,:), '*')
hold on 
 
xd_extreme = (xd_extreme - xc) / (x_max+y_max);

% xd to xu
xu_extreme = xd_extreme./(1+lambda*sum(xd_extreme.^2));
x_ = xu_extreme(1,1);
y_ = xu_extreme(2,1);

xu = [repmat(linspace(-x_,x_, x_max), 1,20);
     reshape(repmat(linspace(-y_,y_, y_max).', 1,20).', [1,400]);];


% xu to xd
xd_hat = zeros(2, x_max*y_max);
for i = 1:x_max*y_max
   xd_hat(:,i) = calc_xd_hat(xu(:,i), lambda, xc); 
end

xd_hat = xd_hat * (x_max+y_max) + xc;

scatter(xd_hat(1,:), xd_hat(2,:))
legend('xd', 'xd_{hat}')



function xd_hat = calc_xd_hat(xu, lambda, xc)
    syms rd
    ru = norm(xu);
    if (ru == 0)
        rd = 0;
    else
        rd_eq = rd^2 - 1/(lambda*ru)*rd + 1/lambda;
        rd = double(solve(rd_eq == 0));
    end
    
    xd_hat = (rd(2)/ru)*(xu);% + xc;
end




























