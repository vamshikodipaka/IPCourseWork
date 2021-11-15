function [C_vec, Sappr, wavcoe] = DWT(Img, Klev, LPFCoeffi)
% This function finds the DWT at given level K on lena image by LPF Coeff
%% C_vec    -      a vector with rows defined: 
%                  A(K), H(K), V(K), D(K),
%                  H(K-1), V(K-1), D(K-1), ...,
%                  H(1), V(1), D(1),
%  observe A, H, V, and D are row each invidually n a column vector rep in matrix.
%  A has approx-coeff,  H has horiz-coeff, V has vert-coeff, D has diag-coeff
%  ------
% Sapprox   -      S(1,:) = approx coff size(K).
%                  S(j,:) = details coeff(J-i+2) for j = 2, ...K+1, S(K+2,:) = size(Img).
% wavcoe    -      Arranged matrix of S components
%% 

% compute the image size
[x,y] = size(Img);

% estimate the High-Pass Filter coefficients   ----
hpf_coeffi = LPFCoeffi.*power(-1*ones(1,length(LPFCoeffi)),(0:length(LPFCoeffi)-1)); 
% turn off the even terms as -ve signed
hpf_coeffi=  hpf_coeffi(length(hpf_coeffi):-1:1); % fliping the terms of HPF

% initializing the C_vec and Sappr
C_vec = []; Sappr = [x, y];

%%
for lev = 1:1:Klev
    
    if (lev > 1)
        C_vec = C_vec(1, numel(Img)+1:end);
    end
    
    %% Apply WaveletTransform on the row (analysis from main.m)
    %applying Low-Pass-Filter attribites
    ImLpfnewRow = fil2d(Img, LPFCoeffi, 1);
    
    %apply downsampling on the obtained row 
    ImdownsampRowLpf = downsamp2d(ImLpfnewRow, 1);
    
    % applying High-Pass-Filter on the Image row
    ImHpfnewRow = fil2d(Img, hpf_coeffi, 1);
    
    % apply downsampling on the obtained row 
    ImdownsampRowHpf = downsamp2d(ImHpfnewRow, 1);
    
    % rearranging the row in column
    ImgRow = [ImdownsampRowLpf ImdownsampRowHpf];
    
    %% Apply WaveletTransform on the COLUMN (analysis from main.m)
   
    % performing Low-Pass-Filter Estimate on col
    ImLpfnewCol = fil2d(ImgRow, LPFCoeffi, 0);
    
    % Performing downsampling on the obtained col
    ImdownsampColLpf = downsamp2d(ImLpfnewCol, 0);
    
    % performing High-Pass-Filter on the Image col
    IHpfCol = fil2d(ImgRow, hpf_coeffi, 0);
    
    % Performing downsampling on the obtained col
    ImdownsampColHpf = downsamp2d(IHpfCol, 0);
    
    % rearranging col as rows in matric
    ImCol = [ImdownsampColLpf; ImdownsampColHpf];
    
    % resizing matrix
    Sappr = [[x,y]./2^lev; Sappr];
    
    % separating to different approx.coeff 
    At = ImCol(1:Sappr(1,1), 1:Sappr(1,1));
    Ht = ImCol(1:Sappr(1,1), Sappr(1,1)+1:Sappr(2,1));
    Vt = ImCol(Sappr(1,1)+1:Sappr(2,1), 1:Sappr(1,1));
    Dt = ImCol(Sappr(1,1)+1:Sappr(2,1), Sappr(1,1)+1:Sappr(2,1));
    
    % Decoring them to form coeffs and mat-sized
    C_vec = [At(:)' Ht(:)' Vt(:)' Dt(:)' C_vec];
        
    % Using approx. coeff A for next iters..
    Img = At;
    
    % Arranging coeff. in mat. form for plot
    wavcoe(1:Sappr(1,1), 1:Sappr(1,1)) = At;
    wavcoe(1:Sappr(1,1), Sappr(1,1)+1:Sappr(2,1)) = Ht;
    wavcoe(Sappr(1,1)+1:Sappr(2,1), 1:Sappr(1,1)) = Vt;
    wavcoe(Sappr(1,1)+1:Sappr(2,1), Sappr(1,1)+1:Sappr(2,1)) = Dt;

end

