N = size(cops,1);

for i=1:100:(N)
    
    Copulas{length(Copulas) + 1} = cops(i:(i+99),:);
    
end