clear;close all;clc;
load('data/hall.mat');
figure;

imwrite(hall_color, 'images/1_2_hall_color.jpg');
subplot(2, 2, 1);
imshow(hall_color);
title("Original Image", 'FontSize', 14);

imwrite(hall_gray, 'images/1_2_hall_gray.jpg');
subplot(2, 2, 2);
imshow(hall_gray);
title("Gray Image", 'FontSize', 14);

hall_circle = hall_color;
[l, w, h] = size(hall_circle);
r = min(l / 2, w / 2);
xcenter = (1 + w) / 2;
ycenter = (1 + l) / 2;
[X, Y] = meshgrid(1:w, 1:l);
distance = sqrt((X - xcenter).^2 + (Y - ycenter).^2);
circle_area = (distance <= r);
R = hall_color(:, :, 1);
R(circle_area) = 255;
hall_circle(:, :, 1) = R;
G = hall_color(:, :, 2);
G(circle_area) = 0;
hall_circle(:, :, 2) = G;
B = hall_color(:, :, 3);
B(circle_area) = 0;
hall_circle(:, :, 3) = B;
imwrite(hall_circle, 'images/1_2_hall_circle.jpg');
subplot(2, 2, 3);
imshow(hall_circle);
title("Circle Image", 'FontSize', 14);

hall_chess = hall_color;
g = gcd(l, w);
X_seperate = floor((X - 1) ./ g);
Y_seperate = floor((Y - 1) ./ g);
chess_area = (mod(X_seperate + Y_seperate, 2) == 0);
R = hall_color(:, :, 1);
R(chess_area) = 0;
hall_chess(:, :, 1) = R;
G = hall_color(:, :, 2);
G(chess_area) = 0;
hall_chess(:, :, 2) = G;
B = hall_color(:, :, 3);
B(chess_area) = 0;
hall_chess(:, :, 3) = B;
imwrite(hall_chess, 'images/1_2_hall_chess.jpg');
subplot(2, 2, 4);
imshow(hall_chess);
title("Chess Image", 'FontSize', 14);
