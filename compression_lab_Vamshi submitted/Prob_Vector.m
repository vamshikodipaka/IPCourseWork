
function temp = Prob_Vector( img )

[M , N]= size(img);
temp = zeros(1,256);
len = length(temp);
    for i = 1:M
        for j = 1:N
            temp(img(i,j)) = temp(img(i,j)) + 1;
        end
    end
   
  temp = sort (temp ,'descend');
  temp = vpa(temp./ (M*N));
  mark = 0;
  for i=1:len
      if temp(i) > 0
          continue;
      else
         mark = i;
         break;
      end
  end
  
  temp = temp(1:mark-1);
    
end

