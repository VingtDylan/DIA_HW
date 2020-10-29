close all;
clc;
clear;
%% 读取输入图片
image = imread("images/wood_dowels.tif");
[filter,g10,g20,g25,g30,out] = Granularity_detection(image);
%% 结果保存
imwrite(filter,"output/3_图像平滑.tif","tif");
imwrite(g10,"output/3_结构元半径为10.tif","tif");
imwrite(g20,"output/3_结构元半径为20.tif","tif");
imwrite(g25,"output/3_结构元半径为25.tif","tif");
imwrite(g30,"output/3_结构元半径为30.tif","tif");
%% 图片显示
figure
subplot(2,3,1); imshow(image);title("木钉图像");
subplot(2,3,2); imshow(filter);title("平滑后");
subplot(2,3,3); imshow(g10);title("结构元半径为10");
subplot(2,3,4); imshow(g20);title("结构元半径为20");
subplot(2,3,5); imshow(g25);title("结构元半径为25");
subplot(2,3,6); imshow(g30);title("结构元半径为30");
fig = figure;
plot((1:35),out);
xlabel('r');
ylabel('Differences in surface area');
axis on;
frame = getframe(fig);
outcurve = frame2im(frame);
imwrite(outcurve,"output/3_插值阵列曲线.tif","tif");