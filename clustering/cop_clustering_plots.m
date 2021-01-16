function cop_clustering_plots(I, C, midx, Copulas, Copulas_dates, indicators, ii, jj)


% Index of contious same values in array (for crisis and warnings events)
ind_same = @(x) [1; find(diff(x))+1; length(x)];

ind_lbl=indicators_lbl(indicators);
idx=ind_same(ind_lbl);


h1=figure('units','normalized','outerposition',[0 0 1 1]);
for i=1:size(C,1)
    subplot(ii,jj,i)
    hold on;
    
    
    % Plot with indicators through dates
    for j =1:size(idx,1)-1
        if ind_lbl(idx(j))==1
            %         1
            h2=fill([Copulas_dates(idx(j)) Copulas_dates(idx(j)) Copulas_dates(idx(j+1)-1) Copulas_dates(idx(j+1)-1)],[0 6 6 0],'r');
            set(h2,'facealpha',.5)
        elseif ind_lbl(idx(j))==2
            %         2
            h2=fill([Copulas_dates(idx(j)) Copulas_dates(idx(j)) Copulas_dates(idx(j+1)-1) Copulas_dates(idx(j+1))],[0 6 6 0],[0.9290, 0.6940, 0.1250]);
            set(h2,'facealpha',.5)
        end
    end
    ylim([0,6])
    set(gca,'XTickLabelRotation',45)
    datetick('x','yyyy')
    
    
    scatter(Copulas_dates(I~=i),indicators(I~=i),.8, [0, 0.4470, 0.7410])
    scatter(Copulas_dates(I==i),indicators(I==i),.8, [0.6350, 0.0780, 0.1840])
    ylim([0 6])
    xlim([min(Copulas_dates) max(Copulas_dates)])
end
saveas(h1,strcat('clusters_indi_C',num2str(length(midx)),'.jpg'));

h2=figure('units','normalized','outerposition',[0 0 1 1]);
for i=1:size(C,1)
    subplot(ii,jj,i)
    surf(Copulas{midx(i)})
    title(strcat('I = ', num2str(indicators(midx(i)))));
end
% saveas(h2,strcat('clusters_surf_C',num2str(length(midx)),'.jpg'));
saveas(h2,strcat('medoids_surf_C',num2str(length(midx)),'.jpg'));

h3=figure('units','normalized','outerposition',[0 0 1 1]);
for i=1:size(C,1)
    subplot(ii,jj,i)
    imagesc(log(Copulas{midx(i)}))
    title(strcat('I = ', num2str(indicators(midx(i)))));
end
saveas(h3,strcat('clusters_img_C',num2str(length(midx)),'.jpg'));
