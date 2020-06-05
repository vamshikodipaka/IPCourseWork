
clc
clear all;
close all;

I=imread('saturn.png');
I2=imread('saturn_noise.png');
I3=imread('saturn_noise2.png');
Mav=ones(3)/9;
Mgaus=[1 4 1; 4 16 4; 1 4 1]/36;
Iav=imfilter(I,Mav);
Igaus=imfilter(I,Mgaus);
I2av=imfilter(I2,Mav);
I2gaus=imfilter(I2,Mgaus);
subplot(2,2,1), imshow(Iav,[]);
subplot(2,2,2), imshow(Igaus,[]);
subplot(2,2,3), imshow(I2av,[]);
subplot(2,2,4), imshow(I2gaus,[]);
% // plot(I(100,:));

