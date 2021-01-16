N = length(Copulas);
load('Copulas_uniform.mat')
load('train_indices.mat')
% equivalently to load('train_indices.mat')
%k=700;
%train_inds = randperm(N);
%trian_inds = train_inds(1:(N-k));

n=10; % use 10x10 copulas

cells = zeros(n,n);
cells((n+1-0.3*n):n, 1:(0.3*n)) = 1;
[errors_stats_3_1, k_copulas_pairs_3_1] = remove_k_and_evaluate(Copulas, train_inds, n, cells);
[errors_stats_ell_3_1, k_copulas_pairs_ell_3_1] = remove_k_and_evaluate_ellipsoid(Copulas, train_inds, n, cells);

cells = zeros(n,n);
cells((0.3*n+1):(n-0.3*n), (0.3*n+1):(n-0.3*n)) = 1;
[errors_stats_2_2, k_copulas_pairs_2_2] = remove_k_and_evaluate(Copulas, train_inds, n, cells);
[errors_stats_ell_2_2, k_copulas_pairs_ell_2_2] = remove_k_and_evaluate_ellipsoid(Copulas, train_inds, n, cells);

cells = zeros(n,n);
cells((0.3*n+1):(n-0.3*n), 1:(0.3*n)) = 1;
[errors_stats_2_1, k_copulas_pairs_2_1] = remove_k_and_evaluate(Copulas, train_inds, n, cells);
[errors_stats_ell_2_1, k_copulas_pairs_ell_2_1] = remove_k_and_evaluate_ellipsoid(Copulas, train_inds, n, cells);

cells = zeros(n,n);
cells((n+1-0.3*n):n, 1:(0.3*n)) = 1;
cells((n+1-0.3*n):n, (n+1-0.3*n):n) = 1;
[errors_stats_3_1_3_3, k_copulas_pairs_3_1_3_3] = remove_k_and_evaluate(Copulas, train_inds, n, cells);
[errors_stats_ell_3_1_3_3, k_copulas_pairs_ell_3_1_3_3] = remove_k_and_evaluate_ellipsoid(Copulas, train_inds, n, cells);

% create animations
pairs_animation(k_copulas_pairs_3_1, errors_stats_3_1, 'linear_3_1');
pairs_animation(k_copulas_pairs_ell_3_1, errors_stats_ell_3_1, 'ellipsoid_3_1');

pairs_animation(k_copulas_pairs_2_2, errors_stats_2_2, 'linear_2_2');
pairs_animation(k_copulas_pairs_ell_2_2, errors_stats_ell_2_2, 'ellipsoid_2_2');

pairs_animation(k_copulas_pairs_2_1, errors_stats_2_1, 'linear_2_1');
pairs_animation(k_copulas_pairs_ell_2_1, errors_stats_ell_2_1, 'ellipsoid_2_1');

pairs_animation(k_copulas_pairs_3_1_3_3, errors_stats_3_1_3_3, 'linear_3_1_3_3');
pairs_animation(k_copulas_pairs_ell_3_1_3_3, errors_stats_ell_3_1_3_3, 'ellipsoid_3_1_3_3');




