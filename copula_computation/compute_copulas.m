function [copulas] = compute_copulas(returns, m, W, N)

    % Generate random Ptf
    if (nargin == 2)
        W = 60;
        N = 500000;
    end
    if (nargin == 3)
        N = 500000;
    end
    copulas = cell(1);
    
    [nrows, nassets] = size(returns);
    RndPtf = Sampling(nassets, N, 'RM');
    wl = W-1;
    
    for i=1:(nrows-wl)
        
        Win=i:(i+wl);
        [E, ~] = covCor(returns(Win,:));
        compRet = prod(1+returns(Win,:))-1;

        RndPtfRet_P1 = compRet * RndPtf;
        Ex = E * RndPtf;
    
        RndPtfVol = zeros(N, 1);
        for j=1:N
            RndPtfVol(j) = RndPtf(:, j)' * Ex(:, j);
        end

        [~, I1] = sort(RndPtfRet_P1,'ascend');
        [~, I2] = sort(RndPtfVol,'ascend');

        for j=1:m
            range = ((j-1)*floor(N/m)+1:j*floor(N/m));
            ScoreP1(I1(range))=j;
            Volatility(I2(range))=j;
        end

        Copula = zeros(m, m);
        for k=1:m
            for j=1:m
                Copula(k,j) = sum((ScoreP1==k).*(Volatility==j));
            end
        end
        sum(sum(Copula))
        Copula=Copula/N;
        copulas{i} = Copula;
    end
end

