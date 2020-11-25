function out = boxfilter(img, r)
    [height, width] = size(img);
    out = zeros(size(img));
    cum = cumsum(img, 1);
    out(1 : r + 1, :) = cum(1 + r : 2 * r + 1, :);
    out(r + 2 : height - r, :) = cum(2 * r + 2 : height, :) - cum(1 : height - 2 * r - 1, :);
    out(height - r + 1 : height, :) = repmat(cum(height, :), [r, 1]) - cum(height - 2 * r : height - r - 1, :);

    cum = cumsum(out, 2);
    out(:, 1 : r + 1) = cum(:, 1 + r : 2 * r + 1);
    out(:, r + 2 : width - r) = cum(:, 2 * r + 2 : width) - cum(:, 1 : width - 2 * r - 1);
    out(:, width - r + 1 : width) = repmat(cum(:, width), [1, r]) - cum(:, width - 2 * r : width - r - 1);
end