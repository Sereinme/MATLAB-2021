function face_vector = FaceStandard(face_folder, L)
    %FaceStandard: train face color data and get face template
    %face_folder: folder of face images
    %L: color standard
    %face_vector: output of face template
    face_template = zeros(2^(3 * L), 1);
    face_list = dir(face_folder);

    for n = 3:length(face_list)
        image = imread([face_folder, face_list(n).name]);
        face_template = face_template + GetColorFeature(image, L);
    end

    face_vector = face_template / (length(face_list) - 2);
end
