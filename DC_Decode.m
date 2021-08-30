function dc_coeff = DC_Decode(DC, DCTAB, coeff_length)
    %DC_Decode: decoding DC string
    %coeff_length: length of original dc coefficient
    %dc_coeff: output of original dc_coeff
    dc_string = split(DC, '');
    dc_list = str2double(dc_string(2:end - 1))';
    dc_diff = zeros(1, coeff_length);

    for n = 1:coeff_length

        for a = 1:size(DCTAB, 1)
            L = DCTAB(a, 1);

            if L > length(dc_list)
                continue;
            end

            if all(dc_list(1:L) == DCTAB(a, 2:L + 1))
                category = a - 1;
                dc_list(1:L) = [];
                break;
            end

        end

        if category == 0
            dc_list(1) = [];
            continue;
        end

        magnitude = dc_list(1:category);

        if magnitude(1) == 1
            dc_diff(n) = bin2dec(num2str(magnitude, '%d'));
        else
            dc_diff(n) = -bin2dec(num2str(~magnitude, '%d'));
        end

        dc_list(1:category) = [];
    end

    for i = 2:coeff_length
        dc_diff(i) = dc_diff(i - 1) - dc_diff(i);
    end

    dc_coeff = dc_diff;

end
