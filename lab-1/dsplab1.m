%%
%Save this file :: it is the main function 
%here to run multiple functions histoequi and histostretch
%You can change input images here
%So as to get histoequi and histostretch plots
%%
im1 = imread('spine.tif');
im2 = imread('aerial.tif');

img1 = imresize(im1,0.5);
img2 = imresize(im2,0.5);

figure(1);
imshow(img1); title ('original img')

figure(2);
imshow(img2); title ('original img')

figure(3);
histstrech1 = histstretch(img1);

figure(4);
histstrech2 = histstretch(img2);

figure(5);
img1_histo = histo(img1); title ('histogram img1')
img1_hist_eq = histequ(img1);
figure(6);

img2_histo = histo(img2); title ('histogram img2')
img2_hist_eq = histequa(img2);
figure(7);
