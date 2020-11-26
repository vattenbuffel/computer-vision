clc; clear all; close all

syms A [3, 3]
syms t [3,1]

P1 = [eye(3) zeros(3,1)];
P2 = [A t];

C1 = null(P1);
C2 = null(P2);

e1 = P1*C2;
e2 = P2*C1;

F = skew(t)*A;

simplify(e2.'*F)

simplify(F*e1)






















