%Y = zeros(4,4);
Y1 = [0.2332, 0.2328, 0.2326, 0.2325; 
    0.2411,0.2406,0.2399,0.2398];
Y2=Y1'
Y3 = [0.2059, 0.2048, 0.2045, 0.2046;
    0.2161,0.2156,0.2153,0.2149];
Y4=Y3'
X = [5,10,15,20];

figure(1);
subplot(1,2,1);
hold on;
bar(X,Y2,1);
hold off;
%set(get(h(1),'BaseLine'),'LineWidth',1,'LineStyle',':')
set(gca,'fontsize',40,'fontweight','bold')
axis([3, 22, 0.22, 0.245])
ylabel('RMSE')
xlabel('D')
title('Epinions','fontsize',60,'fontweight','bold')

subplot(1,2,2);
hold on;
bar(X,Y4,1);
hold off;
%set(get(h(1),'BaseLine'),'LineWidth',1,'LineStyle',':')
set(gca,'fontsize',40,'fontweight','bold')
axis([3, 22, 0.20, 0.22])
ylabel('RMSE')
xlabel('D')
title('Gowalla','fontsize',60,'fontweight','bold');

h_leg = legend('NJM with trainable \itT','NJM with fixed \itT','Location','SouthOutside');
%set(h_leg,'Orientation','horizon')

%colorbar;
%set(h_leg,'position',[0.128045039392037 0.924910084879874 0.160714285714286 0.0555555555555556]);

