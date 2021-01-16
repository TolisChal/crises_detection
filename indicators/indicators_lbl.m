function ind_lbl=indicators_lbl(indicators)
% function ind_lbl=indicators_lbl(indicators)
% 0: nothing
% 1: crisis (indicator>=1 for 100 days)
% 2: warning (indicator>=1 for 60 days)


count=0;
X=(indicators>=1)';

ind_lbl=zeros(size(indicators));

for i=1:size(X,2)
    if X(i) == 0
        % crisis
        if count>=100
            end_i=i;
            ind_lbl(start_i:end_i)=1;
        % warning
        elseif count>=60
            end_i=i;
            ind_lbl(start_i:end_i)=2;
        end
        count=0;
    else
        if count == 0
            start_i=i;
        end
        count=count+1;
    end
end
