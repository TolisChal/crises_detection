n=length(Copulas);
step = 20;
fi = zeros((100/step)^2,2);
wi = zeros((100/step)^2,1);
Signatures = cell(n,1);
for i=1:n
    
   cop = Copulas{i};
   row = 1;
   for j=1:step:100
       for k=1:step:100
           fi(row,:) = [sum(j:(j+step-1))/20 sum(k:(k+step-1))/20];
           wi(row,1) = sum(sum(cop(j:(j+step-1), k:(k+step-1))));
           row = row + 1;
       end
   end
   Signatures{i} = {fi, wi};
    
end
save('Signatures.mat','Signatures')
