function ac_coeff = AC_Decode(AC, ACTAB, coeff_length)
    %AC_Decode: decoding AC string
    %ACTAB: AC coefficients
    %coeff_length: length of original ac coefficient
    %ac_coeff: output of original ac_coeff
    ZRL = [1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1];
    EOB = [1, 0, 1, 0];

    ac_string = split(AC, '');
    ac_list = str2double(ac_string(2:end - 1))';
    ac_coeff = zeros(63, coeff_length);

    n = 1;
    index = 0;

    while n <= coeff_length

        if all(ac_list(1:4) == EOB)
            n = n + 1;
            index = 0;
            ac_list(1:4) = [];
        elseif all(ac_list(1:11) == ZRL) && length(ac_list) > 11
            index = index + 16;
            ac_list(1:11) = [];
        else

            for i = 1:size(ACTAB, 1)
                L = ACTAB(i, 3);

                if L > length(ac_list)
                    continue;
                end

                if all(ac_list(1:L) == ACTAB(i, 4:L + 3))
                    ac_run = ACTAB(i, 1);
                    ac_size = ACTAB(i, 2);
                    ac_list(1:L) = [];
                    break;
                end

            end

            index = index + ac_run + 1;
            amplitude = ac_list(1:ac_size);

            if amplitude(1) == 1
                ac_coeff(index, n) = bin2dec(num2str(amplitude, '%d'));
            else
                ac_coeff(index, n) = -bin2dec(num2str(~amplitude, '%d'));
            end

            ac_list(1:ac_size) = [];
        end

    end

end
