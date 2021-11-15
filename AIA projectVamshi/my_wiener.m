%% WIENER BASED 2d IMAGE DENOISING 
clear all
close all
clc
%% 
%Read the input image
image=imread('data\cameraman.jpg');
imshow(image);
% plot input image here
title('Input orig. Image');
Nsiz=512;
Imorigi=double(image);

% orig. input image Power Spectral Density ---------
ImorigFT=fft2(Imorigi);
IorigPSD=fftshift((abs(ImorigFT).^2)./(Nsiz*Nsiz));

% added noise     ----------
sigma_u=50;
noise=sigma_u*randn(size(Imorigi));
% plot noisy image
figure,imshow(uint8(Imorigi+noise));
title('Noisy Image');

%noisy images' Power Spectral Density   ------
noisyFT=fft2(noise);
noisyPSD=fftshift((abs(noisyFT).^2)./(Nsiz*Nsiz));
phi=sum(sum(noisyPSD))/(Nsiz*Nsiz)

%image+noise here ------
Imgg=Imorigi;
Imgg=Imgg+noise;
% Applying inverse fourier --------
InvFT=fft2(Imgg);
Ishifted=fftshift(InvFT);

% Now applying Gaussian smoothing -----------
smoo_Filter = fspecial('gaussian',[5 5], 1);
smooImg = imfilter(uint8(Imgg), smoo_Filter, 'replicate');
figure,imshow(smooImg);
title('Noisy image after given Gaussian smoothing');
%  estimate smoothed image INV Power Spectral Density --------------
smootedInvFT=fft2(smooImg);
smootedInvPSD=fftshift((abs(smootedInvFT).^2)./(Nsiz*Nsiz));

% Now multiplying by wiener filter in the frequency domain ---------
filter=zeros(Nsiz);
filteredFT=zeros(Nsiz);
for x=1:Nsiz
    for y=1:Nsiz
        Fun(x,y)=(smootedInvPSD(x,y)/(smootedInvPSD(x,y)+phi));
        filteredFT(x,y)=Ishifted(x,y)*Fun(x,y);
    end
end

% output plots for wiener filter in freq. ------------
figure,subplot(1,1,1),surf(Fun);
title('Output of the created Wiener Filter in Freq.D')

%inverse DFT to obtain the wiener filtered image -------
filtredImg=(real(ifft2(ifftshift(filteredFT))));

% plotted results ==========
figure,imshow(uint8(filtredImg));
title('Output of Wiener Filtered Image obtianed')
