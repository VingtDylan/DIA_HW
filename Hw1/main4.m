close all;
clc;
clear;
%% 读取输入图片
image = imread("images/dark_blobs_on_light_background.tif");
closed = my_close(image,30);
opened = my_open(closed,60);
gradiant = Gradiant(opened,3);
mixed = uint8(255 * mat2gray(image + gradiant));
%% 结果保存
imwrite(closed,"output/4_大斑点图像.tif","tif");
imwrite(opened,"output/4_区域边界.tif","tif");
imwrite(mixed,"output/4_边界叠加到原图像.tif","tif");
%% 图片显示
% figure
subplot(2,2,1); imshow(image); title('图像');
subplot(2,2,2); imshow(closed); title('大斑点图像'); 
subplot(2,2,3); imshow(opened); title('区域边界'); 
subplot(2,2,4); imshow(mixed); title('边界叠加到原图像'); 