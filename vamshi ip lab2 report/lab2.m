clc;
clear;
close all;

%Image Addition
A = imread('cameraman.tif');
[r,c] = size(A);
% Self Impl
B = 100*(ones(r,c));
C = zeros(r,c,'uint8');

for i=1:r
    for j=1:c
        C(i,j)=B(i,j)+A(i,j);
    end
end

subplot(1,3,1), imshow (A);
subplot(1,3,2), imshow(C);
D = imadd(A,100); 
subplot(1,3,3), imshow(D);

%Image Subtraction
A1 = rgb2gray(imread('cola1.png'));
B1 = rgb2gray(imread('cola2.png'));

[m,n] = size(A1);

C1 = imsubtract(A1,B1);
D1 = imabsdiff(A1,B1);

figure,
subplot(2,2,1),imshow(A1);
subplot(2,2,2), imshow(B1);
subplot(2,2,3), imshow(C1);
subplot(2,2,4), imshow(D1);

%Image Blending (Simple Blend)
M = uint8([ones(m,n/2) zeros(m,n/2)]);

FirstHalf = immultiply(A1, M);
SecondHalf = immultiply(B1, 1-M);

Blend = imadd(FirstHalf, SecondHalf);

figure,
subplot(1,3,1), imshow (A1);
subplot(1,3,2), imshow(B1);
subplot(1,3,3), imshow(Blend);

% Simple Blend performed in a sequence of Images
A2 = imread('cells_01.tif');
B2 = imread('cells_02.tif');
C2 = imread('cells_09.tif');
D2 = imread('cells_10.tif');

[i,j] = size(A2);

M1 = uint8([ones(i,j/4) zeros(i,3*j/4)]);
M2 = uint8([zeros(i,j/4) ones(i,j/4) zeros(i,j/2)]);
M3 = uint8([zeros(i,j/2) ones(i,j/4) zeros(i,j/4)]);
M4 = uint8([zeros(i,3*j/4) ones(i,j/4)]);

P1 = immultiply(A2, M1);
P2 = immultiply(B2, M2);
P3 = immultiply(C2, M3);
P4 = immultiply(D2, M4);


Half1 = imadd(P1, P2);
Half2 = imadd(P3, P4);

Blend2 = imadd(Half1, Half2);

figure, imshow(Blend2);