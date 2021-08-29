clear;close all;clc;
Perror = input('');
Category = ceil(log2(abs(Perror)+1));
disp(Category);