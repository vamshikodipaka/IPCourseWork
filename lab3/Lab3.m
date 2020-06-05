I=imread('building.jpg');
M=[1 4 1; 4 16 4; 1 4 1]/36;
If=imfilter(I,M);
IS=imfilter(I,M,'symmetric');
IR=imfilter(I,M,'replicate');
IC=imfilter(I,M,'circular');
subplot(221), imshow(I,[])
subplot(222), imshow(If,[])
subplot(223), imshow(IS,[])
subplot(224), imshow(IR,[])
figure, imshow(IC,[]);