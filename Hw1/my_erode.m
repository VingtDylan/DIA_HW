function eroded = my_erode(image,B)
     % image = 255 - image;
     % eroded = 255 - my_dilate(image,B,"brute");
    [height,width] = size(image);
    [pheight,pwidth] = size(B);
    half_pheight = floor((pheight + 1)/2);
    half_pwidth = floor((pwidth + 1)/2);
    eroded = double(image);
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
            ss = sum(sum(B(xl2:xr2,yl2:yr2)));
            sub_image = zeros(1,ss);
            index = 1;
            for k = xl2 : 1: xr2
                for l = yl2: 1 : yr2
                    if B(k,l) > 0
                        sub_image(index) = image(k + i - half_pheight,l + j - half_pwidth);
                        index = index + 1;
                    end
                end
            end
            %sub_image = image(xl:xr,yl:yr) .* B(xl2:xr2,yl2:yr2);
            eroded(i,j) = min(sub_image(:));
        end
    end
    eroded = uint8(eroded);
    % eroded = logical(eroded);
end