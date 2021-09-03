clear;close all;clc;
load('data/hall.mat');
load('data/JpegCoeff.mat');

[DC, AC, height, width] = JpegEncode(hall_gray, QTAB ./ 2, DCTAB, ACTAB);
image = JpegDecode(DC, AC, height, width, QTAB ./ 2, DCTAB, ACTAB);
imwrite(image, 'images/2_12_2QTAB.jpg');
subplot(1, 2, 1);
imshow(hall_gray);
title('Original');
subplot(1, 2, 2);
imshow(image);
title('Encoding and Decoding with half QTAB');

fprintf("DC length: %d\n", length(DC));
fprintf("AC length: %d\n", length(AC));
fprintf("Height: %d\n", height);
fprintf("Width: %d\n", width);
Compression_ratio = height*width*8/(length(AC)+length(DC));
fprintf("Compression ratio: %5.4f\n", Compression_ratio);
psnr = 10 * log10(255^2 / mse(image, hall_gray));
fprintf("PSNR = %6.4fdB\n", psnr);
