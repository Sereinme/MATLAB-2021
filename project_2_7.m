clear;close all;clc;
load('data/hall.mat');
hall_select = double(hall_gray(1:8, 1:8));
hall_select = hall_select - 128;
hall_dct = dim2dct(hall_select);

% 8×8 special
hall_vector8 = reshape(hall_dct, 1, 64);
index = [1, 9, 2, 3, 10, 17, 25, 18, ...
        11, 4, 5, 12, 19, 26, 33, 41, ...
        34, 27, 20, 13, 6, 7, 14, 21, ...
        28, 35, 42, 49, 57, 50, 43, 36, ...
        29, 22, 15, 8, 16, 23, 30, 37, ...
        44, 51, 58, 59, 52, 45, 38, 31, ...
        24, 32, 39, 46, 53, 60, 61, 54, ...
        47, 40, 48, 55, 62, 63, 56, 64];
hall_vector8 = hall_vector8(index);

% Generally
[h, w] = size(hall_dct);
hall_vector = zeros(1, h * w);
row = 1;
col = 1;
pos = 1;
direction = [-1, 1];
% first for row and second for col

while row <= h && col <= w
    hall_vector(pos) = hall_dct(row, col);

    if isequal(direction, [-1, 1]) && row == 1 && col ~= w
        direction = [0, 1];
        col = col + 1;
    elseif isequal(direction, [-1, 1]) && col == w
        direction = [1, 0];
        row = row + 1;
    elseif isequal(direction, [-1, 1]) && col ~= w && row ~= 1
        direction = [-1, 1];
        row = row - 1;
        col = col + 1;
    elseif isequal(direction, [1, -1]) && col == 1 && row ~= h
        direction = [1, 0];
        row = row + 1;
    elseif isequal(direction, [1, -1]) && row == h
        direction = [0, 1];
        col = col + 1;
    elseif isequal(direction, [1, -1]) && row ~= h && col ~= 1
        direction = [1, -1];
        col = col - 1;
        row = row + 1;
    elseif isequal(direction, [1, 0]) && col == 1
        direction = [-1, 1];
        row = row - 1;
        col = col + 1;
    elseif isequal(direction, [1, 0]) && col == w
        direction = [1, -1];
        col = col - 1;
        row = row + 1;
    elseif isequal(direction, [0, 1]) && row == 1
        direction = [1, -1];
        col = col - 1;
        row = row + 1;
    elseif isequal(direction, [0, 1]) && row == h
        direction = [-1, 1];
        row = row - 1;
        col = col + 1;
    end

    pos = pos + 1;
end

disp(isequal(hall_vector8, hall_vector));
