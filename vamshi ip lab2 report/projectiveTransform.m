function [Projected_image] = projectiveTransform(I, ref)
%MYPROCRUSTES Function that stretches or contracts the input points set to fit the reference points set.
%   Input    I - Input image     Y - Reference image
%
%   Output   O - Output Image (after projective transformation)

%% Function starts here

% Get coordinates of input and reference image
figure, imshow(I), title('Input Image of plate');
[x,y] = ginput(4);

figure, imshow(ref), title('Reference Image of the plate');
[x1, y1] = ginput(4);

X = [x,y];
Y = [x1,y1];

% Performing Projective Transformation [fitgeotrans is same as cp2tform]
T = cp2tform(X, Y, 'projective');

% Applying Transformation on the input image
Projected_image = imtransform(I, T);
figure, imshow(Projected_image), title('Projective Transformation');

% Cropping the Transformed image
[~, rect] = imcrop(Projected_image);
Img_crop = imcrop(Projected_image, rect);
figure, imshow(Img_crop), title('Croped Image (After Transformation)');

end

