function rmse = modelfunC(b,y, x)
r = (x-b(1)).^2 + (y-b(2)).^2 - b(3)^2;
rmse = sqrt(mean(r.^2));
end

