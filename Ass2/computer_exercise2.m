clc; clear all; close all;
%format rat
load('./assignment2data/compEx1Data.mat')

% Extract the original P-matrix
camera_nr = 1;

P_original = P{camera_nr};


% Create the 2 new, projected P matrices
T1 = [1 0 0 0
      0 4 0 0
      0 0 1 0
      1/10 1/10 0 1];
  
T2 =[1 0 0 0
     0 1 0 0
     0 0 1 0
     1/16 1/16 0 1];

P_T1 = P_original*T1^-1;
P_T2 = P_original*T2^-1;


K_original = rq(P_original);
K_original = K_original./K_original(3, 3)
K_T1 = rq(P_T1);
K_T1 = K_T1(1:3, 1:3)./K_T1(3, 3)
K_T2 = rq(P_T2);
K_T2 = K_T2(1:3, 1:3)./K_T2(3, 3)

K_original_T1 = all(all(K_original==K_T1));
K_original_T2 = all(all(K_original==K_T2));
A_same = K_original_T1==K_original_T2;

fprintf("is K_original = K_T1 = K_t2: %d\n", A_same)


