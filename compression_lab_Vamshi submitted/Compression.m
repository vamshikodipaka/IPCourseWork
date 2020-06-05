clc;
clear all;
close all;

%~~~~~~~~~~~~~~~~~~~ Arithmetic Coding ~~~~~~~~~~~~~~~~~~~%

Symb = ['A','C','T','G'];
Prob = [0.5 , 0.3 ,0.15 , 0.05];
Seq = [ 'A' ,'C' , 'T', 'A', 'G' , 'C'];

Encode = Arith_Encoder (Symb , Prob , Seq)

%~~~~~~~~~~~~~~~~~~~ Arithmetic Decoding ~~~~~~~~~~~~~~~~~~~%

Arith_Decoder(Symb , Prob , Encode)

%~~~~~~~~~~~~~~~~~~~ Huffman coding ~~~~~~~~~~~~~~~~~~~%

% Huffman code of an image

img = imread('lena.bmp');

% Convert image to probability list
img_prob = Prob_Vector(img)
% Huff_Encoder(img_prob)

%~~~~~~~~~~~~~~~~~~~ JPEG coding ~~~~~~~~~~~~~~~~~~~%
 
result = JPEG(img)
