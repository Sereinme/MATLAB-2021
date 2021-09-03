clear;close all;clc;
image = imread('data/R-C.bmp');
[height, width, ~] = size(image);
image_resize = imresize(image, [height, 2 * width]);

face_folder = 'data/Faces/';
detect_window = [90, 120];
epsilon = 0.32;
image_detected = FaceDetect(image_resize, face_folder, 4, detect_window, epsilon);
imwrite(image_detected,'images/project_4_3_2.jpg');
imshow(image_detected);
