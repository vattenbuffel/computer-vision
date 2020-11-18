clc; clear all; close all
syms a b c d e f g

a = [a b c
     a b c
     a b c];
b = [e;f;g];

balle = (a*b).'
balle1 = b.'*a.'

all((balle == balle1))