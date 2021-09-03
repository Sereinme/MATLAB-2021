clear;close all;clc;
load('data/hall.mat');
load('data/JpegCoeff.mat');
load('data/jpegcodes');

image = JpegDecode(DC, AC, height, width, QTAB, DCTAB, ACTAB);
imwrite(image, 'images/2_11_jpegdecode.jpg');
subplot(1, 2, 1);
imshow(hall_gray);
title('Original');
subplot(1, 2, 2);
imshow(image);
title('Encoding and Decoding');

psnr = 10 * log10(255^2 / mse(image, hall_gray));
fprintf("PSNR = %6.4fdB\n", psnr);