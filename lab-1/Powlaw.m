%finding power law transforms

b1=imread('spine.tif');

 ib1=im2double(b1);
[r,c]=size(ib1);
o1=ib1;
 % to make image dark take value of gamma > 1, to make image bright take value of gamma < 1
for i=1:r
    for j=1:c
         o1(i,j)=2*(ib1(i,j).^0.3);  % formula to implement power law transformation
    end
end

subplot(2,2,1), imshow(b1);
title('Original Image');
subplot(2,2,2), imshow(o1);
title('PL Transform Image');

b2=imread('aerial.tif');
ib2=im2double(b2);
[r,c]=size(ib2);
o2=ib2;
 % to make image dark take value of gamma > 1, to make image bright take value of gamma < 1
for i=1:r
    for j=1:c
         o2(i,j)=2*(ib2(i,j).^1.8);  % formula to implement power law transformation
    end
end

subplot(2,2,3), imshow(b2);
title('Original Image');
subplot(2,2,4), imshow(o2);
title('PL Transform Image');

figure; imhist(b1);
title('Hist of first Original Image');
figure; imhist(o1);
title('Hist of second transform Image');

figure; imhist(b2);
title('Hist of first Original Image');
figure; imhist(o2);
title('Hist of second transform Image');
