clc
clear all;
close all;
I=imread('saturn.png');
Mx=[1 0 -1; 2 0 -2; 1 0 -1];
My=[1 2 1; 0 0 0 ; -1 -2 -1];
Ix=imfilter(I, Mx);
Iy=imfilter(I, My);
subplot(2,2,1), imshow(Ix, []);
subplot(2,2,2), imshow(Iy, []);

[r,c]=size(I);
Norm_Image = zeros(size(I));

for i = 1:r
    for j = 1:c
        Norm_Image(i,j) = sqrt((Ix(i,j)*Ix(i,j))+(Iy(i,j)*Iy(i,j)));
    end
end

figure, imshow(Norm_Image);