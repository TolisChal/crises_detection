function [small_indicatos] = get_small_indicators(small_copulas)

n = length(small_copulas);
small_indicatos = zeros(n,6);

for i = 1:n
    cop = small_copulas{i};
    small_indicatos(i, 1) = sum(sum(cop(1:20, 1:20))) / sum(sum(cop(1:20, 21:40)));
    small_indicatos(i, 2) = sum(sum(cop(1:20, 1:20))) / sum(sum(cop(21:40, 1:20)));
    small_indicatos(i, 3) = sum(sum(cop(1:20, 1:20))) / sum(sum(cop(21:40, 21:40)));
    small_indicatos(i, 4) = sum(sum(cop(1:20, 21:40))) / sum(sum(cop(21:40, 1:20)));
    small_indicatos(i, 5) = sum(sum(cop(1:20, 21:40))) / sum(sum(cop(21:40, 21:40)));
    small_indicatos(i, 6) = sum(sum(cop(21:40, 1:20))) / sum(sum(cop(21:40, 21:40)));
end


end