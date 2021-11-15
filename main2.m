%%  POSTER MAKKING : PERIODIC NOISE REMOVAL USING FFT  
close all
clc
clear all
%%
st = 'C:\Users\Vamshi\Downloads\matlab\';
stF = strcat(st,'1.jpg');
A = imread(stF);

[h w c] = size(A);
if c == 3
    A = rgb2gray(A);
end
A = imadjust(A);
figure, imshow(A);
title('Original image with a periodic noise');
% Apply FFT
fft = fft2(A);          
fft(1,1) = 0;           
B = fft.*conj(fft);  

C = fftshift(255*(B -min(min(B))) /(max(max(B)) - min(min(B))));

figure; imshow(C);
title('Power spectrum density of the original image');

pos = getPosition(imrect()); 
imD = SynthesizeFilter(h, w, pos);
pos = getPosition(imrect());
imD2 = SynthesizeFilter(h, w, pos);
pos = getPosition(imrect());
imageD3 = SynthesizeFilter(h, w, pos);

imD = imD & imD2 & imageD3;

figure; imshow((C+imD)/2);
title('Power spectrum density + restoration filter mask');

%% Filtering

E = ifft2(fftshift(imD).*fft); 
fprintf("max(|real|) =  %f\nmax(|imag|) =  %f\n", max(max(abs(real(E)))), max(max(abs(imag(E)))));

E = real(E);
E = uint8(255*(E - min(min(E))) /(max(max(E)) - min(min(E))));
E = imadjust(E);

%% Output

figure; imshow(E);
title('Recovered image');

imwrite(A,strcat(st,'output2\input.jpg'));
imwrite(E,strcat(st,'output2\output.jpg'));
imwrite(C,strcat(st,'output2\Power_spectrum_density.jpg'));
imwrite((C+imD)/2,strcat(st,'output2\filter.png'));