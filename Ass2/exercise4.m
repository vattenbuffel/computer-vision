clc; close all; clear all

A3 = [-1/sqrt(2) 0 1/sqrt(2)].';
f = norm(A3,2);
R3 = A3 / norm(A3,2);

A2 = [-700/sqrt(2) 1400 700/sqrt(2)].';
e = A2.'*R3;
d = norm(A2-e*R3,2);
R2 = (A2-e*R3) / d;

A1 = [800/sqrt(2) 0 2400/sqrt(2)].';
b = A1.'*R2;
c = A1.'*R3;
a = norm(A1-b*R2-c*R3,2);
R1 = (A1-b*R2-c*R3) / a;

focal_length = d/f
skew = b/d
aspect_ratio = a/d
principal_point = [c e].'