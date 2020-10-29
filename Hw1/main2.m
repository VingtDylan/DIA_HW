close all;
clc;
clear;
%% 读取输入图片
image = imread("images/rice_image_with_intensity_gradient.tif");
[image2bw,dilated,imagef,image2bwf] = T_hat(image);
%% 结果保存
imwrite(image2bw,"output/2_第一次阈值处理.tif","tif");
imwrite(dilated,"output/2_开操作后.tif","tif");
imwrite(imagef,"output/2_顶帽变换.tif","tif");
imwrite(image2bwf,"output/2_顶帽变换后的阈值处理.tif","tif");
%% 图片显示
figure
subplot(2,2,1); imshow(image2bw);title("第一次阈值处理");
subplot(2,2,2); imshow(dilated);title("开操作后");
subplot(2,2,3); imshow(imagef);title("顶帽变换");
subplot(2,2,4); imshow(image2bwf);title("顶帽变换后的阈值处理");