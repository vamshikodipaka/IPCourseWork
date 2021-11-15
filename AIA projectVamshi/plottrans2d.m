function image=plottrans2d(waveco,l);
%% This function gives the transform 2D
% reading the size
di=size(waveco);
if (size(waveco,3)==1)
   image=waveco;
   
   for x=1:l,
      
      itin=waveco(1:(di(1)/(2^x)),(di(2)/(2^x))+1:(di(2)/(2^(x-1))));
      itin = itin-min(min(itin));
      % iter over the image
      itin = (itin*255)/max(max(itin));
      min(min(itin))
      max(max(itin))
      % exponentional reduction
      image(1:(di(1)/(2^x)),(di(2)/(2^x))+1:(di(2)/(2^(x-1)))) = itin;
      
      itin=waveco((di(1)/(2^x))+1:(di(1)/(2^(x-1))),1:(di(2)/(2^x)));
      itin = itin-min(min(itin));
      % iter over the image
      itin = (itin*255)/max(max(itin));
      % exponentional reduction
      image((di(1)/(2^x))+1:(di(1)/(2^(x-1))),1:(di(2)/(2^x))) = itin;
      
      itin=waveco((di(1)/(2^x))+1:(di(1)/(2^(x-1))),(di(2)/(2^x))+1:(di(2)/(2^(x-1))));
      itin = itin-min(min(itin));
       % iter over the image
      itin = (itin*255)/max(max(itin));
      % exponentional reduction
      image((di(1)/(2^x))+1:(di(1)/(2^(x-1))),(di(2)/(2^x))+1:(di(2)/(2^(x-1)))) = itin;
   end;
   itin=waveco(1:(di(1)/(2^(l))),1:(di(2)/(2^(l))));
   itin = itin-min(min(itin));
    % iter over the image
   itin = (itin*255)/max(max(itin));
     % exponentional reduction
   image(1:(di(1)/(2^(l))),1:(di(2)/(2^(l)))) = itin;
   imagesc(image);
else
   image=waveco;
   for x=1:l,
      clear itin
      itin=waveco(1:(di(1)/(2^x)),(di(2)/(2^x))+1:(di(2)/(2^(x-1))),:);
      itin=itin+abs(min(min(min(itin))))+1e-003;
      itin=itin./(max(max(max(itin)))+1e-003);
      
      image(1:(di(1)/(2^x)),(di(2)/(2^x))+1:(di(2)/(2^(x-1))),:) = itin;
      %%%%
      itin=waveco((di(1)/(2^x))+1:(di(1)/(2^(x-1))),1:(di(2)/(2^x)),:);
      itin=itin+abs(min(min(min(itin))))+1e-003;
      itin=itin./(max(max(max(itin)))+1e-003);
      image((di(1)/(2^x))+1:(di(1)/(2^(x-1))),1:(di(2)/(2^x)),:) = itin;
            
      %%%% 
      itin=waveco((di(1)/(2^x))+1:(di(1)/(2^(x-1))),(di(2)/(2^x))+1:(di(2)/(2^(x-1))),:);
      itin=itin+abs(min(min(min(itin))))+1e-003;
      itin=itin./(max(max(max(itin)))+1e-003);
      image((di(1)/(2^x))+1:(di(1)/(2^(x-1))),(di(2)/(2^x))+1:(di(2)/(2^(x-1))),:) = itin;
     end;
   itin=waveco(1:(di(1)/(2^(l))),1:(di(2)/(2^(l))),:);
   itin=itin+abs(min(min(min(itin))))+1e-003;
   itin=itin./(max(max(max(itin)))+1e-003);
   image(1:(di(1)/(2^(l))),1:(di(2)/(2^(l))),:) = itin;
   % image resize with di final obtained
   min(min(min(image)))
   max(max(max(image)))
   image(image);
end;
