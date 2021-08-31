clear;close all;clc;
load('data/hall.mat');
load('data/JpegCoeff.mat');

hall_double = double(hall_gray);
[height, width] = size(hall_double);
max_length = height * width;

% create hide information
info_length = randi(max_length);
info_hide = randi([0, 1], 1, info_length);
info_fill = [info_hide, zeros(1, max_length - info_length)];
info_bin = dec2bin(info_fill);

% hide information
hall_bin = dec2bin(hall_double);
hall_bin(:, end) = info_bin;
hall_hide = reshape(bin2dec(hall_bin), height, width);

% extract information
fill_extract = dec2bin(hall_hide);
info_extract = bin2dec(fill_extract(1:info_length, end))';
correct = length(find(info_extract == info_hide));
correct_rate = correct / info_length;
fprintf("Direct correct rate = %f\n", correct_rate);

% encode and decode
[DC, AC, h, w] = JpegEncode(hall_hide, QTAB, DCTAB, ACTAB);
hall_code = JpegDecode(DC, AC, h, w, QTAB, DCTAB, ACTAB);

% extract and correct after code
fill_extract_code = dec2bin(hall_code);
info_extract_code = bin2dec(fill_extract_code(1:info_length, end))';
correct_code = length(find(info_extract_code == info_hide));
correct_rate_code = correct_code / info_length;
fprintf("Correct rate after code = %f\n", correct_rate_code);

% plot
imwrite(uint8(hall_hide), 'images/project_3_1_hall_hide.jpg');
imwrite(uint8(hall_code), 'images/project_3_1_hall_code.jpg');
subplot(1, 3, 1);
imshow(hall_gray);
title('Original');
subplot(1, 3, 2);
imshow(uint8(hall_hide));
title('Hide');
subplot(1, 3, 3);
imshow(uint8(hall_code));
title('Hide After Code');
