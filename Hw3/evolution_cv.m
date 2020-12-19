function phi = evolution_cv(I, phi0, g, gx, gy, mu, nu, lambda, delta_t, epsilon, numIter)
    I = BoundMirrorExpand(I); % ¾µÏñ±ßÔµÑÓÍØ
    phi = BoundMirrorExpand(phi0);
    [phix, phiy] = gradient(phi);
    phixy = sqrt(phix.^2 + phiy.^2 + 1e-10);
    phix = phix ./ phixy;
    phiy = phiy ./ phixy;

    for k = 1 : numIter
        phi = BoundMirrorEnsure(phi);
        delta_h = Delta(phi,epsilon);
        Curv = curvature(phi);

        % updating the phi function
        distRictTerm = mu * (4 * del2(phi) - Curv);
        lengthTrem = lambda * delta_h .* (phix .* gx + phiy .* gy + g .* Curv);
        areaTerm = nu * g .* delta_h;
        new_term = distRictTerm + lengthTrem + areaTerm;
        phi = phi + delta_t * new_term;
    end
    phi = BoundMirrorShrink(phi); % È¥µôÑÓÍØµÄ±ßÔµ
end

