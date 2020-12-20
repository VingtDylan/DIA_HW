function [phi_0, kk] = initial(f,U)
	[nrow, ncol] = size(U);
    if f(1) == 'v'
        c0 = 3;
        initialLSF = -c0 * ones(size(U));
        initialLSF([1:15, nrow - 15 : nrow], 30 : ncol - 30) = c0;
        initialLSF(15:nrow - 15, [1:5, ncol - 5:ncol]) = c0;  
        phi_0 = initialLSF;
        kk = 300;
    else
        c0 = 3;
        initialLSF = c0 * ones(size(U));
        roi = 6;
        initialLSF(roi : nrow - roi, roi : ncol - roi) = -c0;  
        phi_0 = initialLSF; 
        kk = 160;
    end
end