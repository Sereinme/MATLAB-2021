clear;close all;clc;
load('data/snow.mat');
load('data/JpegCoeff.mat');

[DC, AC, height, width] = JpegEncode(snow, QTAB ./ 2, DCTAB, ACTAB);
image = JpegDecode(DC, AC, height, width, QTAB ./ 2, DCTAB, ACTAB);
imwrite(snow, 'images/2_13_snow.jpg')
imwrite(image, 'images/2_13_snow_pro.jpg');
subplot(1, 2, 1);
imshow(snow);
title('Original');
subplot(1, 2, 2);
imshow(image);
title('Encoding and Decoding');

fprintf("DC length: %d\n", length(DC));
fprintf("AC length: %d\n", length(AC));
fprintf("Height: %d\n", height);
fprintf("Width: %d\n", width);
Compression_ratio = height * width * 8 / (length(AC) + length(DC));
fprintf("Compression ratio: %5.4f\n", Compression_ratio);
psnr = 10 * log10(255^2 / mse(image, snow));
fprintf("PSNR = %6.4fdB\n", psnr);
