function [image2bw,dilated,imagef,image2bwf] = T_hat(image)
   %% ret 1 
   % otsu 0.5255
   threshold = graythresh(image);
   image2bw = im2bw(image,threshold);
   %% ret 2
    se = zeros(81,81);
    for i = -40:1:40
        for j = -40:1:40
            if(i^2 + j^2 <= 1600)
                se(i+41,j+41) = 1;
            else
                se(i+41,j+41) = 0;
            end
        end
    end
    eroded = my_erode(image,se);  
    dilated = my_dilate(eroded,se,"brute");
    % imshow(uint8(dilated));
    %% ret 3
    imagef = image - dilated;
    imagef = uint8(255 * mat2gray(imagef));
    %% ret 4
    % otsu 0.3922
    thresholdf = graythresh(imagef);
    image2bwf = im2bw(imagef,thresholdf);
    % imshow(image2bwf)
%     fig1 = figure(1);
%     subplot(1,2,1);imshow(image);title("原始图像");
%     subplot(1,2,2);imshow(image2bw);title("对原始图像进行阈值处理");
%     fig2 = figure(2);
%     subplot(1,3,1);imshow(dilated);title("开操作");
%     subplot(1,3,2);imshow(imagef);title("顶帽变换");
%     subplot(1,3,3);imshow(image2bwf);title("顶帽变换后的阈值处理");
end