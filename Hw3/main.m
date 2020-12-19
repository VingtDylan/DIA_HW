clear;
close all;
clc;

%Img=imread('three.bmp');    
Img=imread('vessel.bmp');    
%Img=imread('twoCells.bmp');  
U = Img(:,:,1);

% get the size
[nrow, ncol] = size(U);

c0 = 3;
initialLSF = c0 * ones(size(U));
roi = 6;
initialLSF(roi : nrow - roi, roi : ncol - roi) = -c0;  
phi_0 = initialLSF;

delta_t = 5;
mu = 0.2 / delta_t; % 0.04
nu = 1.5; 
lambda = 5; 

I = double(U);
epsilon = 1.5; 
sigma = 1.5;
g = calc_g(I, sigma);
[gx, gy] = gradient(g);

phi = phi_0;
figure(1);
imagesc(uint8(I));colormap(gray)
hold on;
plotLevelSet(phi,0,'r');

numIter = 1;
for k = 1 : 100 
    phi = evolution_cv(I, phi, g, gx, gy, mu, nu, lambda, delta_t, epsilon, numIter);    % update level set function
    if mod(k,2)==0
        pause(.5);
        figure(1); clc; axis equal; 
        title(sprintf('Itertion times: %d', k));
        subplot(1,2,1); mesh(phi);
        subplot(1,2,2); imagesc(uint8(I));colormap(gray)
        hold on; plotLevelSet(phi,0,'r');
    end    
end
