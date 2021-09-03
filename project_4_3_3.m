clear;close all;clc;
image = imread('data/R-C.bmp');
image_adjust = imadjust(image, [.15 .15 0; .9 .9 1], []);

face_folder = 'data/Faces/';
detect_window = [90, 60];
epsilon = 0.6;
image_detected = FaceDetect(image_adjust, face_folder, 4, detect_window, epsilon);
imwrite(image_detected,'images/4_3_3.jpg');
imshow(image_detected);
