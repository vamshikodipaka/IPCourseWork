clc;
clear all;
close all;

%% ~~~~~~~~~~~~~~~~~~~ Arithmetic Coding ~~~~~~~~~~~~~~~~~~~

% Encoder
Symb = ['A','C','T','G'];
Prob = [0.5 , 0.3 ,0.15 , 0.05];
Seq = [ 'A' , 'C', 'T', 'A' , 'G', 'C'];

Encode = Arith_Encoder(Symb , Prob , Seq);

% Decoder
Decode = Arith_Decoder(Symb , Prob , Encode);

%% ~~~~~~~~~~~~~~~~~~~~~ Huffman Coding ~~~~~~~~~~~~~~~~~~~~

% Read an image
I = imread('lena.bmp');

% Convert image into probability list (in descending order)
I_Prob = Prob_Vector(I);

Huff_Result = Huff_Encoder(I_Prob);

%% ~~~~~~~~~~~~~~~~~~~~~~ JPEG Coding ~~~~~~~~~~~~~~~~~~~~~~
 
Jpeg_Result = JPEG(I);
