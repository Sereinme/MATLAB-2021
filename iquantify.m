function image = iquantify(image_quantified, height, width, QTAB)
    %iquantify: inverse of quantification
    %image_quantified: image after quantification
    %QTAB: quantify coefficients
    %image: output image
    a = ceil(height / 8);
    b = ceil(width / 8);
    img = zeros(8 * a, 8 * b);

    for n = 1:length(image_quantified)
        y = floor((n - 1) / b) + 1;
        x = mod(n - 1, b) + 1;
        unit = izigzagscan(image_quantified(:, n)');
        unit = unit .* QTAB;
        unit = idct2(unit);
        img(8 * y - 7:8 * y, 8 * x - 7:8 * x) = unit;
    end

    image = img(1:height, 1:width);
end
