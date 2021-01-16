function [Cops] = squeeze_copulas(Copulas, cop_len)

sq_len = 100 / cop_len;
n = length(Copulas);
cop = zeros(cop_len);
Cops = cell(1,n);

for i=1:n
    row = 0;
    copula = Copulas{i};
    for j=1:sq_len:100
        col = 0;
        row = row + 1;
        for k=1:sq_len:100
            col = col + 1;
            cop(row, col) = sum(sum(copula(j:(j+sq_len-1), k:(k+sq_len-1))));
        end
    end
    Cops{i} = cop;
end


end