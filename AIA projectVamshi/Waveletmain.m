%% This is your MAIN function. Run this script to get the outputs
% PROJECT :: IMAGE DENOISING WITH 2D WAVELETS AND TIKHONOV GAUSS-SEIDEL MODEL
% =========
clear all; close all; clc;

%% START BY READING YOUR INPUTS  -----------

% input the image in to matlab
Img = double(imread('data\cameraman.jpg'));
% Img = double(imread('boat.jpg'));

% Using Daubechies  orthogonal wavelets D4 Filter - circular shift in this method
LPFCoeffi =[0.48296 0.83652 0.22414 -0.12941];

%% %% K Coefficient gives the feasibility to modify the decomposition level 
Klev = 4;

%% Start the decomposition and Reconstruction process

% Discrete Wavelet Transform calling method
[C_vec, Sappr, wavcoe] = DWT(Img, Klev, LPFCoeffi);

figure(1), plottrans2d(wavcoe, Klev); colormap(gray(256));
% interpreting the Discrete Wavelet Transform output

title(['D-W-T observed at level ', num2str(Klev)]);

 figure(2)
% regeneration of the image w.r.t different specified level and accumulation
for ilev = 1:Klev
    imRegen = IDWT(C_vec, Sappr, ilev, LPFCoeffi);
    subplot(2,2,ilev);
    displayfun(imRegen);
    title(['Inv-D-W-T level ', num2str(ilev)]);
end

figure(3), 
% plot for regen output
subplot(1,2,1), displayfun(Img), title('Image Input')
subplot(1,2,2), displayfun(imRegen); 
title(['Final Regenrated at, level = ', num2str(Klev)] );

max(abs(imRegen(:)-Img(:)))

%% IMPLEMENTING IMAGE DENOISING USING WAVELETS ALGORITHM

% input the image Lena here
Img = double(imread('data\cameraman.jpg'));
% Img = double(imread('boat.jpg'));

% Using Daubechies  orthogonal wavelets D4 Filter - circular shift in this method
LPFCoeffi =[0.48296 0.83652 0.22414 -0.12941];

% K Coefficient gives the feasibility to modify the decomposition level 
Klev = 4;

var  = 20;  % fixed variance here

% Create additive gaussain white noise to apply on the imaage
gaussWhiteN = randn(size(Img)).*sqrt(var);

% Now adding the generated noise on the Lena-image
Imnoise = Img + gaussWhiteN;

% Disc-Wave-Transform method call again ---------------------------------
[C_vec, Sappr, wavcoe] = DWT(Imnoise, Klev, LPFCoeffi);

% calculating the noise level in the image -------
nE = Sappr(Klev,1) * Sappr(Klev,2);
higfrecomp = [C_vec(1, nE+1:2*nE) C_vec(1, 2*nE+1:3*nE) C_vec(1, 3*nE+1:4*nE)];

% calculating the sigma-value by median s
sig=median(abs(higfrecomp))/0.6745; 

thresh=3*sig; % statistical calculus

% APPLYING Soft thresholding Technique
CSoft = (sign(C_vec).*(abs(C_vec)-thresh)).*((abs(C_vec)>thresh));

% APPLYING Hard thresholding Technique
CHard = C_vec.*((abs(C_vec)>thresh));

%regeneration with soft and hard threshold applied on Lena image
imRegenSoftThr = IDWT(CSoft, Sappr, Klev, LPFCoeffi);
imRegenHardThr = IDWT(CHard, Sappr, Klev, LPFCoeffi);

figure(4)
subplot(2,2,1), displayfun(Img), title('image input');
subplot(2,2,2),displayfun(Imnoise), 
title(['Image noised,  varia :', num2str(var)]);

% Display output of Hard and Soft Thresholds
subplot(2,2,3),displayfun(imRegenSoftThr), title('Output Denoise Soft Thresh')
subplot(2,2,4),displayfun(imRegenHardThr), title('Output Denoise Hard Thresh')

% MSQE statistical calculus with variance fixed
msqeSoftThr = mean((Img(:)-imRegenSoftThr(:)).^2)
msqeHardThr = mean((Img(:)-imRegenHardThr(:)).^2)



%% Here DENOISING done using wavelets for VARAINCE differing b/w 0 to 20 and then plot error

%% input the image Lena here
Img = double(imread('data\cameraman.jpg'));
% I = double(imread('boat.jpg'));

% Using Daubechies  orthogonal wavelets D4 Filter - circular shift in this method
LPFCoeffi =[0.48296 0.83652 0.22414 -0.12941];

% K Coefficient gives the feasibility to modify the decomposition level 
Klev = 4;

msqeSoftThr = [];
msqeHardThr = [];

for var = 0:2:20

% Create additive gaussian white noise to apply on the imaage
gaussWhiteN = randn(size(Img)).*sqrt(var);

% Now adding the generated noise on the Lena-image
Imnoise = Img + gaussWhiteN;

% Disc-Wave-Transform method call again ---------------------------------
[C_vec, Sappr, wavcoe] = DWT(Imnoise, Klev, LPFCoeffi);

% calculating the noise level in the image -------
nE = Sappr(Klev,1) * Sappr(Klev,2);
higfrecomp = [C_vec(1, nE+1:2*nE) C_vec(1, 2*nE+1:3*nE) C_vec(1, 3*nE+1:4*nE)];

% calculating the sigma-value by median s
sig=median(abs(higfrecomp))/0.6745;

thresh=3*sig;    % statistical calculus

% APPLYING Soft thresholding Technique
CSoft = (sign(C_vec).*(abs(C_vec)-thresh)).*((abs(C_vec)>thresh));

% APPLYING Hard thresholding Technique
CHard = C_vec.*((abs(C_vec)>thresh));

%regeneration with soft and hard threshold of the lena image
imRegenSoftThr = IDWT(CSoft, Sappr, Klev, LPFCoeffi);
imRegenHardThr = IDWT(CHard, Sappr, Klev, LPFCoeffi);

% calculate the msqe error variation -- with every change in the variance
msqeSoftThr = [msqeSoftThr mean(sqrt((Img(:)-imRegenSoftThr(:)).^2))];
msqeHardThr = [msqeHardThr mean(sqrt((Img(:)-imRegenHardThr(:)).^2))];

end

% plot the error curve -----
figure
subplot(1,2,1)
plot(0:2:20, msqeSoftThr), xlabel('variance on x-axis')
ylabel('MSQE error(intensity on y-axis)'), 
title(' Variation of Soft Thresholding on the image')

subplot(1,2,2)
plot(0:2:20, msqeHardThr), xlabel('variance on x-axis')
ylabel('MSQE error (intensity on y-axis)'), 
title(' Variation of Hard Thresholding on the image')
