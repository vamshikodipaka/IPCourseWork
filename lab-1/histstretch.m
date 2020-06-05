

function [O] = histstretch(img1)

%%
%This is a histretch function 
%give the input image at the console to display the output 
%%
img1=im2double(img1);
[r,c]=size(img1);
a=min(img1(:));          %minimum intensity of the image
b=max(img1(:));          %maximum intensity of the image
O=zeros(r,c);

for i=1:r
    for j=1:c
        if img1(i,j)<a
            O(i,j)=0;
        elseif img1(i,j)>b
            O(i,j)=255;
            else
              O(i,j)= 255*(img1(i,j)-a)/(b-a);    % implementation of the function
            end
     end
end

subplot(1,2,1), imshow(img1);
title('Original Image');
subplot(1,2,2), imshow(uint8(O));
title('final Image');

figure,imhist(uint8(O));
title('Histogram Stretching Image');

xlabel('intensity levels')
ylabel('no of pixels :: count')
end