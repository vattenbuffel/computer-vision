clc; clear all; close all;

P1 = [eye(3) zeros(3,1)];
F = [0 1 1
     1 0 0
     0 1 1];

e2 = null(F.');
e2x = skew(e2);


P2 = [e2x*F e2];

x1 = [1 2 3 1].';
x2 = [3 2 1 1].';


x1.'*P2.'*F*P1*x1 
x2.'*P2.'*F*P1*x2

camera_center = null(P2) % it's in infinity?

