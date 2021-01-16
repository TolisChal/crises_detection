function Y = CLR(X)
    n = length(X);
    K = (prod(X))^(1/n);
    Y = log(X/K);
end

