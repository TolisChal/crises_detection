function[Es] = train_reconstruction_model_ellipsoid(Copulas, cells, grid_len, inds)

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
        %if (~ismember(k,1:3) || ~ismember(j,8:10))
        count = count +1
        for i=1:n
            cop = Cops{i};
            Ys(i) = sum(sum(cop(j, k)));
        end
        fun = @(r)(myfun(r));
        E0 = randn(size(Xs,1)); E0 = E0*E0'; E0 = (E0+E0')/2;
        %E0(size(E0,1)+1, :) = randn(1,size(Xs,1));
        %[F,J] =myfun(E0)
        E = lsqnonlin(fun,E0);
        Es{count} = E;
        %end
    end
end

    function [F] = myfun(E)
        
        Q = Xs'*E;
        F=zeros(size(Xs,2),1) - Ys;
        for ii=1:size(Xs,2)
            F(ii) = F(ii) + Q(ii,:)*Xs(:,ii);
        end
        %if nargout > 1   % Two output arguments
        %    J = 2*Xs'*E;   % Jacobian of the function evaluated at x
        %end
    end

end


