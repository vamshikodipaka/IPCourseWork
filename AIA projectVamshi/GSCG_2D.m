%% TIKHANOV BASED IMAGE DE-NOISING USING GAUSS-SEIDEL AND CONJUGATE GRADIENT METHOD

clearvars
clc; clear all; close all

%% Load Image Data
[~,~,imact im0] = LoadIData; % Load the 2-dimensional image input
Non = length(im0); % create no.of nodes in 1D
im0 = im0(:); % keep col one upon the other

maxiIt = 5; % Max.no.of iterations
toler = 1e-3; % Convergetolerance exponentially
exitflag = 0; %  rule for the convergernce
L = 2; % Norm checking for convergence

lambda_val = 0.25; % Fixing lambda value

% These parameters are Neumann condition's algebraic constraints
% coding below to find the inner points

%% Creating 2D Elliptical Operator param and RHS
% First creating 1D signal
ellip = ones(Non,1);
Elliptical = spdiags([ellip -2*ellip ellip],[-1 0 1],Non,Non); % 1D
Elliptical(1,2) = 2; Elliptical(Non,Non-1) = 2;

% Then finding kron for 2D dimensional
Ellip2 = kron(speye(Non),Elliptical) + kron(Elliptical,speye(Non));
Elliptical2 = -2*Ellip2 + lambda_val*speye(Non^2);

rhs = lambda_val*im0;


%% Directing to solving the eqn for comparison
udir = Elliptical2\rhs; % Direct solve with elimination

figure(1), clf
subplot(1,2,1)
% plot the image
pcolor(flipud(imact)), colormap gray, axis tight, shading interp
subplot(1,2,2)
% plot the noiseimage
pcolor(flipud(reshape(udir,Non,Non))), colormap gray, axis tight, shading interp


%% Gauss-Seidel usage for inversion of a lower-triangular matrix.
% contraint is matrix is big inversion is impossible. so using for loop

figure(2), clf
uimN = rhs;
for i = 1:maxiIt
    % Iterate starts
    uimO = uimN;
    for j = 1:Non^2
        E_dot = Elliptical2*uimN;
        uimN(j) = 1./Elliptical2(j,j)*(rhs(j) - E_dot(j) + Elliptical2(j,j)*uimN(j));
    end
    
    % GS iteration figure by figure plot
    if (mod(i,1) == 0) % Only occasionally plot
        pcolor(flipud(reshape(uimN,Non,Non))), axis tight, colormap gray, shading interp
        title(['GS iteration: ' num2str(i)]);
        drawnow
        pause(0.01)
    end
    
    % Checking for the convergence for every iteration
    if (norm(uimN-uimO,L) < toler)
        exitflag = 1;
        break;
    end
end

if (exitflag == 1)
    disp(['Gauss-Seidel converged in ' num2str(i) ' iterations.']);
else
    disp('Prob: GS did-not converge. USE increasing-max.iteration or atleast loosening tolerance.');
end


%% applying Conjugate Gradient now

[uConjGrad,exitflag,res,itOutp] = cgs(Elliptical2,rhs,toler,maxiIt,[],[],im0);

if (exitflag == 0)
    disp(['Conjugate Gradient converged in ' num2str(itOutp) ' iterations.']);
else
    disp('Prob: CG did not converge. Use increasing-max.iteration or atleaseloosening tolerance.');
end

figure(3), clf
temp = reshape(uConjGrad,Non,Non);
pcolor(flipud(reshape(uConjGrad,Non,Non))), axis tight, colormap gray, shading interp
title('Conjugate Gradient Solution');
