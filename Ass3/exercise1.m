clc; clear all; close all;


P1 = [eye(3) zeros(3,1)];
P2 = [1 1 0 0
      0 2 0 2
      0 0 1 0];
t = P2(:,end);
A = P2(:,1:3);

e2 = t;

% Calculate F
e2x = [0 -e2(3) e2(2) ; e2(3) 0 -e2(1) ; -e2(2) e2(1) 0 ];
F = e2x*A;

% Calculate epipolar line
x = [0;1;1];

l = cross(t, A*x);
l = l/l(end);


% Which points
x1 = [1;0;1];
x2 = [0;1;1];
x3 = [1;1;1];

x1_on_l = l.'*x1 == 0 
x2_on_l = l.'*x2 == 0 
x3_on_l = l.'*x3 == 0 










