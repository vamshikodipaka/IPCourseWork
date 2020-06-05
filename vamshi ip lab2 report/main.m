clear all; close all; clc;
%% Function Implemtation of Image :: Translation, Rotation and Interpolation

% I = imread('lena.jpeg');
% myTranslation(I, 45, 30);

% J = imread('cameraman.tif');
% myRotation(J, -30, 'bilinear');

% Function Implemtation of Image :: Projective Transformation

% Input = imread('plate_side.jpg');
% Ref = imread('plate_reference.jpg');
% projectiveTransform(Input, Ref);

%% Function Implemtation of Image :: Procrustes Analysis

M = load('star_points.mat');
myProcrustes(M.input_points,M.base_points);