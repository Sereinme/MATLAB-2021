clear;close all;clc;
load('data/hall.mat');
load('data/JpegCoeff.mat');
load('data/jpegcodes');

image = JpegDecode(DC, AC, height, width, QTAB, ACTAB);
imwrite(image, 'images/project_2_11_jpegdecode.jpg');
subplot(1, 2, 1);
imshow(hall_gray);
subplot(1, 2, 2);
imshow(image);
