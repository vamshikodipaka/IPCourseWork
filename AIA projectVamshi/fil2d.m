function imFilter = fil2d(InpIm, hfilco, Rcol)
%%% This function gives the HPF or LPF coeff filter
% function to apply LPF or HPF on every row or colum of the image
% R       -       Row - (1)   ; Col  - (0)
%%
% obtaining Im-size
[x,y] = size(InpIm);
imFilter = zeros(x,y);

% Access filt Row wise
if (Rcol == 1)
    
    for nR = 1:x
                %Perfoming the circular convolution  ----
        imFilter(nR, :) = cconv(InpIm(nR,:), hfilco, y);
    end
    
    % Access filt Col wise -----
elseif (Rcol == 0)
    
    for nCol = 1:y
                % Performing the circular convolution 
        imFilter(:, nCol) = cconv(InpIm(:,nCol)', hfilco, x);
        
    end
    
end