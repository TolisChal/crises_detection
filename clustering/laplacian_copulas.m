function [Q, D] = laplacian_copulas(A, cut_off_dis)

A(A > cut_off_dis) = 0;
DD = diag(sum(A));
L = DD-A;
[Q,D] = eig(L);

end