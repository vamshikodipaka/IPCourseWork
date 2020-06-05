clc
clear all;
close all;
I=imread('saturn_noise2.png');
medf=medfilt2(I);
Mav=ones(3)/9;
Mgaus=[1 4 1; 4 16 4; 1 4 1]/36;
Iav=imfilter(I,Mav);
Igaus=imfilter(I,Mgaus);
subplot (2,2,1), imshow(I,[]);
subplot (2,2,2), imshow(medf,[]);
subplot (2,2,3), imshow(Iav,[]);
subplot (2,2,4), imshow(Igaus,[]);