function pairs_animation(copula_pairs, error_stats, name)

% This function 

writerObj = VideoWriter(strcat(name, '.avi'));
writerObj.FrameRate = 4;

n = length(copula_pairs);
open(writerObj);
h = figure('units', 'normalized','outerposition',[0 0 1 1]);
set(h, 'Visible', 'off');
for i=1:n
    
    p = copula_pairs{i};
    subplot(1,2,1);
    surf(p{1});
    title(strcat('I = ', num2str(error_stats.indicators(i,1))))
    subplot(1,2,2)
    surf(p{2});
    title(strcat('I = ', num2str(error_stats.indicators(i,2)), ' -- [reconstructed copula]'))
    suptitle(strcat('i = ',num2str(i),', EMD-error = ', num2str(error_stats.errors(i,1)),', Ratio-error = ',num2str(error_stats.errors(i,2))))
    frame = getframe(h);
    writeVideo(writerObj, frame);
end

close(writerObj);

end