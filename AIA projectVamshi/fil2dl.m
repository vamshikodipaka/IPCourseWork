function imageFilt = fil2dl(Im, hfil, R)
%% This function is to apply LPF or HPF on every row or colum of given lena image
% R       -       Row - (1),  Column  - (0)
%%
%get size of image
[x,y] = size(Im);
imageFilt = zeros(x,y);

%for accessing Row wise
if (R == 1)
    
    for n_Row = 1:x
        % finding circular convolution here ---------
        imageFilt(n_Row, :) = fliplr(cconv(fliplr(Im(n_Row,:)), fliplr(hfil), y));
        
    end
    
    %for accessing Column wise
elseif (R == 0)
    
    for n_Col = 1:y
         % finding circular convolution here ---------
        imageFilt(:, n_Col) = fliplr(cconv(fliplr(Im(:,n_Col)'), fliplr(hfil), x));
        
    end
    
    
end