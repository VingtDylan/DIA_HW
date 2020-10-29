function dilated = my_dilate(image,B,str)
    %% 卷积
    if str == "conv"
        dilated = logical(conv2(image,B,'same'));
    %% 暴力搜索
    elseif str == "brute"
        [height,width] = size(image);
        [pheight,pwidth] = size(B);
        half_pheight = floor((pheight+1)/2);
        half_pwidth = floor((pwidth+1)/2);
        dilated = zeros(height,width);
        image = double(image);
        for i = 1 : height 
            for j = 1 : width 
                xl = max(1,i - half_pheight + 1);
                xr = min(i + half_pheight - 1,height);
                yl = max(1,j - half_pwidth + 1);
                yr = min(j + half_pwidth - 1,width);
                xl2 = xl - i + half_pheight;
                xr2 = xr - i + half_pheight;
                yl2 = yl - j + half_pwidth;
                yr2 = yr - j + half_pwidth;
                sub_image = image(xl:xr,yl:yr) .* B(xl2:xr2,yl2:yr2);
                dilated(i,j) = max(max(sub_image));
            end
        end
        dilated = uint8(dilated);
    end
end