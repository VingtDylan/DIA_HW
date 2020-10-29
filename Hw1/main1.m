close all;
clc;
clear;
%% 读取输入图片 uint8存储 
image = imread("images/text_image.tif");
%% 长字符提取
ret1 = long_character(image);
%% 孔洞填充
ret2 = fill_character(image);
%% 边界清除
ret3 = boundary_delete_character(image);
%% 结果保存
imwrite(ret1,"output/1_长字符提取.tif","tif");
imwrite(ret2,"output/1_孔洞填充.tif","tif");
imwrite(ret3,"output/1_边界清除.tif","tif");
% 图片显示
figure
subplot(2,2,1); imshow(image);title("原始图片");
subplot(2,2,2); imshow(ret1);title("长字符提取");
subplot(2,2,3); imshow(ret2);title("孔洞填充");
subplot(2,2,4); imshow(ret3);title("边界清除");