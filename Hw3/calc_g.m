function g = calc_g(I,sigma)
    I = BoundMirrorExpand(I);
    G = fspecial('gaussian', 15, sigma);
    X = conv2(I,G,'same');
    [Ix, Iy] = gradient(X);
    g = 1 ./ (1 + Ix.^2 + Iy.^2);
end

