clear;close all;clc;
load('data/hall.mat');
load('data/JpegCoeff.mat');

hall_select = double(hall_gray);
hall_fit = fit8(hall_select);
hall_minus = hall_fit - 128;
[h, w] = size(hall_fit);
column = h * w / 64;
hall_done = zeros(64, column);
index = 1;

for a = 1:h / 8

    for b = 1:w / 8
        unit_dct = dim2dct(hall_minus(8 * (a - 1) + 1:8 * a, 8 * (b - 1) + 1:8 * b));
        unit_dct = round(unit_dct ./ QTAB);
        vector = zigzagscan(unit_dct);
        hall_done(:, index) = vector';
        index = index + 1;
    end

end
