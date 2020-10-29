function gradiant = Gradiant(image,L)
    %% B
    k = 1:L;
    l = 1:L;
    B(k,l) = 1;
    %% 腐蚀 he 膨胀
    im_T = imdilate(image,B);
    im_F = imerode(image,B);
    %% 梯度
    gradiant = uint8(im_T - im_F);
end
