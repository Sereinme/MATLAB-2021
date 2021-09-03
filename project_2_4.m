clear;close all;clc;
load('data/hall.mat');

hall_select = double(hall_gray);
hall_fit = fit8(hall_select);
hall_minus = hall_fit - 128;
[h, w] = size(hall_fit);
figure;

% Original
subplot(2, 2, 1);
imshow(uint8(hall_minus + 128));

% Transpose
hall_transpose = zeros(h, w);

for a = 1:h / 8

    for b = 1:w / 8
        unit_dct = dim2dct(hall_minus(8 * (a - 1) + 1:8 * a, 8 * (b - 1) + 1:8 * b));
        unit_dct = unit_dct';
        hall_transpose(8 * (a - 1) + 1:8 * a, 8 * (b - 1) + 1:8 * b) = dim2idct(unit_dct);
    end

end

hall_transpose = hall_transpose + 128;
subplot(2, 2, 2);
imshow(uint8(hall_transpose));
imwrite(uint8(hall_transpose), 'images/2_4_transpose.jpg');

% Rotate 90
hall_rot90 = zeros(h, w);

for a = 1:h / 8

    for b = 1:w / 8
        unit_dct = dim2dct(hall_minus(8 * (a - 1) + 1:8 * a, 8 * (b - 1) + 1:8 * b));
        unit_dct = rot90(unit_dct);
        hall_rot90(8 * (a - 1) + 1:8 * a, 8 * (b - 1) + 1:8 * b) = dim2idct(unit_dct);
    end

end

hall_rot90 = hall_rot90 + 128;
subplot(2, 2, 3);
imshow(uint8(hall_rot90));
imwrite(uint8(hall_rot90), 'images/2_4_rot90.jpg');

% Rotate 180
hall_rot180 = zeros(h, w);

for a = 1:h / 8

    for b = 1:w / 8
        unit_dct = dim2dct(hall_minus(8 * (a - 1) + 1:8 * a, 8 * (b - 1) + 1:8 * b));
        unit_dct = rot90(rot90(unit_dct));
        hall_rot180(8 * (a - 1) + 1:8 * a, 8 * (b - 1) + 1:8 * b) = dim2idct(unit_dct);
    end

end

hall_rot180 = hall_rot180 + 128;
subplot(2, 2, 4);
imshow(uint8(hall_rot180));
imwrite(uint8(hall_rot180), 'images/2_4_rot180.jpg');
