clc; clear all; close all
L1 = [1 -1 1].';
L2 = [3 2 1].';

y1 = @(x) (-L1(1)*x-L1(3))/L1(2);
y2 = @(x) (-L2(1)*x-L2(3))/L2(2);
t = -1:0.00001:0;

plot(t,y1(t))
hold on
plot(t,y2(t))