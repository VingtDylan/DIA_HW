function Delta_h = Delta(phi, epsilon)
    Delta_h = (1 / (2 * epsilon)) * (1 + cos(pi * phi / epsilon));
    b = (phi <= epsilon) & (phi >= -epsilon);
    Delta_h = Delta_h .* b;
end