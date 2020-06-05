%~~~~~~~~~~~~~~~~~~ JPEG Encoder ~~~~~~~~~~~~~~~~~~~~%
function T = JPEG (img)

% Level shift image by 2^(m-1)
img = double(img) - 128; 
[M , N ] = size(img);
imshow(img);
imwrite(img,'Written_Input.bmp','bmp');

% Default JPEG normalizing array
Z = [16 11 10 16 24 40 51 61  ;        
     12 12 14 19 26 58 60 55  ;     
     14 13 16 24 40 57 69 56  ;
     14 17 22 29 51 87 80 62  ;
     18 22 37 56 68 109 103 77;
     24 35 55 64 81 104 113 92; 
     49 64 78 87 103 121 120 101; 
     72 92 95 98 112 100 103 99];
 
%Zigzag reordering Pattern
order = [1 9 2 3 10 17 25 18 11 4 5 12 19 26 33  ...
         41 34 27 20 13 6 7 14 21 28 35 42 49 57 50 ...
         43 36 29 22 15 8 16 23 30 37 44 51 58 59 52 ...
         45 38 31 24 32 39 46 53 60 61 54 47 40 48 55 ...
         62 63 56 64];
H = dctmtx(8);

%2D DCT cosine Transform
B = blkproc(img, [8 8], 'P1 * x * P2', H, H');

%Quantization and Normalization
T = blkproc(B, [8 8], 'round(x ./ P1)', Z); 
figure(), imshow(T);
imwrite(T,'Written_Output.bmp','bmp');

% break 8 x 8 blocks into columns

T = im2col(T, [8 8], 'distinct');  

% get number of blocks
dim = size(T, 2);                    
T = T(order, :);   

% create end-of-block symbol
EOB = max(img(:)) + 1;               
r = zeros(numel(T) + size(T, 2), 1);   
count = 0;

% process one block(one column) at a time
for j = 1:dim                       
    i = find(T(:, j), 1, 'last');   % find last non-zero element
    if isempty(i)                   % check if there are no non-zero values
        i = 0; 
    end 
    p = count + 1;
    q = p + i;
    r(p:q)  = [T(1:i, j); EOB];     % truncate trailing zeros, add eob
    count = count + i + 1;          % and add to output vector
end

r((count + 1):end) = [];            % delete unused portion of r
T           = struct;
T.size      = uint16([M N]);
T.blockNo = uint16(dim);
T.huffman   = Huff_Encoder(r); 
end