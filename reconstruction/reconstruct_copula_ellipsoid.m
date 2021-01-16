function [esti_cop, error] = reconstruct_copula_ellipsoid(copula, cells, Es)

cop_len = size(copula, 1);

copula(copula==0)=eps/1000000;
X = nonzeros(copula.*cells)';
count = 0;
esti_cop = zeros(cop_len);
for j=1:cop_len
    for k=1:cop_len
        count = count + 1;
        E = Es{count};
        esti_cop(j,k) = diag((X*E)*X');
    end
end

esti_cop(esti_cop<0)=eps/1000;
a = sum(esti_cop(cells==0)) / (1 - sum(copula(cells==1)));
esti_cop = esti_cop / a;
esti_cop(cells==1) = copula(cells==1);

%error = 0;
%return;
s1 = get_signature(copula);
s2 = get_signature(esti_cop);

[~, error] = emd(s1{1}, s2{1}, s1{2}, s2{2}, @gdf);

end