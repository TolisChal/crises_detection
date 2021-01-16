function[Betas, Bias] = train_reconstruction_model(Copulas, cells, grid_len, inds)

n = length(inds);
Cops = cell(n,1);
cop_len = 100 / grid_len;
Ys = zeros(n,1);
Xs = zeros(length(nonzeros(cells)),n);
for i = 1:n
    Cops{i} = Copulas{inds(i)};
    cop = Cops{i};
    cop(cop==0)=eps/1000000;
    Xs(:,i) = nonzeros(cop.*cells);
end

count = 0;
for j=1:cop_len
    for k=1:cop_len
        %if (~ismember(k,[1,11,21]) || ~ismember(j,[1,11,21]))
        count = count +1
        for i=1:n
            cop = Cops{i};
            Ys(i) = sum(sum(cop(j, k)));
        end
        Mdl = fitrlinear(Xs',Ys);
        Betas(:,count) = Mdl.Beta;
        Bias(count) = Mdl.Bias;
        %end
    end
end
Bias = Bias';

end
