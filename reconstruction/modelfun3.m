function rmse = modelfun(b,y, x)
y_fit = b(1) + b(2)*x + b(3)*x.^2 + b(4)*x.^3;
r = y - y_fit;
rmse = sqrt(mean(r.^2));
end

