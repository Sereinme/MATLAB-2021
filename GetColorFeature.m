function color_vector = GetColorFeature(image, L)
    %GetColorFeature: find the color frequency in the image
    %image: produced image
    %L: the degree of select color numbers
    %color_vector: output of color feature
    N = 2^(3 * L);
    color_vector = zeros(N, 1);
    image_double = double(image);
    image_judge = bitshift(image_double, -(8 - L));
    color_list = bitshift(image_judge(:, :, 1), 2 * L) + bitshift(image_judge(:, :, 2), L) + image_judge(:, :, 3);

    for n = 1:N
        color_vector(n) = length(find(color_list == n - 1));
    end

    color_vector = color_vector / (numel(image) / 3);
end
