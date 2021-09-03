clear;close all;clc;
image = imread('data/R-C.bmp');
image_rotate = imrotate(image, -90);

face_folder = 'data/Faces/';
detect_window = [60,90];
epsilon = 0.32;
image_detected = FaceDetect(image_rotate, face_folder, 4, detect_window, epsilon);
imwrite(image_detected,'images/project_4_3_1.jpg');
imshow(image_detected);