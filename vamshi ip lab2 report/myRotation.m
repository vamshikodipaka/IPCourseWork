function [O] = myRotation(I, ang, method)
%MYROTATION rotates the image from its centre with an angle 'theta'.
%  Input :: Input Image     ang  - Angle of Rotation    method  - Interpolation method {'nearest', 'bilinear'}

%  Output::  O - Rotated Image

%% Function starts here

I = im2double(I);

theta=(ang)*pi/360; % Angle of Rotation

[r, c] = size(I); % Size of the Image

O = zeros(size(r,c));

midx = r./2; % Midpoint of x-axis
midy = c./2; % Midpoint of y-axis

for i=1:r
    for j=1:c
        
        % Rotation steps (based on the Given Formula)
        x=(i-midx)*cos(theta)-(j-midy)*sin(theta);
        y=(i-midx)*sin(theta)+(j-midy)*cos(theta);
        x1=round(x)+midx;
        y1=round(y)+midy;
        
        % Interpolation steps
        if (1 <= x1 && x1 <= r && 1 <= y1 && y1 <=c)
            top = floor(x1);         bottom = top+1;
            left = floor(y1);       right = left+1;
            switch method % Select any one method to interpolate
                case 'nearest' % Nearest Neighbour Interpolation
                    if (bottom <= r && right <= c)
                     inten_1 =  I(top, left);    inten_2 =  I(bottom, left);
                     inten_3 =  I(top, right);   inten_4 =  I(bottom, right);
                     inten = (inten_1 + inten_2 + inten_3 + inten_4)/4;
                    end
                 
                case 'bilinear' % Bilinear Interpolation
                  if (bottom <= r && right <= c)
                     inten_1 =  I(top, left);  inten_2 =  I(bottom, left);
                     leftInten = (x1-top) * (inten_2 - inten_1) + inten_1;
                       
                     inten_3 =  I(top, right); inten_4 =  I(bottom, right);
                     rightInten = (x1-top) * (inten_4 - inten_3) + inten_3;
                        
                     inten = (y1 - left) * (rightInten - leftInten) + leftInten;
                  end
            end
        else
            inten = 0; % Parts other than input image appears black
        end
        O(i,j)=inten; % Store the output image 
    end
end

% Display the Result
figure,
subplot(1,2,1),imshow(I), title('Original Image of cameraman');
subplot(1,2,2),imshow(O), title('Rotated Image of cameraman');

end

