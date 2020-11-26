clc; clear all; close all;


P1 = [eye(3) zeros(3,1)];
P2 = [1 1 1 2
      0 2 0 2
      0 0 1 0];
  
% Calculate epipoles
e1 = P1*null(P2) 
e2 = P2*null(P1) 
  

% Calculate F
e2x = skew(e2);
A = P2(:,1:3);
F = e2x*A

% Verify
e2.'*F
F*e1