function AC = AC_Huffman(ac_coeff, ACTAB)
    %AC_Huffman: AC Huffman encoding
    %ac_coeff: AC coefficient
    %ACTAB: AC encoding table
    %AC: output of encoding
    ZRL = [1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1];
    EOB = [1, 0, 1, 0];
    AC_list = [];

    for n = 1:size(ac_coeff, 2)
        ac = ac_coeff(:, n).';
        not_0 = find(ac);

        if isempty(not_0)
            AC_list = [AC_list, EOB];
            continue;
        end

        % get AC run
        ac_run = [not_0(1), diff(not_0)] - 1;

        for i = 1:length(ac_run)

            while (ac_run(i) >= 16)
                AC_list = [AC_list, ZRL];
                ac_run(i) = ac_run(i) - 16;
            end

            % find AC size
            Amp_coeff = ac(not_0(i));
            ac_size = ceil(log2(abs(Amp_coeff) + 1));

            % find Huffman code use ACTAB
            category = find(ACTAB(:, 1) == ac_run(i) & ACTAB(:, 2) == ac_size);
            ac_huff = ACTAB(category, 4:(3 + ACTAB(category, 3)));

            % Amplitude coding
            if (Amp_coeff >= 0)
                bin = split(dec2bin(Amp_coeff), '');
                Amplitude = str2double(bin(2:end - 1)).';
            else
                bin = split(dec2bin(-Amp_coeff), '');
                Amplitude = ~str2double(bin(2:end - 1)).';
            end

            AC_list = [AC_list, ac_huff, Amplitude];
        end

        AC_list = [AC_list, EOB];
    end

    AC = num2str(AC_list, '%d');
end
