function closed = my_close(image,R)
    %% 半径为R的圆盘模板B
    B = zeros(R,R);
    for k = -R:1:R
        for l = -R:1:R
            if(k^2 + l^2 <= R^2)
                B(l + R + 1,k + R + 1) = 1;
            end
        end
    end
    dilated = my_dilate(image,B,"brute");
    eroded = my_erode(dilated,B);
    closed = eroded;
    % imshow(closed)
end