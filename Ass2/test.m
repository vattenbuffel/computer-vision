clc; clear all; close all

polyeig([1 2 3;
         5 6 7;
         8 9 10])
     
%%
clc; clear all; close all

D1 = [[-5.35641775e+04 -4.57416227e+04 -3.45991425e+02  1.49263119e+04...
   1.27464615e+04  9.64147339e+01  1.54813599e+02  1.32204498e+02...
   1.00000000e+00]
 [-4.61066246e+04  3.96620926e+03 -2.16433319e+02 -5.93787789e+03...
   5.10791378e+02 -2.78735352e+01  2.13029236e+02 -1.83253174e+01...
   1.00000000e+00]
 [-4.60055527e+04  7.37319748e+03 -2.15548370e+02 -9.11495756e+03...
   1.46083197e+03 -4.27060242e+01  2.13434937e+02 -3.42066956e+01...
   1.00000000e+00]
 [-4.59611481e+04  8.83785438e+03 -2.14400909e+02 -1.05962348e+04...
   2.03754659e+03 -4.94296265e+01  2.14370117e+02 -4.12211609e+01...
   1.00000000e+00]
 [-4.60915907e+04  6.19554050e+03 -2.14055603e+02 -8.15044571e+03...
   1.09556680e+03 -3.78517761e+01  2.15325317e+02 -2.89436035e+01...
   1.00000000e+00]
 [-4.61633361e+04  4.65432460e+03 -2.14141266e+02 -6.68556388e+03...
   6.74058399e+02 -3.10128174e+01  2.15574219e+02 -2.17348328e+01...
   1.00000000e+00]
 [-4.61999892e+04  5.27485034e+03 -2.11468475e+02 -7.47130619e+03...
   8.53030979e+02 -3.41979675e+01  2.18472229e+02 -2.49439087e+01...
   1.00000000e+00]
 [-4.62073638e+04  3.89658657e+03 -2.11074768e+02 -6.11605561e+03...
   5.15756325e+02 -2.79380798e+01  2.18914673e+02 -1.84606934e+01...
   1.00000000e+00]
 [-4.61131746e+04  7.60359636e+03 -2.09491425e+02 -9.81790106e+03...
   1.61887264e+03 -4.46025696e+01  2.20119629e+02 -3.62955017e+01...
   1.00000000e+00]
 [-4.62430657e+04  4.54353654e+03 -2.08281311e+02 -6.92691780e+03...
   6.80592943e+02 -3.11992188e+01  2.22022156e+02 -2.18144226e+01...
   1.00000000e+00]
 [-4.61600732e+04  6.78282457e+03 -2.04764893e+02 -9.46379962e+03...
   1.39062372e+03 -4.19811707e+01  2.25429626e+02 -3.31249390e+01...
   1.00000000e+00]
 [-4.60878134e+04  8.12964777e+03 -2.02552277e+02 -1.10953852e+04...
   1.95716757e+03 -4.87633362e+01  2.27535400e+02 -4.01360474e+01...
   1.00000000e+00]
 [-4.61958493e+04  6.62509683e+03 -2.01594971e+02 -9.55110805e+03...
   1.36975544e+03 -4.16802673e+01  2.29151794e+02 -3.28634033e+01...
   1.00000000e+00]
 [-4.62171363e+04  3.93031233e+03 -1.98358887e+02 -6.84048493e+03...
   5.81715883e+02 -2.93586121e+01  2.32997559e+02 -1.98141479e+01...
   1.00000000e+00]];

D2 =[[ 0.00000000e+00  0.00000000e+00 -5.94313348e+11  0.00000000e+00...
   0.00000000e+00  1.65612669e+11  2.57648743e+12  2.20021517e+12...
   1.83602249e+10]
 [ 0.00000000e+00  0.00000000e+00 -4.52360573e+11  0.00000000e+00...
   0.00000000e+00 -5.82576121e+10  4.83085217e+11 -4.15562206e+10...
   4.35776347e+09]
 [ 0.00000000e+00  0.00000000e+00 -4.70582067e+11  0.00000000e+00...
   0.00000000e+00 -9.32351708e+10  4.97609041e+11 -7.97505846e+10...
   4.51461745e+09]
 [ 0.00000000e+00  0.00000000e+00 -4.86878330e+11  0.00000000e+00...
   0.00000000e+00 -1.12248656e+11  5.02403936e+11 -9.66070913e+10...
   4.61450670e+09]
 [ 0.00000000e+00  0.00000000e+00 -4.76936690e+11  0.00000000e+00...
   0.00000000e+00 -8.43374364e+10  4.80779284e+11 -6.46254010e+10...
   4.46090145e+09]
 [ 0.00000000e+00  0.00000000e+00 -4.71924491e+11  0.00000000e+00...
   0.00000000e+00 -6.83460425e+10  4.72528129e+11 -4.76416889e+10...
   4.39575088e+09]
 [ 0.00000000e+00  0.00000000e+00 -4.94401921e+11  0.00000000e+00...
   0.00000000e+00 -7.99530087e+10  4.60047201e+11 -5.25255564e+10...
   4.44369303e+09]
 [ 0.00000000e+00  0.00000000e+00 -4.91689241e+11  0.00000000e+00...
   0.00000000e+00 -6.50805086e+10  4.49889227e+11 -3.79383755e+10...
   4.38454473e+09]
 [ 0.00000000e+00  0.00000000e+00 -5.18921643e+11  0.00000000e+00...
   0.00000000e+00 -1.10482989e+11  4.63266327e+11 -7.63879344e+10...
   4.58166595e+09]
 [ 0.00000000e+00  0.00000000e+00 -5.15917744e+11  0.00000000e+00...
   0.00000000e+00 -7.72812044e+10  4.36788915e+11 -4.29159781e+10...
   4.44434500e+09]
 [ 0.00000000e+00  0.00000000e+00 -5.51892170e+11  0.00000000e+00...
   0.00000000e+00 -1.13149667e+11  4.30324973e+11 -6.32325426e+10...
   4.60415848e+09]
 [ 0.00000000e+00  0.00000000e+00 -5.77227913e+11  0.00000000e+00...
   0.00000000e+00 -1.38964416e+11  4.28681018e+11 -7.56170759e+10...
   4.73379153e+09]
 [ 0.00000000e+00  0.00000000e+00 -5.78970042e+11  0.00000000e+00...
   0.00000000e+00 -1.19703513e+11  4.11528202e+11 -5.90185965e+10...
   4.66782283e+09]
 [ 0.00000000e+00  0.00000000e+00 -5.93083750e+11  0.00000000e+00...
   0.00000000e+00 -8.77808705e+10  3.76686552e+11 -3.20334819e+10...
   4.60665043e+09]];
% 
D3 = [[0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00...
  0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00...
  2.85870323e+19]
 [0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00...
  0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00...
  4.73963791e+18]
 [0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00...
  0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00...
  5.08994843e+18]
 [0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00...
  0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00...
  5.32209485e+18]
 [0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00...
  0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00...
  4.97490490e+18]
 [0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00...
  0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00...
  4.83062135e+18]
 [0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00...
  0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00...
  4.92312280e+18]
 [0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00...
  0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00...
  4.78723896e+18]
 [0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00...
  0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00...
  5.21323733e+18]
 [0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00...
  0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00...
  4.87310148e+18]
 [0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00...
  0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00...
  5.14498714e+18]
 [0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00...
  0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00...
  5.36902559e+18]
 [0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00...
  0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00...
  5.15766035e+18]
 [0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00...
  0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00...
  4.83384932e+18]];
% 
[V, eig_vals_inverse] = polyeig(D1.'*D3, D1.'*D2, D1.'*D1);
eig_vals = eig_vals_inverse.^-1

%%
clc;

A = D1.'*D1;
B = D1.'*D2;
C = D1.'*D3;

side_with_lambda = [B A; eye(9) zeros(9)];
side_without_lambda = [-C zeros(9); zeros(9) eye(9)];

[V,D] = eig(side_without_lambda, side_with_lambda);

eig_vals_inv = diag(D);
eig_vals = eig_vals_inv.^-1






