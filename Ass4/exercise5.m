clc; clear all; close all;

syms x y

mx1 = [x x^2 x*y x*y^2].'
mx2 = [x -2*y^2+6 2 2*y].'

M_transpose = [0 1 0 0
               6 0 0 -2
               2 0 0 0
               0 0 2 0];
M = M_transpose.';
[V,D] = eig(M.');
V = V ./ V(1,:)


