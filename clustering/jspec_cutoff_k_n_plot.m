[Q, DD] = laplacian_copulas(D, 10);

[idx, C, midx] = kmed_copulas(Q, 2, 100);
cop_clustering_plots(idx, C, midx, Copulas, Copulas_dates, indicators, 2, 2)

[idx, C, midx] = kmed_copulas(Q, 3, 100);
cop_clustering_plots(idx, C, midx, Copulas, Copulas_dates, indicators, 2, 2)

[idx, C, midx] = kmed_copulas(Q, 4, 100);
cop_clustering_plots(idx, C, midx, Copulas, Copulas_dates, indicators, 2, 2)

[idx, C, midx] = kmed_copulas(Q, 5, 100);
cop_clustering_plots(idx, C, midx, Copulas, Copulas_dates, indicators, 3, 3)

[idx, C, midx] = kmed_copulas(Q, 6, 100);
cop_clustering_plots(idx, C, midx, Copulas, Copulas_dates, indicators, 3, 3)

[idx, C, midx] = kmed_copulas(Q, 7, 100);
cop_clustering_plots(idx, C, midx, Copulas, Copulas_dates, indicators, 3, 3)

[idx, C, midx] = kmed_copulas(Q, 8, 100);
cop_clustering_plots(idx, C, midx, Copulas, Copulas_dates, indicators, 3, 3)

[idx, C, midx] = kmed_copulas(Q, 9, 100);
cop_clustering_plots(idx, C, midx, Copulas, Copulas_dates, indicators, 3, 3)

[idx, C, midx] = kmed_copulas(Q, 10, 100);
cop_clustering_plots(idx, C, midx, Copulas, Copulas_dates, indicators, 4, 3)

[idx, C, midx] = kmed_copulas(Q, 11, 100);
cop_clustering_plots(idx, C, midx, Copulas, Copulas_dates, indicators, 4, 3)

[idx, C, midx] = kmed_copulas(Q, 12, 100);
cop_clustering_plots(idx, C, midx, Copulas, Copulas_dates, indicators, 4, 4)

 [idx, C, midx] = kmed_copulas(Q, 13, 100);
cop_clustering_plots(idx, C, midx, Copulas, Copulas_dates, indicators, 4, 4)

[idx, C, midx] = kmed_copulas(Q, 14, 100);
cop_clustering_plots(idx, C, midx, Copulas, Copulas_dates, indicators, 4, 4)

[idx, C, midx] = kmed_copulas(Q, 15, 100);
cop_clustering_plots(idx, C, midx, Copulas, Copulas_dates, indicators, 4, 4)

[idx, C, midx] = kmed_copulas(Q, 16, 100);
cop_clustering_plots(idx, C, midx, Copulas, Copulas_dates, indicators, 4, 4)
