clear;close all;clc;
image = imread('data/R-C.bmp');

face_folder = 'data/Faces/';
detect_window = [90,60];
epsilon = 0.45;
image_detected = FaceDetect(image, face_folder, 5, detect_window, epsilon);
imwrite(image_detected,'images/4_2.jpg');
imshow(image_detected);