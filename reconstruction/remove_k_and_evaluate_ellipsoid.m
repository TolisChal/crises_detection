function [errors_stats, k_copulas_pairs] = remove_k_and_evaluate_ellipsoid(Copulas, train_inds, n, cells, clr)
% This function trains a quadratic model to predict the mass of a copula's
% quadrants given the mass of some cells

% Copulas is a Nx1 cell containg all the 100x100 copulas
% train_inds is a vector with the indices of te copulas to use for training
% n denotes the nxn size of the squeezed copulas
% cells is a nxn matrix with ones where the mass is known and zeros
% otherwise
% clr is a boolean variable to request clr transformation before
% computations

%compute train and evaluation indices
N = length(Copulas);
k = N - length(train_inds);
n_eval = k;
eval_inds = setdiff(1:N, train_inds);

% squeeze copulas, to nxn
copulas_n_n = squeeze_copulas(Copulas,n);

% apply clr transformation if requested
if nargin>4
    if (clr)
        for i=1:N
            cop = copulas_n_n{i};
            K = prod(cop(:))^(n*n);
            copulas_n_n{i} = log(cop/K);
        end
    end
end

%train the model
Es = train_reconstruction_model_ellipsoid(copulas_n_n, cells, 100/n, train_inds);

%initialize structures
k_copulas_pairs = cell(1,n_eval);
errors = zeros(n_eval, 2);

% initialize the uniform copula and its signature for EMD
cunif = ones(n,n)/n^2;
s2 = get_signature(cunif);
for i=1:n_eval
    cop = copulas_n_n{eval_inds(i)};
    %reconstruct copulas
    [esti_cop, error] = reconstruct_copula_ellipsoid(cop, cells, Es);
    errors(i,1) = error;
    
    %compute the ratio-error as the EMD between the uniform copula and the
    %ratio between approximate and initial copula
    c= esti_cop./cop;
    c= c/sum(sum(c)); 
    s1 = get_signature(c);
    [~, error] = emd(s2{1}, s2{1}, s1{2}, s2{2}, @gdf);
    errors(i,2) = error;
    
    %store the pairs of copulas
    k_copulas_pairs{i} = {cop, esti_cop};
end

% store some stats for te errors
errors_stats.errors = errors;
errors_stats.mean = mean(errors);
errors_stats.std = std(errors);
errors_stats.max = max(errors);
errors_stats.min = min(errors);
errors_stats.indicators = get_indicators_pairs(k_copulas_pairs);
errors_stats.errors(:,3) = 1:n_eval;

end