function [DC, AC, height, width] = JpegEncode(image, QTAB, DCTAB, ACTAB)
    %JpegEncode: encoding with jpeg
    %image: encode image(double)
    %QTAB: quantify coefficients
    %DCTAB: DC coefficients
    %ACTAB: AC coefficients
    [height, width] = size(image);

    % Preprocess
    image_fit = fit8(image);
    image_minus = image_fit - 128;
    image_quantified = quantify(image_minus, QTAB);

    % Seperate DC and AC
    dc_coeff = image_quantified(1, :);
    ac_coeff = image_quantified(2:end, :);

    % Differential coding
    dc_diff = [dc_coeff(1), -diff(dc_coeff)];

    % DC encoding
    DC = DC_Huffman(dc_diff, DCTAB);

    % AC encoding
    AC = AC_Huffman(ac_coeff, ACTAB);
end
