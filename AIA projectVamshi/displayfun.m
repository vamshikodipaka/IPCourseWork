function hfilterco=displayfun(image);
% Display the image here

% Conditional access of columns and or rows--
if (size(image,3)==1)
    %clf;
    if ((image(1,1)==21) & (image(2,2)==21))
        hfilterco=image(image);
    else
        hfilterco=imagesc(image);
    end;
    colormap(gray);
else
    % just fix the tresholds and subtract ---
    image=image-min(min(min(image)));
    image=image/max(max(max(image)));
    imagesc(image);
end;