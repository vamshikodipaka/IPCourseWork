function imdownsamp = downsamp2d(Img, RCol)
%%% function to downsample a image row or column wise
% R       -       Row - (1)  , Column  - (0)
%%
% obtaining the im-size
[x,y] = size(Img);

%for accessing col wise
if (RCol == 1)
    imdownsamp = zeros(x,y/2);
    for nR = 1:x
        Imt = Img(nR, :);
        imdownsamp(nR, :) = Imt(1:2:y);
    end
    
%for accessing row wise
elseif (RCol == 0)
    imdownsamp = zeros(x/2,y);
    for nCol = 1:y
        Imt = Img(:, nCol);
        imdownsamp(:, nCol) = Imt(1:2:x);
    end
end