function image = JpegDecode(DC, AC, height, width, QTAB, DCTAB, ACTAB)
    %JpegDecode: decoding with jpeg
    %DC: DC encoding string
    %AC: AC encoding string
    %height: height of original image
    %width: width of original image
    %QTAB: quantify coefficients
    %DCTAB: DC coefficients
    %ACTAB: AC coefficients
    %image: original image

    coeff_length = ceil(height / 8) * ceil(width / 8);
    image_quantified = zeros(64, coeff_length);

    dc_coeff = DC_Decode(DC, DCTAB, coeff_length);

    ac_coeff = AC_Decode(AC, ACTAB, coeff_length);

    image_quantified(1, :) = dc_coeff;
    image_quantified(2:end, :) = ac_coeff;

    image = iquantify(image_quantified, height, width, QTAB);
    image = uint8(image + 128);
end
