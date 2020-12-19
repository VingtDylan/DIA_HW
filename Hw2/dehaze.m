function [RGB,darkChannel,t,J] = dehaze(RGB,t0,w)
    %% 读取图片并分离channel
    RGBD = double(RGB);
    R = RGBD(:, :, 1);
    G = RGBD(:, :, 2);
    B = RGBD(:, :, 3);
    %% 求解暗通道
    minChannel = min(min(R,G),B);
    kernel = ones(15);
    darkChannel = imerode(minChannel, kernel);
    darkChannel = uint8(darkChannel);
    %% 求解大气光
    [t, ~] = sort(darkChannel(:), 'descend');
    p = 0.001;
    n = floor(length(t) * p);
    A = zeros(1,3);   
    dark_bright = darkChannel>=t(n);
    for i = 1:3
        pic = RGBD(:,:,i);
        A(i) = max(pic(dark_bright));
    end
    % A
    %% t(x)
    tR = double(R)./double(A(1));
    tG = double(G)./double(A(2));
    tB = double(B)./double(A(3));
    t_hat = min(min(tR,tG),tB);
    t = 1 - w * t_hat;
    t = max(t,t0);          
    %% guide filter
    t = guidedfilter(RGBD,t,5,0.0001);
    %% dehaze
    J(:,:,1) = (R - A(1))./t + A(1);
    J(:,:,2) = (G - A(2))./t + A(2);
    J(:,:,3) = (B - A(3))./t + A(3);
    J = uint8(J);
end