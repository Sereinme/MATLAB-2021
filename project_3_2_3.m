clear;close all;clc;
load('data/hall.mat');
load('data/JpegCoeff.mat');

hall_double = double(hall_gray);
[height, width] = size(hall_double);
hall_double = fit8(hall_double);
[h, w] = size(hall_double);
max_length = h * w / 64;
hall_double = hall_double - 128;

% create hide information
info_length = randi(max_length);
info_hide = randi([0, 1], 1, info_length);
info_hide_standard = 2 * info_hide - 1;

% quantify
hall_quantified = quantify(hall_double, QTAB);
coeff_length = size(hall_quantified, 2);

% hide information
quant_hide = hall_quantified;

for n = 1:info_length
    coeff = quant_hide(:, n);
    index = find(coeff);

    if isempty(index)
        quant_hide(1, n) = info_hide_standard(n);
    elseif index(end) == 64
        quant_hide(64) = info_hide_standard(n);
    else
        quant_hide(index(end) + 1, n) = info_hide_standard(n);
    end

end

% encode
dc_coeff_encode = quant_hide(1, :);
ac_coeff_encode = quant_hide(2:end, :);
dc_diff_encode = [dc_coeff_encode(1), -diff(dc_coeff_encode)];
DC = DC_Huffman(dc_diff_encode, DCTAB);
AC = AC_Huffman(ac_coeff_encode, ACTAB);

% decode
dc_coeff_decode = DC_Decode(DC, DCTAB, coeff_length);
ac_coeff_decode = AC_Decode(AC, ACTAB, coeff_length);
quant_decode = zeros(64, coeff_length);
quant_decode(1, :) = dc_coeff_decode;
quant_decode(2:end, :) = ac_coeff_decode;

% extract
info_extract = zeros(1, info_length);

for m = 1:info_length
    coeff_de = quant_decode(:, m);
    index_de = find(coeff_de);
    info_extract(m) = quant_decode(index_de(end), m);
end

info_extract = (info_extract + 1) / 2;

% iquantify
image = iquantify(quant_decode, height, width, QTAB);
image = uint8(image + 128);

% parameter
fprintf("DC length: %d\n", length(DC));
fprintf("AC length: %d\n", length(AC));
fprintf("Height: %d\n", height);
fprintf("Width: %d\n", width);
Compression_ratio = height * width * 8 / (length(AC) + length(DC));
fprintf("Compression ratio = %5.4f\n", Compression_ratio);
psnr = 10 * log10(255^2 / mse(image, hall_gray));
fprintf("PSNR = %6.4fdB\n", psnr);
correct = length(find(info_extract == info_hide));
correct_rate = correct / info_length;
fprintf("Correct rate = %f\n", correct_rate);

% plot
imwrite(image, 'images/3_2_3.jpg');
subplot(1, 2, 1);
imshow(hall_gray);
title('Original');
subplot(1, 2, 2);
imshow(image);
title('Hide 3');
