clear;close all;clc;
load('data/hall.mat')
hall_select = double(hall_gray(1:8, 1:8));

% Direct
figure(1);
hold on;
set (gca, 'position', [0.1, 0.1, 0.9, 0.9]);
hall_direct = hall_select - 128;
hall_direct_dct2 = dct2(hall_direct);
imshow(hall_direct_dct2);
imwrite(hall_direct_dct2, 'images/2_1_hall_direct.jpg');

% Transformation
figure(2);
hold on;
set (gca, 'position', [0.1, 0.1, 0.9, 0.9]);
hall_trans = dct2(hall_select);
hall_trans(1, 1) = hall_trans(1, 1) - 128 * size(hall_select, 2);
imshow(hall_trans);
imwrite(hall_trans, 'images/2_1_hall_trans.jpg')

% Difference
max_diff = max(max(abs(hall_direct_dct2 - hall_trans)));
disp(max_diff);
