function [Img1 Im1noi Img2 Im2noi] = LoadIData
%% This fucntion will load the data of image with noise
% image access rows and clumns/
Img1 = zeros(1000,1);
Img1(1:200) = 1;
Img1(201:300) = 4;
Img1(301:600) = 2;
Img1(601:650) = 3;
Img1(651:end) = 1;
% adding random gerenated noise to the iamge ========
Im1noi = Img1 + 0.3*randn(size(Img1));
figure(1);
% plot the image
plot(Img1,'r-','LineWidth',2);
hold on;
% plot noisy image
plot(Im1noi,'r.');
hlen = legend('CleanTest','NoisyTest');
set(hlen,'FontSize',20);
set(gca,'FontSize',2);

% input the imge to be denoised =======
Img2 = imread('data\cameraman.jpg');
Img2 = double(Img2);
r = 20;
% gernerate the random noise
Im2noi = Img2 + r*randn(size(Img2));
figure(2); 
% plot the image
subplot(1,2,1);
imshow(Img2,[]);
title('Orig-image-2','FontSize',20);
subplot(1,2,2);
% plot the noisy image
imshow(Im2noi,[]);
title('Noisy-image2','FontSize',20);