function [I,C,midx]=cop_kmedoids_clustering(Copulas, Copulas_dates, indicators, k)

[Copulas_feats, Copulas_sum_feats]=comp_indicators_feats(Copulas);

[I,C,~,~,midx]=kmedoids(Copulas_feats,k);

cop_clustering_plots(I, C, midx, Copulas, Copulas_dates, indicators);