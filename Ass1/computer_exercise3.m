clc; clear all; close all
load('./assignment1data/compEx3.mat')

plot([startpoints(1,:); endpoints(1,:)], [startpoints(2,:); endpoints(2,:)] ,'b-');

H1 = [sqrt(3) -1 1
      1 sqrt(3) 1
      1/4 1/2 2];
H2 = [1 -1 1
      1 1 0
      0 0 1];
H3 = [1 1 0
      0 2 0
      0 0 1];
H4 = [sqrt(3) -1 1
      1 sqrt(3) 1
      0 0 2];
  
% Convert the euclidian points to homogenous
startpoints = [startpoints; ones(1,42)];
endpoints = [endpoints; ones(1,42)];


figure
startpoints1 = pflat(H1*startpoints);
endpoints1 = pflat(H1*endpoints);
plot([startpoints1(1,:); endpoints1(1,:)], [startpoints1(2,:); endpoints1(2,:)] ,'b-');
axis equal
title('H1')

figure
startpoints2 = pflat(H2*startpoints);
endpoints2 = pflat(H2*endpoints);
plot([startpoints2(1,:); endpoints2(1,:)], [startpoints2(2,:); endpoints2(2,:)] ,'b-');
axis equal
title('H2')

figure
startpoints3 = pflat(H3*startpoints);
endpoints3 = pflat(H3*endpoints);
plot([startpoints3(1,:); endpoints3(1,:)], [startpoints3(2,:); endpoints3(2,:)] ,'b-');
axis equal
title('H3')

figure
startpoints4 = pflat(H4*startpoints);
endpoints4 = pflat(H4*endpoints);
plot([startpoints4(1,:); endpoints4(1,:)], [startpoints4(2,:); endpoints4(2,:)] ,'b-');
axis equal
title('H4')