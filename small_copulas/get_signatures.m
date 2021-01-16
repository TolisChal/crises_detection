step = 20;
fi = zeros((40/step)^2,2);
wi = zeros((40/step)^2,1);
Signatures = cell(6968,1);
for i=1:6968
    
   cop = small_copulas{i};
   row = 1;
   for j=1:step:40
       for k=1:step:40
           fi(row,:) = [sum(j:(j+step-1))/20 sum(k:(k+step-1))/20];
           wi(row,1) = sum(sum(cop(j:(j+step-1), k:(k+step-1))));
           row = row + 1;
       end
   end
   Signatures{i} = {fi, wi};
    
end