
function [H] = histequ(G)

%%
%This is a histequ function 
%give the input image at the console to display the output 
%%

numofpix=size(G,1)*size(G,2);
figure,imshow(G);
title('Original Image');
H=uint8(zeros(size(G,1),size(G,2)));
f=zeros(256,1);
probf=zeros(256,1);
probc=zeros(256,1);
cum=zeros(256,1);
output=zeros(256,1);
n=1:256;
%freq counts the occurrence of each pixel value.
%The probability of each occurrence is calculated by probf.
for i=1:size(G,1)
    for j=1:size(G,2)
        val=G(i,j);                             
        f(val+1)=f(val+1)+1;               
        probf(val+1)=f(val+1)/numofpix;         
    end
end
figure,stem(n,probf,'Marker','None')
title('Probability Distribution Function')
sum=0;
no=255;
%The cumulative distribution probability is calculated. 
for i=1:size(probf)
   sum=sum+f(i);
   cum(i)=sum;
   probc(i)=cum(i)/numofpix;
   output(i)=round(probc(i)*no);
end


for i=1:size(G,1)
    for j=1:size(G,2)
            H(i,j)=output(G(i,j)+1);
    end
end
figure, imshow(H);
title('Histogram equalization');
figure,histogr(H);
xlabel('intensity levels')
ylabel('no of pixels :: count')
end