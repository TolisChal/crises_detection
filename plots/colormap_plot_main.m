load Copulas_DJ600_19Ass_60D_Sobol_10M.mat
% load Dates_DJ600.mat
% load Signatures.mat
load Distance_matrix.mat

% compute_all_indi;
indicators = comp_indicators_mask(Copulas);

D(D>10)=10; %15;

create_Laplacian;

scatter3(X2(:,2),X2(:,3),X2(:,4),0.8,log(indicators))
colormap(flipud(hot))
c = colorbar;
c.Label.String = 'log(Indicator)';

