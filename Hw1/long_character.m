function ret = long_character(image)
    %% 长字符腐蚀模板E 0.6 - 0.7
    Erodelength = 1:51; ErodePattern(Erodelength,1) = 1;
    %% 模板E 腐蚀找到长字符的位置
    Eroded = my_erode(image,ErodePattern);
    % subplot(2,1,1);imshow(Eroded);
    % Eroded1 = imerode(image,ErodePattern);
    % a = Eroded - Eroded1;
    % s = sum(~~a(:))
    % subplot(2,1,2);imshow(Eroded1);
    %% 模板E 膨胀
    Dilated = my_dilate(Eroded,ErodePattern,"conv");
    % subplot(2,1,1);imshow(Dilated);
    % Dilated1 = imdilate(Eroded,ErodePattern);
    % a = Dilated - Dilated1;
    % s = sum(~~a(:))
    % subplot(2,1,2);imshow(Dilated1);
    %% 再次膨胀多次查找字符
    ret = logical(min(image,Dilated));
    DilatedPattern(1:51,1:9) = 1;
    for i = 1 : 100 % 20
        temp = my_dilate(ret,DilatedPattern,"conv");
        temp = logical(min(image,temp));
        a = temp - ret;
        s = sum(~~a(:));
        %i
        if s ~= 0
            ret = temp;
        else
            break
        end
    end
    % imshow(ret1);
%     fig = figure;
%     subplot(2,2,1);imshow(image);title("原始图片");
%     subplot(2,2,2);imshow(Eroded);title("腐蚀操作 ");
%     subplot(2,2,3);imshow(Dilated);title("膨胀操作");
%     subplot(2,2,4);imshow(ret);title("重建开的最终结果");
%     frame = getframe(fig);
%     outPic = frame2im(frame);
%     imwrite(outPic,"pics/long_character.png","png");
end