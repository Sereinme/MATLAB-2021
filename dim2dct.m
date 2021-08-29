function C = dim2dct(P)
    % dim2dct: my dct function
    % P is the matrix ready to be transformed, C is the transformed matrix
    P_r = double(P);

    if (size(P_r, 1) ~= size(P_r, 2))
        C = 0;
    else
        N = size(P_r, 1);
        D = cos((1:2:(2 * N - 1)) .* (0:1:(N - 1))' * pi / (2 * N));
        D(1, :) = sqrt(0.5);
        D = sqrt(2 / N) * D;
        C = D * P_r * D';
    end

end
