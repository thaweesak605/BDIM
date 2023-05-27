clc
clearvars
close all
img = imread('/Users/thaweesaktrongtirakul/Library/CloudStorage/OneDrive-RajamangalaUniversityofTechnologyPhranakhon/AGAIAN/SPIE2023/Images/Input/019.png');
img = rgb2gray(img);
%% Equalization
[x,y,z] = size(img);
img     = reshape(img,x,y*z);
BHE     = histeq(img);
CLAHE   = adapthisteq(img);
%% Calculation of BDIM-Based Weights
kernel    = 3;
Condition = 0;
[w,~]          = Weighting_Map();
WDIMTE_BHE     = filter2(w, BHE);
WDIMTE_BHE     = NormalRange(WDIMTE_BHE,0,255,1);
WDIMTE_CLAHE   = filter2(w, CLAHE);
WDIMTE_CLAHE   = NormalRange(WDIMTE_CLAHE,0,255,1);
[BDIM_BHE,~]   = Thermal_DIMTE(WDIMTE_BHE,kernel,Condition);
[BDIM_CLAHE,~] = Thermal_DIMTE(WDIMTE_CLAHE,kernel,Condition);
Adapt_Weights  = BDIM_BHE + BDIM_CLAHE;
W1             = BDIM_BHE ./ Adapt_Weights;
W2             = BDIM_CLAHE ./ Adapt_Weights;
%% Reshape
BHE     = reshape(BHE,x,y,z);
CLAHE   = reshape(CLAHE,x,y,z);
W1      = reshape(W1,x,y,z);
W2      = reshape(W2,x,y,z);
%% Adaptive Image Fusion
Fused          = uint8(W1 .* double(BHE) + W2 .* double(CLAHE));
%% Recoloring
[Recolored_img]    = Colormap(img,0);
[Recolored_BHE]    = Colormap(BHE,0);
[Recolored_CLAHE]  = Colormap(CLAHE,0);
[Recolored_Fused]  = Colormap(Fused,0);
%% Display images
figure;
subplot(2,2,1); imshow(img);    title('Input');
subplot(2,2,2); imshow(Fused);  title('Fused');
subplot(2,2,3); imshow(BHE);    title('Enhanced 1');
subplot(2,2,4); imshow(CLAHE);  title('Enhanced 2');
figure;
subplot(2,2,1); imshow(Recolored_img);    title('Input');
subplot(2,2,2); imshow(Recolored_Fused);  title('Fused');
subplot(2,2,3); imshow(Recolored_BHE);    title('Enhanced 1');
subplot(2,2,4); imshow(Recolored_CLAHE);  title('Enhanced 2');