function P = dim2idct(C)
    % dim2idct: my dct inverse function
    % P is the matrix ready to be transformed, C is the transformed matrix
    C_r = double(C);

    if (size(C_r, 1) ~= size(C_r, 2))
        P = 0;
    else
        N = size(C_r, 1);
        D = cos((1:2:(2 * N - 1)) .* (0:1:(N - 1))' * pi / (2 * N));
        D(1, :) = sqrt(0.5);
        D = sqrt(2 / N) * D;
        P = D' * C_r * D;
    end

end
