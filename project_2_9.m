clear;close all;clc;
load('data/hall.mat');
load('data/JpegCoeff.mat');

[DC, AC, height, width] = JpegEncode(hall_gray, QTAB, DCTAB, ACTAB);
save('data/jpegcodes.mat', 'DC', 'AC', 'height', 'width');

fprintf("DC length: %d\n", length(DC));
fprintf("AC length: %d\n", length(AC));
fprintf("Height: %d\n", height);
fprintf("Width: %d\n", width);
