function [Z] = myProcrustes(X,Y)
%MYPROCRUSTES Function that stretches or contracts the input points set to fit the reference points set.
%   Input
%       X - Input points set 
%       Y - Reference soints set
%
%   Output
%       Z - Fitted points set

%% Function starts here

figure,
subplot(2,2,1), plot(X(:,1),X(:,2),'ks',Y(:,1),Y(:,2),'r*'), title('Original Points Set');

%% Translation (to fix the centre of both points set at the origin)
x = X - mean(X,1);
y = Y - mean(Y,1); 

subplot(2,2,2), plot(x(:,1),x(:,2),'ks',y(:,1),y(:,2),'r*'), title('Translated Points Set');

%% Scaling (to stretch the points set to the same scale)
sx = sum(x.^2,1);
sy = sum(y.^2,1);
sx=sum(sx);
sy=sum(sy);

normX = sqrt(sx);
normY = sqrt(sy);

% Scale to equal (unit) norm
x = x / normX;
y = y / normY;

subplot(2,2,3), plot(x(:,1),x(:,2),'ks',y(:,1),y(:,2),'r*'), title('Scaled Points Set');

%% Rotate (to impose input points set on reference)
Scaled = x * transpose(y);
[U, ~, V] = svd(Scaled);
R = V * transpose(U);

Z = R * x;

subplot(2,2,4), plot(y(:,1),y(:,2),'ks',Z(:,1),Z(:,2),'r*'),title('Rotated Points Set');

end