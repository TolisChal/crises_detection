ind_same = @(x) [1; find(diff(x))+1; length(x)];
ind_lbl=indicators_lbl(indicators);
idx=ind_same(ind_lbl);


idxx = find(indicators<0.95 & indicators>0.8);
%h = figure;
h = figure('units', 'normalized','outerposition',[0 0 1 1]);
set(h, 'Visible', 'off');

n=1;

%filename = 'testAnimated.gif';
writerObj = VideoWriter('copulas-zlim-0_8-0_95-video.avi');
writerObj.FrameRate = 10;
% set the seconds per image
% open the video writer
open(writerObj);
N = length(indicators);
for i = idxx'
    
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
    scatter(Copulas_dates,indicators,2,(indicators))
    
    colormap(flipud(jet))
    c = colorbar;
    set(gca,'XTickLabelRotation',45)
    datetick('x','yyyy')
    
    scatter(Copulas_dates(i),indicators(i),45,'k*')
    hh.Position = [0.05000 0.1000 0.8250 0.3412/4.2];
    
    %subplot(3,7,i-190)
    %imagesc(sqrt(Copulas{i}))
    h3 = subplot(2,1,1);
    surf(Copulas{i})
    zlim([0,0.008]);
    title(strcat(char(Copulas_dates(i)),', No = ',num2str(i),', indicator = ', num2str(indicators(i))))
    %title(strcat(char(Copulas_dates(i)),' I= ', num2str(indicators(i))))
    %drawnow
%     h3_pos = h3.Position;
    h3.Position = [0.1700 0.5838/2.3 0.7750*0.8 0.3412*2.1];
%     h3.Position(3)=h3.Position(3)*0.8;
%     h3.Position(4)=h3.Position(4)*2.1;
    
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