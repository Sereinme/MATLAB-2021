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

% Normal DCT
hall_normal_dct = zeros(h, w);

for a = 1:h / 8

    for b = 1:w / 8
        unit_dct = dim2dct(hall_minus(8 * (a - 1) + 1:8 * a, 8 * (b - 1) + 1:8 * b));
        hall_normal_dct(8 * (a - 1) + 1:8 * a, 8 * (b - 1) + 1:8 * b) = dim2idct(unit_dct);
    end

end

hall_normal_dct = hall_normal_dct + 128;
subplot(2, 2, 2);
imshow(uint8(hall_normal_dct));
imwrite(uint8(hall_normal_dct), 'images/project_2_3_normal_dct.jpg');

% Right 0
hall_right0 = zeros(h, w);

for a = 1:h / 8

    for b = 1:w / 8
        unit_dct = dim2dct(hall_minus(8 * (a - 1) + 1:8 * a, 8 * (b - 1) + 1:8 * b));
        unit_dct(:, end - 3:end) = 0;
        hall_right0(8 * (a - 1) + 1:8 * a, 8 * (b - 1) + 1:8 * b) = dim2idct(unit_dct);
    end

end

hall_right0 = hall_right0 + 128;
subplot(2, 2, 3);
imshow(uint8(hall_right0));
imwrite(uint8(hall_right0), 'images/project_2_3_right0.jpg');

% Left 0
hall_left0 = zeros(h, w);

for a = 1:h / 8

    for b = 1:w / 8
        unit_dct = dim2dct(hall_minus(8 * (a - 1) + 1:8 * a, 8 * (b - 1) + 1:8 * b));
        unit_dct(:, 1:4) = 0;
        hall_left0(8 * (a - 1) + 1:8 * a, 8 * (b - 1) + 1:8 * b) = dim2idct(unit_dct);
    end

end

hall_left0 = hall_left0 + 128;
subplot(2, 2, 4);
imshow(uint8(hall_left0));
imwrite(uint8(hall_left0), 'images/project_2_3_left0.jpg');
