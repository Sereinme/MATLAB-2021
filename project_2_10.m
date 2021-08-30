clear;close all;clc;
load('data/jpegcodes.mat');

Compression_ratio = height*width*8/(length(AC)+length(DC));
fprintf("Compression ratio: %5.4f\n", Compression_ratio);