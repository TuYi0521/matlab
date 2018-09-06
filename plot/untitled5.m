PMF1 = [0.282,0.2775,0.2715,0.2735];
RRN1 = [0.2725,0.2712,0.2715,0.2713];
NCF1 = [0.2515,0.2478,0.2472,0.2468];
FIP1 = [0.2915,0.277,0.222,0.2035];
EJP1 = [0.285,0.27,0.22,0.23];
NJP1 = [0.2385,0.2382,0.2379,0.238];

PMF2 = [0.284,0.279,0.2735,0.2735];
RRN2 = [0.3113,0.3105,0.3102,0.3102];
NCF2 = [0.1166,0.1164,0.1162,0.1162];
FIP2 = [0.2815,0.277,0.272,0.2735];
EJP2 = [0.285,0.27,0.22,0.23];
NJP2 = [0.1024,0.0931,0.0927,0.0928];

X0=[1,2,3,4];
X1 = [0,0.001,0.01,1];

figure(1);
subplot(1,2,1);
hold on
plot(X0,PMF1,'-*','linewidth',3,'MarkerSize',20);
plot(X0,RRN1,'-o','linewidth',3,'MarkerSize',20);
plot(X0,NCF1,'-d','linewidth',3,'MarkerSize',20);
plot(X0,FIP1,'-x','linewidth',3,'MarkerSize',20);
plot(X0,EJP1,'-s','linewidth',3,'MarkerSize',20);
plot(X0,NJP1,'-p','linewidth',3,'MarkerSize',20);
set(gca,'xticklabel',X1,'fontsize',40,'fontweight','bold')
%axis([0, 1, 0.25, 0.29])
ylabel('RMSE')
%xlabel('\lambda')
xlabel('D')
title('Epinions','fontsize',40,'fontweight','bold')

h_leg = legend('PMF','RRN','NCF','FIP','ELJP','NJM','Location','SouthOutside');
set(h_leg,'Orientation','horizon')
hold off

subplot(1,2,2);
hold on
plot(X0,PMF2,'-*','linewidth',3,'MarkerSize',20);
plot(X0,RRN2,'-o','linewidth',3,'MarkerSize',20);
plot(X0,NCF2,'-d','linewidth',3,'MarkerSize',20);
plot(X0,FIP2,'-x','linewidth',3,'MarkerSize',20);
plot(X0,EJP2,'-s','linewidth',3,'MarkerSize',20);
plot(X0,NJP2,'-p','linewidth',3,'MarkerSize',20);
set(gca,'xticklabel',X1,'fontsize',40,'fontweight','bold');
hold off
%axis([0, 1, 0.29, 0.31])
ylabel('RMSE')
%xlabel('\lambda')
xlabel('D')
title('Gowalla','fontsize',40,'fontweight','bold');


