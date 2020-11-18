clc; clear all; close all

syms f x0 y0

K = [f 0 x0
     0 f y0
     0 0 1];
 
K^-1

A = [1/f  0 0
     0 1/f 0
     0 0 1];
 
 B = [1 0 -x0
      0 1 -y0
      0 0 1];
assert(all(all(K^-1==A*B)))
disp("K^-1 == A*B")

K = [320 0 320
     0 320 240
     0 0 1];

p1 = [0;240;1];
p2 = [640;240;1];
p1_normalized = K^-1*p1
p2_normalized = K^-1*p2

% Camera center och axis
syms tx ty
syms R [3 3]
K = [f 0 x0
     0 f y0
     0 0 1];
 
t = [tx; ty; 0];
P1 = K*[R t];
camera_center1 = simplify(null(P1))
principal_axis1 = P1(end, 1:3)
P2 = [R t];
camera_center2 = simplify(null(P2))
principal_axis2 = P2(end, 1:3)
