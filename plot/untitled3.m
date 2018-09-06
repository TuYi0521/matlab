%Y = zeros(4,4);
Y1 = [0.283, 0.2663, 0.2725, 0.2515,0.2814, 0.273,0.2618,0.2332;
    0.2817,0.2592,0.2712,0.2478,0.2812,0.2714,0.2612,0.2328;
    0.2814,0.2589,0.2715,0.2472,0.2811,0.2712,0.2611,0.2326;
    0.2812,0.255,0.2713,0.2468,0.2811,0.2717,0.2611,0.2325];
Y2 = [0.328, 0.3187, 0.3113, 0.2266, 0.333, 0.313,0.2285,0.2059;
    0.326,0.318,0.3105,0.2184, 0.332,0.312,0.2236,0.2048;
    0.317,0.3178,0.3102,0.2162, 0.3319,0.316,0.2227,0.2045;
    0.318,0.3181,0.3102,0.2162,0.3031, 0.315,0.223,0.2046];
X = [5,10,15,20];

figure(1);
subplot(1,2,1);
h = bar(X,Y1,1);
set(get(h(1),'BaseLine'),'LineWidth',1,'LineStyle',':')
set(gca,'fontsize',45,'fontweight','bold')
axis([3, 22, 0.20, 0.285])
ylabel('RMSE')
xlabel('D')
title('Epinions','fontsize',45,'fontweight','bold')

subplot(1,2,2);
h = bar(X,Y2,1);
set(get(h(1),'BaseLine'),'LineWidth',1,'LineStyle',':')
set(gca,'fontsize',45,'fontweight','bold')
axis([3, 22, 0.20, 0.35])
ylabel('RMSE')
xlabel('D')
title('Gowalla','fontsize',45,'fontweight','bold');

h_leg = legend('PMF','TimeSVD++','RRN','NCF','FIP','ELJP','NJM-F','NJM','Location','SouthOutside');
set(h_leg,'Orientation','horizon')

%colorbar;
%set(h_leg,'position',[0.128045039392037 0.924910084879874 0.160714285714286 0.0555555555555556]);

