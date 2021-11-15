function imupsamp = upsamp2d(Im, R)
%% This function is used to upsample a image row or column wise
% R             -       Row - (1);  Column  - (0)
% imgdownsamp   -       Image upsampled
%%

% finiding size of image
[x,y] = size(Im);

% for accessing column wise
if (R == 1)
    imupsamp = zeros(x,y*2);
    for n_Row = 1:x
        Imtemp = Im(n_Row, :);
        imupsamp(n_Row, 1:2:size(imupsamp,2))=Imtemp;
    end
    
%for accessing row wise
elseif (R == 0)
    imupsamp = zeros(x*2,y);
    for n_Col = 1:y
        Imtemp = Im(:, n_Col);
        imupsamp(1:2:size(imupsamp, 1), n_Col) = Imtemp;
    end
    
end