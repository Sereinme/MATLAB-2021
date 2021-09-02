function image_detected = FaceDetect(image, face_folder, L, detect_window, epsilon)
    %FaceDetect: detect faces in image
    %image: detected image
    %detect_window: window size of detection
    %epsilon: threshold of detect
    %image_detected: output image with red window
    face_standard = FaceStandard(face_folder, L);
    window_height = detect_window(1);
    window_width = detect_window(2);

end
