clear;
close all;
clc;

[f,p] = uigetfile({'*.bmp'},'Open');
if f
    Img = imread([p f]); 
end

% Img=imread('three.bmp');    
% Img=imread('vessel.bmp');    
% Img=imread('twoCells.bmp');  
U = Img(:,:,1);

[phi_0, kk] = initial(f,U);

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
for k = 1 : kk 
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
