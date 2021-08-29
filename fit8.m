function image_done = fit8(image)
    % fit8: fit the length and width to multiples of 8
    image_done = double(image);
    [h, w] = size(image_done);
    h_mod = mod(h, 8);
    w_mod = mod(w, 8);

    if (h_mod ~= 0)
        rows_add = zeros(8 - h_mod, w);
        row = image_done(h, :);

        for n = 1:8 - h_mod
            rows_add(n, :) = row;
        end

        image_done = [image_done; rows_add];
    end

    [h, w] = size(image_done);

    if (w_mod ~= 0)
        col_add = zeros(h, 8 - w_mod);
        col = image_done(:, w);

        for n = 1:8 - w_mod
            col_add(:, n) = col;
        end

        image_done = [image_done col_add];
    end

end
