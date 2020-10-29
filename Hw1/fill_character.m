function ret = fill_character(image)
    %% 取反
    anti_image = 1 - image;
    %% 边界
    [height,width] = size(anti_image);
    boundary = zeros(height,width);
    boundary(1,:) = anti_image(1,:);
    boundary(height,:) = anti_image(height,:);
    boundary(:,1) = anti_image(:,1);
    boundary(:,width) = anti_image(:,width);
    %% 膨胀模板，填补原background
    DilatedPattern(1:3,1:3) = 1;
    for i = 1 : 1000 %479
        temp = my_dilate(boundary,DilatedPattern,"conv");
        temp = logical(min(anti_image,temp));
        a = temp - boundary;
        s = sum(~~a(:));
        %i
        if s ~= 0
           boundary = temp;
        else
           break
        end
    end
    %% 背景填满，取反得前景
    ret = logical(1 - boundary);
    %imshow(ret);
    fig = figure;
    subplot(2,2,1);imshow(image);title("原始图片");
    subplot(2,2,2);imshow(anti_image);title("图片补集 ");
    subplot(2,2,3);imshow(boundary);title("图片标记");
    subplot(2,2,4);imshow(ret);title("孔洞填充结果");
%     frame = getframe(fig);
%     outPic = frame2im(frame);
%     imwrite(outPic,"pics/fill_character.png","png");
end