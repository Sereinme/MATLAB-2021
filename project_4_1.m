clear;close all;clc;
face_folder = 'data/Faces/';

face_vector_3 = FaceStandard(face_folder, 3);
face_vector_4 = FaceStandard(face_folder, 4);
face_vector_5 = FaceStandard(face_folder, 5);

figure;
subplot(3, 1, 1);
plot(face_vector_3);
title("L = 3");
subplot(3, 1, 2);
plot(face_vector_4);
title("L = 4");
subplot(3, 1, 3);
plot(face_vector_5);
title("L = 5");
saveas(gcf, 'images/4_1.jpg');
