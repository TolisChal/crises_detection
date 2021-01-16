function cop_animation2(Copulas, Copulas_dates, indicators, video_fname, varargin)

% Copulas: a cell that contains the copulas
% Copulas_dates: avector of datetimes
% indicators: a vector with the indicators
% video_fname: a string that denotes the name of the video
% You can find data in this form in folder data

%Example: to create the animation of a cluster when the vector idx contains the indices run:
% cop_animation2(Copulas, Copulas_dates, indicators, 'cluster_animation', 'clusters_idx', idx)

checkDatetime = @(x) ischar(x)||isstring(x)||isdatetime(x);

p = inputParser;
% required, positional arguments
addRequired(p,'Copulas');
addRequired(p,'Copulas_dates');
addRequired(p,'indicators');
addRequired(p,'video_fname');

% % optional, positional arguments
% addOptional(p,'start_date', min(Copulas_dates), checkDatetime)
% addOptional(p,'end_date', max(Copulas_dates), checkDatetime)

% optional name-value pair arguments
addParameter(p,'start_date', min(Copulas_dates), checkDatetime)
addParameter(p,'end_date', max(Copulas_dates), checkDatetime)

addParameter(p,'smooth_copula',0)
addParameter(p,'smooth_sigma',2)

addParameter(p,'clusters_idx',[])

parse(p, Copulas, Copulas_dates, indicators, video_fname, varargin{:})

start_date=p.Results.start_date;
end_date=p.Results.end_date;

smooth_copula=p.Results.smooth_copula;
smooth_sigma=p.Results.smooth_sigma;

clusters_idx=p.Results.clusters_idx;
if size(clusters_idx,1)>1 && size(clusters_idx,2)==1
    clusters_idx=clusters_idx';
elseif size(clusters_idx,1)>1 && size(clusters_idx,2)>1
    error('Indices must be vectors.')
end
% if nargin<=5
%     start_date=min(Copulas_dates);
%     end_date=max(Copulas_dates);
% else
if (isstring(start_date) && isstring(end_date)) || (ischar(start_date) && ischar(end_date))
    start_date=datetime(start_date,'format','dd/MM/uuuu');
    end_date=datetime(end_date,'format','dd/MM/uuuu');
elseif not (isdatetime(start_date) && isdatetime(end_date))
    error('Could not recognize the date format of start_date or/and end_date. Accepted input for the dates is datetime class or string/char with format ''dd/MM/uuuu'' (e.g. 15/1/1990).')
end

if start_date>end_date
    error(('Start_date after end_date!'))
end
% end

if length(clusters_idx)>0
    cop_idx=find(Copulas_dates>=start_date & Copulas_dates<=end_date & clusters_idx>0);
%     cop_idx
else
    cop_idx=find(Copulas_dates>=start_date & Copulas_dates<=end_date);
end

% Index of contious same values in array (for crisis and warnings events)
ind_same = @(x) [1; find(diff(x))+1; length(x)];

ind_lbl=indicators_lbl(indicators);
idx=ind_same(ind_lbl);


% idxx = find(indicators<0.95 & indicators>0.8);
%h = figure;
h = figure('units', 'normalized','outerposition',[0 0 1 1]);
set(h, 'Visible', 'off');

% n=1;
%filename = 'testAnimated.gif';

writerObj = VideoWriter(video_fname);
writerObj.FrameRate = 10;

% Plot with indicators through dates
hh=subplot(2,1,2);
hold on
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
if length(clusters_idx)>0
    scatter(Copulas_dates(clusters_idx==0),indicators(clusters_idx==0),.8, [0, 0.4470, 0.7410])
    scatter(Copulas_dates(clusters_idx>0),indicators(clusters_idx>0),.8, [0.6350, 0.0780, 0.1840])
else
    scatter(Copulas_dates,indicators,2,(indicators));
end
h_cursor=scatter(Copulas_dates(1),indicators(1),500,'k.');
hh.Position = [0.075 0.1000 0.8250 0.3412/4.2];
colormap(flipud(jet))
c = colorbar;
set(gca,'XTickLabelRotation',45)
datetick('x','yyyy')

% open the video writer
open(writerObj);

% N = length(indicators);
for i = cop_idx

    if smooth_copula==0
        X=Copulas{i};
    else
        X=imgaussfilt(Copulas{i},smooth_sigma);
    end
    %     X=imgaussfilt(Copulas{i},2);
    
    %subplot(3,7,i-190)
    %imagesc(sqrt(Copulas{i}))
    h3 = subplot(2,1,1);
    surf(X)
    %zlim([0,0.008]);
    title(strcat(char(Copulas_dates(i)),', No = ', {' '}, num2str(i),', indicator = ', {' '}, num2str(indicators(i))))
    %title(strcat(char(Copulas_dates(i)),' I= ', num2str(indicators(i))))
    %drawnow
    %     h3_pos = h3.Position;
    h3.Position = [0.1700 0.5838/2.3 0.7750*0.8 0.3412*2.1];
    ax2 = axes('Position',[.7 .7 .25 .25]);
    box on;
    surf(X)
    alpha 0.4
    zlim([0,0.0065]);
    title(strcat('Z-limit =', {' '}, num2str(0.0065)))
    
    h_cursor.XData=Copulas_dates(i);
    h_cursor.YData=indicators(i);
    
    frame = getframe(h);
    writeVideo(writerObj, frame);
    %im = frame2im(frame);
    %[imind,cm] = rgb2ind(im,256);
    
    %if n == 1
    %    imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
    %    n=0;
    %else
    %    imwrite(imind,cm,filename,'gif','WriteMode','append');
    %end
    
end
close(writerObj);
