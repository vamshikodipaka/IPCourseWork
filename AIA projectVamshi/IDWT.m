function imRegen = IDWT(C_vect, Sappr, Klev, LPFCo)
% This function finds the IDWT at given level K on lena image by LPF Coeff
%% C_vec    -      a vector with rows defined:
%                  A(K), H(K), V(K), D(K),
%                  H(K-1), V(K-1), D(K-1), ...,
%                  H(1), V(1), D(1),
%  observe A, H, V, and D are row each invidually n a column vector rep in matrix.
%  A has approx-coeff,  H has horiz-coeff, V has vert-coeff, D has diag-coeff
%  ------
% Sapprox   -      S(1,:) = approx coff size(K).
%                  S(j,:) = details coeff(J-i+2) for j = 2, ...K+1, S(K+2,:) = size(Img).
% wavcoe    -      Arranged matrix of S components -------
% imageReconst    -   Reconstructed image
%%
% estimate LPF and HPF coeff for regeneration
LPFCo = fliplr(LPFCo);                      % flip left to right coeff.

for z=0:length(LPFCo)-1,
    hpfCo(z+1)=LPFCo(z+1)*(-1)^(z+1); % turn odd terms negative signed
end;

hpfCo=hpfCo(length(hpfCo):-1:1); %flip the coeff mat

for lev = 1:Klev
    
    nE = Sappr(lev,1) * Sappr(lev,2); %obtaining nelem i matrix to get from C
    
    if (lev == 1)
        At = C_vect(1, 1:nE); At = reshape(At, Sappr(lev,:));
    end                       % reshapping the matric
    
    Ht = C_vect(1, nE+1:2*nE); Ht = reshape(Ht, Sappr(lev, :));
    Vt = C_vect(1, 2*nE+1:3*nE); Vt = reshape(Vt, Sappr(lev, :));
    Dt = C_vect(1, 3*nE+1:4*nE); Dt = reshape(Dt, Sappr(lev, :));
    
    %% Apply Inv-WaveletTransform on the COLUMN (analysis from main.m)
    
    % performing Low-Pass-Filter Estimate on col
    ImLpfdownsamp = [At Ht];
    
    % Performing upsampling on the obtained col
    ImLpfupsamp = upsamp2d(ImLpfdownsamp, 0);
    
    % applying LPF on the upsaample
    ImLpfupsampLpf = fil2dl(ImLpfupsamp, LPFCo, 0);
    
    %For HPF terms here to make mat.
    ImHpfdownsamp = [Vt Dt];
    
    % applying upsampling here ----
    ImHpfupsamp = upsamp2d(ImHpfdownsamp, 0);
    
    % applying finally LPF to get the col mat.
    ImHpfupsampHpf = fil2dl(ImHpfupsamp, hpfCo, 0);
    
    % gathering the samples
    Icol = (ImLpfupsampLpf + ImHpfupsampHpf);
    
    %% Apply Inv-WaveletTransform on the ROW (analysis from main.m)
    
    % performing Low-Pass-Filter Estimate on Row
    ImLpfdownsamp = Icol(:, 1:Sappr(lev,2));
    
    % Performing upsampling on the obtained row
    ImLpfupsamp = upsamp2d(ImLpfdownsamp, 1);
    
    % applying LPF on the upsaample
    ImLpfupsampLpf = fil2dl(ImLpfupsamp, LPFCo, 1);
    
    %For HPF terms here to make mat.
    ImHpfdownsamp = Icol(:, Sappr(lev,2)+1:2*Sappr(lev,2));
    
    % applying upsampling here ----
    ImHpfupsamp = upsamp2d(ImHpfdownsamp, 1);
    
    % applying finally LPF to get the row mat.
    ImHpfupsampHpf = fil2dl(ImHpfupsamp, hpfCo, 1);
    
    %%%% finally gathering the image samples
    imRegen = (ImLpfupsampLpf + ImHpfupsampHpf);
    
    %%%%% USING this regenerate the output for next iteration  %%%%%
    At = imRegen;
end