%Y = zeros(4,4);
Y1 = 0.2328;
Y2 = 0.2439;
Y3 = 0.2048;
Y4 = 0.2132;
X1 = 1;
X2 = 2;

figure(1);
subplot(1,2,1);
hold on;
bar(X1,Y1,1);
bar(X2,Y2,1)
%set(get(h(1),'BaseLine'),'LineWidth',0.1,'LineStyle',':')
set(gca,'fontsize',45,'fontweight','bold')
hold off;
%axis([0, 3, 0.22, 0.245])
ylabel('RMSE')
%xlabel('D')
title('Epinions','fontsize',65,'fontweight','bold')

subplot(1,2,2);
hold on;
bar(X1,Y3,1);
bar(X2,Y4,1);
%set(get(h(1),'BaseLine'),'LineWidth',0.1,'LineStyle',':')
set(gca,'fontsize',45,'fontweight','bold')
%axis([0, 3, 0.20, 0.22])
ylabel('RMSE')
hold off
%xlabel('D')
title('Gowalla','fontsize',65,'fontweight','bold');

h = legend('NJM','NJM-\it{T}','Location','SouthOutside');
set(h,'Orientation','horizon')
%colorbar;
%set(h_leg,'position',[0.128045039392037 0.924910084879874 0.160714285714286 0.0555555555555556]);

