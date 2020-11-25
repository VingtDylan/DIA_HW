clear;close all;clc;

[f,p] = uigetfile({'*.jpg'},'Open');
if f
    I = imread([p f]); 
end
%% 参数设置
t0 = 0.1;w = 0.85;
%% 调用去雾函数
[I,darkChannel,t,J]  = dehaze(I,t0,w);
%% 计算结果显示
figure; 
subplot(2,2,1);imshow(I);title('原图像'); 
subplot(2,2,2);imshow(darkChannel);title('暗通道'); 
subplot(2,2,3);imshow(t);title('透射率图'); 
subplot(2,2,4);imshow(J);title('目标图');
%% 目标图保存
imwrite(J,"output/de" + f);