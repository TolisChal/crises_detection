function copulas_video_clusters(idxx, Ci, Copulas, Copulas_dates, indicators)
% date1: starting date. Class: datetime
% date2: end date. Class: datetime
% Copulas: a cell that contains all the copulas
% Copulas_dates: a vector of datetimes that contains the starting date of
%                the sliding window for each copula
% indicators: a vector that contains the diagonal indicators

% Example: copulas_video_dates(datetime(1990,10,18), datetime(1991,1,21), Copulas, Copulas_dates, indicators)

ind_same = @(x) [1; find(diff(x))+1; length(x)];
ind_lbl=indicators_lbl(indicators);
idx=ind_same(ind_lbl);

h = figure('units', 'normalized','outerposition',[0 0 1 1]);
set(h, 'Visible', 'off');

n=1;


writerObj = VideoWriter('copulas-video.avi');
writerObj.FrameRate = 10;
% set the seconds per image
% open the video writer
open(writerObj);


for i = idxx
    
    hh=subplot(2,1,2);
    hold on
    for j =1:size(idx,1)-1
        if ind_lbl(idx(j))==1
            h2=fill([Copulas_dates(idx(j)) Copulas_dates(idx(j)) Copulas_dates(idx(j+1)-1) Copulas_dates(idx(j+1)-1)],[0 6 6 0],'r');
            set(h2,'facealpha',.5)
        elseif ind_lbl(idx(j))==2
            h2=fill([Copulas_dates(idx(j)) Copulas_dates(idx(j)) Copulas_dates(idx(j+1)-1) Copulas_dates(idx(j+1))],[0 6 6 0],[0.9290, 0.6940, 0.1250]);
            set(h2,'facealpha',.5)
        end
    end
    ylim([0,6])
    scatter(Copulas_dates,indicators,2,(indicators))
    
    colormap(flipud(jet))
    c = colorbar;
    set(gca,'XTickLabelRotation',45)
    datetick('x','yyyy')
    
    scatter(Copulas_dates(i),indicators(i),500,'k.')
    hh.Position = [0.075 0.1000 0.8250 0.3412/4.2];
    
    h3 = subplot(2,1,1);
    surf(Copulas{i})
    title(strcat(char(Copulas_dates(i)),', No = ', {' '}, num2str(i),', indicator = ', {' '}, num2str(indicators(i))))
    h3.Position = [0.1700 0.5838/2.3 0.7750*0.8 0.3412*2.1];
    ax2 = axes('Position',[.7 .7 .25 .25]);
    box on;
    surf(Copulas{Ci})
    alpha 0.4
    zlim([0,0.0065]);
    title(strcat('Z-limit =', {' '}, num2str(0.0065)))
    
    frame = getframe(h);
    writeVideo(writerObj, frame);
    
end
close(writerObj);
end