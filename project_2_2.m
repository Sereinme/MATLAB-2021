clear;close all;clc;
load('data/hall.mat');

hall_select = double(hall_gray(1:8, 1:8));
hall_select = hall_select - 128;
hall_my_dct = dim2dct(hall_select);
hall_matlab_dct = dct2(hall_select);
max_diff = max(max(abs(hall_my_dct - hall_matlab_dct)));
disp(max_diff);
