Crisis_dates=[];
Events_dates=[];
Copulas_dates=[];
indicators=[];

ind_same = @(x) [1; find(diff(x))+1; length(x)]; % index for same areas

load('~/Dropbox/journal_cop/data/financial_crises/crisis_dates.mat','Crisis_dates');
load('~/Dropbox/journal_cop/data/financial_crises/events_dates.mat', 'Events_dates');
% load('~/Dropbox/journal_cop/data/Copulas_uniform_dates.mat', 'Copulas_dates');
% load('~/Dropbox/journal_cop/data/Copulas_uniform_indicators.mat', 'indicators');


Crisis_dates=Crisis_dates(Crisis_dates(:,1)>=Copulas_dates(1) & Crisis_dates(:,1)<=Copulas_dates(end));
Events_dates=Events_dates(Events_dates(:,1)>=Copulas_dates(1) & Events_dates(:,1)<=Copulas_dates(end));

[crisis_count]=count_crisis_per_copula(Crisis_dates, Copulas_dates);
[events_count]=count_crisis_per_copula(Events_dates, Copulas_dates);

ind_lbl=indicators_lbl(indicators);
idx=ind_same(ind_lbl);


figure('units', 'normalized','outerposition',[0 0 1 1]);

ax1=subplot(3,1,1);
hold on;
for i =1:size(Crisis_dates,1)
    fill([Crisis_dates(i,1) Crisis_dates(i,1) Crisis_dates(i,1)+60 Crisis_dates(i,1)+60],[0 6 6 0],'r')
end

yyaxis 'left'
plot(Copulas_dates,indicators, 'color', [0, 0.4470, 0.7410])
ylim([0,6])
set(gca,'ycolor', [0, 0.4470, 0.7410])
ylbl=ylabel('Indicators');
ylbl.Rotation=0;
ylbl.Position(1)=-950;

yyaxis right
r_plot=plot(Copulas_dates,crisis_count, 'color', [0.4660, 0.6740, 0.1880], 'Linewidth', 2);
% r_plot.Color(4) = 0.9; % transparency
set(gca,'ycolor', [0.4660, 0.6740, 0.1880])
ylbl=ylabel({'Number of crises';'per Copula'});
ylbl.Rotation=0;
ylbl.Position(1)=10500;

datetick('x','yyyy')
set(gca,'XTickLabelRotation',45)
title('Systematic Crises (ECB FCDB 2017/07/31)')

ax2=subplot(3,1,2);
hold on;
for i =1:size(Events_dates,1)
    fill([Events_dates(i,1) Events_dates(i,1) Events_dates(i,1)+60 Events_dates(i,1)+60],[0 6 6 0],[0.9290, 0.6940, 0.1250])
end

yyaxis 'left'
plot(Copulas_dates,indicators, 'color', [0, 0.4470, 0.7410])
ylim([0,6])
set(gca,'ycolor', [0, 0.4470, 0.7410])
ylbl=ylabel('Indicators');
ylbl.Rotation=0;
ylbl.Position(1)=-950;

yyaxis right
r_plot=plot(Copulas_dates,events_count, 'color', [0.4660, 0.6740, 0.1880], 'Linewidth', 2);
% r_plot.Color(4) = 0.9; % transparency
set(gca,'ycolor', [0.4660, 0.6740, 0.1880])
ylbl=ylabel({'Number of events';'per Copula'});
ylbl.Rotation=0;
ylbl.Position(1)=10500;
datetick('x','yyyy')
set(gca,'XTickLabelRotation',45)
title('Residual Events (ECB FCDB 2017/07/31)')

ax=[subplot(3,1,3)];

hold on;
for i =1:size(idx,1)-1
    if ind_lbl(idx(i))==1
        %         1
        h=fill([Copulas_dates(idx(i)) Copulas_dates(idx(i)) Copulas_dates(idx(i+1)-1) Copulas_dates(idx(i+1)-1)],[0 6 6 0],'r');
        set(h,'facealpha',.5)
    elseif ind_lbl(idx(i))==2
        %         2
        h=fill([Copulas_dates(idx(i)) Copulas_dates(idx(i)) Copulas_dates(idx(i+1)-1) Copulas_dates(idx(i+1))],[0 6 6 0],[0.9290, 0.6940, 0.1250]);
        set(h,'facealpha',.5)
    end
end

scatter(Copulas_dates,indicators,2,(indicators))
colormap((jet))
c = colorbar;
c.Position(1)=0.915;
ylbl=ylabel('Indicators');
ylbl.Rotation=0;
ylbl.Position(1)=-950;

set(gca,'XTickLabelRotation',45)
datetick('x','yyyy')
ylim([0,6])
title('Copulas Indicators')

linkaxes(ax,'x')
datetick('x','yyyy')