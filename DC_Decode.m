function dc_coeff = DC_Decode(DC, coeff_length)
    %DC_Decode: decoding DC string
    %coeff_length: length of original dc coefficient
    %dc_coeff: output of original dc_coeff
    dc_string = split(DC, '');
    dc_list = str2double(dc_string(2:end - 1))';
    dc_diff = zeros(1, coeff_length);

    for n = 1:coeff_length

        if (dc_list(1) == 0 && dc_list(2) == 0)
            dc_list(1:3) = [];
        else
            pointer = find(~dc_list, 1); % first 0

            if pointer <= 3
                category = bin2dec(num2str(dc_list(1:3), '%d')) - 1;
                dc_list(1:3) = [];
            else
                category = pointer + 2;
                dc_list(1:pointer) = [];
            end

            magnitude = dc_list(1:category);

            if magnitude(1) == 1
                dc_diff(n) = bin2dec(num2str(magnitude, '%d'));
            else
                dc_diff(n) = -bin2dec(num2str(~magnitude, '%d'));
            end

            dc_list(1:category) = [];
        end

    end

    for i = 2:coeff_length
        dc_diff(i) = dc_diff(i - 1) - dc_diff(i);
    end

    dc_coeff = dc_diff;
end
