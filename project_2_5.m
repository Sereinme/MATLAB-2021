clear;close all;clc;

a = 1;
b = [-1, 1];
freqz(b, a);
saveas(gcf,'images/2_5.jpg');