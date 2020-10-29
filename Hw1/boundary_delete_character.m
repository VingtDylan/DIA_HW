function ret = boundary_delete_character(image)
    %% 边界
    [height,width] = size(image);
    boundary = zeros(height,width);
    boundary(1,:) = image(1,:);
    boundary(height,:) = image(height,:);
    boundary(:,1) = image(:,1);
    boundary(:,width) = image(:,width);
    %% 膨胀模板，边界扩张
    DilatedPattern(1:3,1:3) = 1;
    for i = 1 : 50 %21
        temp = my_dilate(boundary,DilatedPattern,"conv");
        temp = logical(min(image,temp));
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
    ret = logical(image - boundary);
    % imshow(ret);
%     fig = figure;
%     subplot(2,1,1);imshow(boundary);title("边界");
%     subplot(2,1,2);imshow(ret);title("边界清除");
%     frame = getframe(fig);
%     outPic = frame2im(frame);
%     imwrite(outPic,"pics/boundary_delete_character.png","png");
end