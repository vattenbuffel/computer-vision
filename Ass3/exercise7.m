clc; clear all; close all

P1 = [eye(3) zeros(3,1)];

U = [1 -1 0
     1 1 0
     0 0 sqrt(2)]./sqrt(2);
V = [1 0 0
     0 0 -1
     0 1 0];

 
E = U*diag([1 1 0])*V.';

% Make sure det(UV.') = 1
assert(abs(det(U*V.') -1) < 10^-10)


% Make sure x1 and x2 and correspondences
x1 = [1 1 1].';
x2 = [0 0 1].';

assert(abs(x2.'*E*x1) < 10^-10)

% Calculate P2
W = [0 -1 0
     1 0 0
     0 0 1];
u3 = U(:,3);

P21 = [U*W*V.' u3];
P22 = [U*W*V.' -u3];
P23 = [U*W.'*V.' u3];
P24 = [U*W.'*V.' -u3];

syms s 
Xs = [0 0 1 s].';

ans21 = P21*Xs;
cc21 = null(P21);
pa21 = det(P21(:,1:3))*P21(3,1:3);

ans22 = P22*Xs;
cc22 = null(P22);
pa22 = det(P22(:,1:3))*P22(3,1:3);

ans23 = P23*Xs;
cc23 = null(P23);
pa23 = det(P23(:,1:3))*P23(3,1:3);

ans24 = P24*Xs;
cc24 = null(P24);
pa24 = det(P24(:,1:3))*P24(3,1:3);




















