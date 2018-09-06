%Y = zeros(4,4);
Y = [0.284, 0.279, 0.2735, 0.2662;
    0.2825,0.278,0.272,0.2576;
    0.282,0.2775,0.2715,0.2553;
    0.2815,0.277,0.272,0.2549];
X = [5,10,15,20];

figure(1);
subplot(1,2,1);
h = bar(X,Y,1);
set(get(h(1),'BaseLine'),'LineWidth',1,'LineStyle',':')
axis([3, 22, 0.24, 0.285])
ylabel('RMSE')
xlabel('D')
title('Epinions')

subplot(1,2,2);
Y2 = [0.329, 0.322, 0.315, 0.3031;
    0.327,0.321,0.313,0.2924;
    0.3265,0.3205,0.3125,0.2918;
    0.327,0.3215,0.312,0.2916];

h = bar(X,Y2,1);
set(get(h(1),'BaseLine'),'LineWidth',1,'LineStyle',':')
axis([3, 22, 0.28, 0.33])

ylabel('RMSE')
xlabel('D')
title('Gowalla');

h_leg = legend('PMF','SocialMF','ELJP','Our Model','Location','SouthOutside');
set(h_leg,'Orientation','horizon')

%colorbar;
%set(h_leg,'position',[0.128045039392037 0.924910084879874 0.160714285714286 0.0555555555555556]);

