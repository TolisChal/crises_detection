function [small_copulas] = create_small_copulas(Copulas)

n = length(Copulas);
small_copulas = cell(n,1);

scopula = zeros(40,40);

for i=1:n
    cop = Copulas{i};
    scopula = cop([1:20, 81:100], [1:20, 81:100]);
    scopula = scopula / sum(sum(scopula));
    small_copulas{i} = scopula;
end


end