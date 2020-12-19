function [c,h]=plotLevelSet(u,zLevel, style)
    [c,h] = contour(u,[zLevel zLevel],style);
end
