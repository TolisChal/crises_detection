clear all; close all; clc;
load Dates;
load('Copulas_3x3.mat');

% Split the copulas in 6 proportions: the four corners, the central quadrant and
% the rest which is aggregated
for t=1:length(Copulas)
    C = Copulas{t};
    I(t,1)  = C(1,1);
    I(t,2)  = C(1,3);
    I(t,3)  = C(2,2);
    I(t,4)  = C(3,1);
    I(t,5)  = C(3,3);
    I(t,6)  = C(1,2) + C(2,1) + C(2,3) + C(3,2);
end

% Perform the CLR transformation on the proportions
for t=1:size(I, 1)
    clr_I(t,:) = CLR(I(t, :));
end

% Fit the proportions as a 3rd polynomial of the first proportion 
getI = @(I1, beta) beta(1) + beta(2)*I1 + beta(3)*I1.^2 + beta(4)*I1.^3;
x0 = [0.01 ; 0.05 ; 0.4 ; 0 ];
[beta2,fval,exitflag,output,grad,hessian] = fminunc(@(x) modelfun3(x, clr_I(:,2),clr_I(:,1)), x0);
sI2 = getI(clr_I(:,1), beta2);

x0 = [0.01 ; 0.05 ; 0.4 ; 0 ];
[beta3,fval,exitflag,output,grad,hessian] = fminunc(@(x) modelfun3(x, clr_I(:,3),clr_I(:,1)), x0);
sI3 = getI(clr_I(:,1), beta3);

x0 = [0.01 ; 0.05 ; 0.4 ; 0 ];
[beta4,fval,exitflag,output,grad,hessian] = fminunc(@(x) modelfun3(x, clr_I(:,4),clr_I(:,1)), x0);
sI4 = getI(clr_I(:,1), beta4);

x0 = [0.01 ; 0.05 ; 0.4 ; 0 ];
[beta5,fval,exitflag,output,grad,hessian] = fminunc(@(x) modelfun3(x, clr_I(:,5),clr_I(:,1)), x0);
sI5 = getI(clr_I(:,1), beta5);

x0 = [0.01 ; 0.05 ; 0.4 ; 0 ];
[beta6,fval,exitflag,output,grad,hessian] = fminunc(@(x) modelfun3(x, clr_I(:,6),clr_I(:,1)), x0);
sI6 = getI(clr_I(:,1), beta6);

sI = [sI2 sI3 sI4 sI5 sI6];
% plot the fits
figure;
for i=2:6
    subplot(2,3,i-1)
    scatter(clr_I(:,1), clr_I(:,i), '.');
    hold on
    scatter(clr_I(:,1), sI(:,i-1), '.');
    title(sprintf('clr_I(:,1) vs. clr_I(:,%d)', i-1))
    xlabel('clr_I(:,1)');
    ylabel(sprintf('clr_I(:,%d)', i-1));
end

% Get the Copulas as explained by the first quadrant
clr_Synth = [clr_I(:,1) sI2 sI3 sI4 sI5 sI6];
for t= 1:size(clr_Synth, 1)
    % Come back to proportions using the inverse CLR transform
    Synth(t,:) = iCLR(clr_Synth(t,:));
    % Compute the synthetic historical copulas
    C(1,1) = Synth(t,1);
    C(1,3) = Synth(t,2);
    %C(2,2) = Synth(t,3);
    C(3,1) = Synth(t,4);
    C(3,3) = Synth(t,5);
    
    C(1,2) = 1/3 - C(1,1) - C(1,3);
    C(2,1) = 1/3 - C(1,1) - C(3,1);
    C(2,3) = 1/3 - C(1,3) - C(3,3);
    C(3,2) = 1/3 - C(3,1) - C(3,3);
    
    C(2,2) = 1/3 - C(2,1) - C(2,3);
    
    Cop_Synth{t} = C;
end

%% Compare some synthetic copulas with empirical ones (at date p)
%p = 4819;
%p = 5358;
%p = 5604;
p = 5663;
figure
subplot(1,2,1)
heatmap(Cop_Synth{p});
title('Estimated')
subplot(1,2,2)
heatmap(Copulas{p});
title('True')

%% Get the copulas for a range of values of the first quadrant
cI1 = -1.9:0.1:0.7;
for t= 1:length(cI1)
    sI2 = getI(cI1(t), beta2);
    sI3 = getI(cI1(t), beta3);
    sI4 = getI(cI1(t), beta4);
    sI5 = getI(cI1(t), beta5);
    sI6 = getI(cI1(t), beta6);

    ISynth(t,:) = iCLR([cI1(t) sI2 sI3 sI4 sI5 sI6]);
    C(1,1) = ISynth(t,1);
    C(1,3) = ISynth(t,2);
    %C(2,2) = ISynth(t,3);
    C(3,1) = ISynth(t,4);
    C(3,3) = ISynth(t,5);
    
    C(1,2) = 1/3 - C(1,1) - C(1,3);
    C(2,1) = 1/3 - C(1,1) - C(3,1);
    C(2,3) = 1/3 - C(1,3) - C(3,3);
    C(3,2) = 1/3 - C(3,1) - C(3,3);
    
    C(2,2) = 1/3 - C(2,1) - C(2,3);
    Cop_Synth2{t} = C;
end
figure;
for t = 1:27
    subplot(5,6, t);
    heatmap(Cop_Synth2{t});
    title(sprintf('%d [%0.2f]', t, cI1(t)))
end

%% Focus one the change of diagonal which is around -0.252 and -0.251
for cI1 = -0.252:0.0001:-0.251
    sI2 = getI(cI1, beta2);
    sI3 = getI(cI1, beta3);
    sI4 = getI(cI1, beta4);
    sI5 = getI(cI1, beta5);
    sI6 = getI(cI1, beta6);

    ISynth = iCLR([cI1 sI2 sI3 sI4 sI5 sI6]);
    C(1,1) = ISynth(1);
    C(1,3) = ISynth(2);
    C(3,1) = ISynth(4);
    C(3,3) = ISynth(5);

    C(1,2) = 1/3 - C(1,1) - C(1,3);
    C(2,1) = 1/3 - C(1,1) - C(3,1);
    C(2,3) = 1/3 - C(1,3) - C(3,3);
    C(3,2) = 1/3 - C(3,1) - C(3,3);

    C(2,2) = 1/3 - C(2,1) - C(2,3);
    Cop_Synth_test = C;

    figure
    heatmap(Cop_Synth_test);
    title(sprintf(' [%0.4f]', t, cI1))
end



%% Here we fit a circle on the relationship between clr_I(:,1) and clr_I(:,2)
% It is crude but it allows to easily estimate where we are in the "financial cycle"
% The indicator is simply the angle between the x-axis and the estimated
% current location (clr_I(:,1), clr_I(:,2))
x0 = [0 ; 0 ; 1  ];
[betaC,fval,exitflag,output,grad,hessian] = fminunc(@(x) modelfunC(x, clr_I(:,2),clr_I(:,1)), x0);
k = 0;
for theta=0:0.01:2*pi
    k=k+1;
    x(k) = betaC(3)*cos(theta) + betaC(1);
    y(k) = betaC(3)*sin(theta) + betaC(2);
end
figure;
plot(x, y);
axis square;
grid on;
hold on
scatter(clr_I(:,1), clr_I(:,2), '.')

% Compute the indicator (as angle) 
Threshold = acos((-0.25185-betaC(1))/betaC(3));
Indicator = acos((clr_I(:,1)-betaC(1))/betaC(3)) - Threshold;
% Simplify the indicator by spliting the sample in 6 "phases"
Ind(Indicator>2*std(Indicator))= 1;
Ind(Indicator>std(Indicator) & Indicator<2*std(Indicator))  = 2;
Ind(Indicator>0 & Indicator<std(Indicator))  = 3;
Ind(Indicator<0 & Indicator>-std(Indicator))  = 4;
Ind(Indicator<-std(Indicator) & Indicator>-2*std(Indicator))  = 5;
Ind(Indicator<-2*std(Indicator))  = 6;

% Empirical transition matrix between the phases
T = zeros(6);
for t=2:length(Copulas)
    T(Ind(t-1), Ind(t)) = T(Ind(t-1), Ind(t))+1;
end
T = (T'./(ones(6,1)*sum(T')))';
% Plot the indicator
figure
plot(Ind)
xticks(1:252:length(Copulas))
xticklabels(Dates(1:252:length(Copulas)))
xtickangle(90);