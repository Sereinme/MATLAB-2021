function image_detected = FaceDetect(image, face_folder, L, detect_window, epsilon)
    %FaceDetect: detect faces in image
    %image: detected image
    %detect_window: window size of detection
    %epsilon: threshold of detect
    %image_detected: output image with red window
    face_standard = FaceStandard(face_folder, L);
    window_height = detect_window(1);
    window_width = detect_window(2);
    image_detected = image;
    [height, width, ~] = size(image_detected);
    pointer_matrix = zeros(height, width);

    h_step = floor(window_height / 5);
    w_step = floor(window_width / 5);

    % duplicated range
    h_dup = floor(0.8 * window_height);
    w_dup = floor(0.8 * window_width);

    for w = 1:w_step:width

        if w > width - window_width
            w_pointer = width - window_width + 1;
        else
            w_pointer = w;
        end

        for h = 1:h_step:height

            if h > height - window_height
                h_pointer = height - window_height + 1;
            else
                h_pointer = h;
            end

            color_vector = GetColorFeature(image(h_pointer:h_pointer + window_height - 1, w_pointer:w_pointer + window_width - 1, :), L);
            d = 1 - sum(sqrt(color_vector .* face_standard));

            if d < epsilon

                if h_pointer <= h_dup
                    h_left = 1;
                    center_h = h_pointer;
                else
                    h_left = h_pointer - h_dup;
                    center_h = h_dup + 1;
                end

                if w_pointer <= w_dup
                    w_left = 1;
                    center_w = w_pointer;
                else
                    w_left = w_pointer - w_dup;
                    center_w = w_dup + 1;
                end

                box = pointer_matrix(h_left:h_pointer + h_dup, w_left:w_pointer + w_dup);

                if box == zeros(size(box, 1), size(box, 2))
                    box(center_h, center_w) = d;
                else
                    [r, c] = find(box);

                    for n = 1:length(r)

                        if d < box(r(n), c(n))
                            box(center_h, center_w) = d;
                            box(r(n), c(n)) = 0;
                        else
                            box(center_h, center_w) = 0;
                            break;
                        end

                    end

                end

                pointer_matrix(h_left:h_pointer + h_dup, w_left:w_pointer + w_dup) = box;
            end

        end

    end

    % red window
    [window_r, window_c] = find(pointer_matrix);

    for i = 1:length(window_r)
        pointer_r = window_r(i);
        pointer_c = window_c(i);
        image_detected(pointer_r, pointer_c:pointer_c + window_width - 1, 1) = 255;
        image_detected(pointer_r, pointer_c:pointer_c + window_width - 1, 2) = 0;
        image_detected(pointer_r, pointer_c:pointer_c + window_width - 1, 3) = 0;
        image_detected(pointer_r + window_height - 1, pointer_c:pointer_c + window_width - 1, 1) = 255;
        image_detected(pointer_r + window_height - 1, pointer_c:pointer_c + window_width - 1, 2) = 0;
        image_detected(pointer_r + window_height - 1, pointer_c:pointer_c + window_width - 1, 3) = 0;
        image_detected(pointer_r:pointer_r + window_height - 1, pointer_c, 1) = 255;
        image_detected(pointer_r:pointer_r + window_height - 1, pointer_c, 2) = 0;
        image_detected(pointer_r:pointer_r + window_height - 1, pointer_c, 3) = 0;
        image_detected(pointer_r:pointer_r + window_height - 1, pointer_c + window_width - 1, 1) = 255;
        image_detected(pointer_r:pointer_r + window_height - 1, pointer_c + window_width - 1, 2) = 0;
        image_detected(pointer_r:pointer_r + window_height - 1, pointer_c + window_width - 1, 3) = 0;
    end

end
