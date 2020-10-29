function opened = my_open(image,R)
    %% 半径为R的圆盘模板B
    B = zeros(R,R);
    for k = -R:1:R
        for l = -R:1:R
            if(k^2 + l^2 <= R^2)
                B(l + R + 1,k + R + 1) = 1;
            end
        end
    end
    eroded = my_erode(image,B);   
    dilated = my_dilate(eroded,B,"brute");
    opened = dilated;
    %imshow(opened)
end