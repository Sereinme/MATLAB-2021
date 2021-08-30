function DC = DC_Huffman(dc_diff, DCTAB)
    %DC_Huffman: DC Huffman encoding
    %dc_diff: difference coding of DC coefficient
    %DCTAB: DC encoding table
    %DC: output of encoding
    category = ceil(log2(abs(dc_diff) + 1));
    DC_list = [];

    for n = 1:length(dc_diff)
        category_code = DCTAB(category(n) + 1, 2:(DCTAB(category(n) + 1, 1) + 1));

        if (dc_diff(n) >= 0)
            bin = split(dec2bin(dc_diff(n)), '');
            magnitude = str2double(bin(2:end - 1)).';
        else
            bin = split(dec2bin(-dc_diff(n)), '');
            magnitude = ~str2double(bin(2:end - 1)).';
        end

        DC_list = [DC_list, category_code, magnitude];
    end

    DC = num2str(DC_list, '%d');
end
