function output = quantify(image, QTAB)
    %quantify: including DCT, quantify, zigzag scan
    % reprocess of image
    [h, w] = size(image);
    column = h * w / 64;
    output = zeros(64, column);
    index = 1;

    for a = 1:h / 8

        for b = 1:w / 8
            unit_dct = dim2dct(image(8 * (a - 1) + 1:8 * a, 8 * (b - 1) + 1:8 * b));
            unit_dct = round(unit_dct ./ QTAB);
            vector = zigzagscan(unit_dct);
            output(:, index) = vector';
            index = index + 1;
        end

    end

end
