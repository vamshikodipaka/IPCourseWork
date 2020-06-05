function [O] = myTranslation(I, tx, ty)
%MYTRANSLATION Function shifts the image vertically by tx pixels and horizontlly by ty pixels.
%   Input::  I  - Input Image    tx - Vertical Shift     ty - Horizontal Shift
%
%   Output::  O - Translated Image

%% Function starts here
O = uint8( zeros(size(I,1), size(I,2), size(I,3)));
[r,c,~] = size(O);
for i=1:r
    for j=1:c
        
        % Shifted vertically by tx and horizontlly by ty
        O(i+tx:end, j+ty:end, :)  =  I(i:end-tx,j:end-ty,:); 
        
    end
end

% Display the Resultant of Translated Image
figure,
subplot(1,2,1), imshow(I), title('Original Image');
subplot(1,2,2), imshow(O), title('Translated Image');

end

