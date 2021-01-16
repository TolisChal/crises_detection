function [sgn] = get_signature(copula)

%copula = copula';
n = size(copula, 1);
step = min(1,n/10);
f = zeros((n/step)^2, 2);
w = zeros((n/step)^2, 1);
%w = copula(:);
row = 0;
for i=1:step:n
    for j=1:step:n
        row = row + 1;
        f(row,1) = (i+(i+step-1))/2;
        f(row,2) = (j+(j+step-1))/2;
        w(row,1) = sum(sum(copula(i:(i+step-1), j:(j+step-1))));
    end
end

sgn = {f, w};

end