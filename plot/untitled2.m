AA1 = [0.164,0.173,0.174,0.178];
Node2Vec1 = [0.181,0.185,0.185,0.189];
ASNE1 = [0.198,0.202,0.206,0.209];
FIP1 = [0.164,0.17,0.172,0.172];
EJLP1 = [0.238,0.24,0.243,0.243];
NJPP1 = [0.201,0.203,0.206,0.206];
NJP1 = [0.247,0.251,0.251,0.2516];

AA2 = [0.203,0.206,0.211,0.215];
Node2Vec2 = [0.203,0.214,0.217,0.217];
ASNE2 = [0.247,0.254,0.256,0.265];
FIP2 = [0.243,0.246,0.248,0.248];
EJP2 = [0.302,0.32,0.32,0.325];
NJPP2 = [0.305,0.312,0.312,0.3112];
NJP2 = [0.324,0.331,0.336,0.3371];

AA3 = [0.181,0.185,0.189,0.193,];
Node2Vec3 = [0.192,0.198,0.199,0.202,];
ASNE3 = [0.216,0.221,0.223,0.231];
FIP3 = [0.195,0.196,0.197,0.1976];
EJP3 = [0.268,0.274,0.277,0.279];
NJPP3 = [0.243,0.245,0.2457,0.2477];
NJP3 = [0.279,0.281,0.2821,0.283];

AA4 = [0.284,0.279,0.2735,0.2735];
Node2Vec4 = [0.2825,0.278,0.272,0.2735];
ASNE4 = [0.282,0.2775,0.2715,0.2735];
FIP4 = [0.2815,0.277,0.272,0.2735];
EJP4 = [0.285,0.27,0.22,0.23];
NJPP4 = [0.25,0.22,0.21,0.18];
NJP4 = [0.25,0.22,0.21,0.18];

AA5 = [0.284,0.279,0.2735,0.2735];
Node2Vec5 = [0.2825,0.278,0.272,0.2735];
ASNE5 = [0.282,0.2775,0.2715,0.2735];
FIP5 = [0.2815,0.277,0.272,0.2735];
EJP5 = [0.285,0.27,0.22,0.23];
NJPP5 = [0.25,0.22,0.21,0.18];
NJP5 = [0.25,0.22,0.21,0.18];

AA6 = [0.284,0.279,0.2735,0.2735];
NOde2Vec6 = [0.2825,0.278,0.272,0.2735];
ASNE6 = [0.282,0.2775,0.2715,0.2735];
FIP6 = [0.2815,0.277,0.272,0.2735];
EJP6 = [0.285,0.27,0.22,0.23];
NJPP6 = [0.25,0.22,0.21,0.18];
NJP6 = [0.25,0.22,0.21,0.18];

X0 = [5,10,15,20];

figure(1);

subplot(2,3,1);
hold on
plot(X0,AA1,'-*','linewidth',3,'MarkerSize',14);
plot(X0,Node2Vec1,'-o','linewidth',3,'MarkerSize',14);
plot(X0,ASNE1,'-+','linewidth',3,'MarkerSize',14);
plot(X0,FIP1,'-x','linewidth',3,'MarkerSize',14);
plot(X0,EJLP1,'-s','linewidth',3,'MarkerSize',14);
plot(X0,NJPP1,'-p','linewidth',3,'MarkerSize',14);
plot(X0,NJP1,'-h','linewidth',3,'MarkerSize',14);
set(gca,'fontsize',20,'fontweight','bold')
ylabel('Precision')
xlabel('D')
title('Epinions - Precision','fontsize',30,'fontweight','bold')

subplot(2,3,2);

hold on
plot(X0,AA2,'-*','linewidth',3,'MarkerSize',14);
plot(X0,Node2Vec2,'-o','linewidth',3,'MarkerSize',14);
plot(X0,ASNE2,'-+','linewidth',3,'MarkerSize',14);
plot(X0,FIP2,'-x','linewidth',3,'MarkerSize',14);
plot(X0,EJP2,'-s','linewidth',3,'MarkerSize',14);
plot(X0,NJPP2,'-p','linewidth',3,'MarkerSize',14);
plot(X0,NJP2,'-h','linewidth',3,'MarkerSize',14);
set(gca,'fontsize',20,'fontweight','bold');
hold off

ylabel('Recall')
xlabel('D')
title('Epinions - Recall','fontsize',30,'fontweight','bold')
% h_leg = legend('PMF','SVD++','RRN','NCF','FIP','ELJP','NJP','NJP-F','Location','SouthOutside');
% set(h_leg,'Orientation','horizon')
h_leg = legend('AA','Node2Vec','ASNE','FIP','ELJP','NJP-L','NJP','Location','EastOutside');
set(h_leg,'Orientation','vertical')

subplot(2,3,3);
hold on
plot(X0,AA3,'-*','linewidth',3,'MarkerSize',14);
plot(X0,Node2Vec3,'-o','linewidth',3,'MarkerSize',14);
plot(X0,ASNE3,'-+','linewidth',3,'MarkerSize',14);
plot(X0,FIP3,'-x','linewidth',3,'MarkerSize',14);
plot(X0,EJP3,'-s','linewidth',3,'MarkerSize',14);
plot(X0,NJPP3,'-p','linewidth',3,'MarkerSize',14);
plot(X0,NJP3,'-h','linewidth',3,'MarkerSize',14);
set(gca,'fontsize',20,'fontweight','bold');
hold off

ylabel('F1')
xlabel('D')
title('Epinions - F1','fontsize',30,'fontweight','bold');


subplot(2,3,4);
hold on
plot(X0,AA4,'-*','linewidth',3);
plot(X0,Node2Vec4,'-o','linewidth',3);
plot(X0,ASNE4,'-+','linewidth',3);
plot(X0,FIP4,'-x','linewidth',3);
plot(X0,EJP4,'-s','linewidth',3);
plot(X0,NJPP4,'-p','linewidth',3);
plot(X0,NJP4,'-h','linewidth',3);
set(gca,'fontsize',20,'fontweight','bold');
hold off

ylabel('Precision')
xlabel('D')
title('Gowalla - Precision','fontsize',30,'fontweight','bold')


subplot(2,3,5);
hold on
plot(X0,AA5,'-*','linewidth',3);
plot(X0,Node2Vec5,'-o','linewidth',3);
plot(X0,ASNE5,'-+','linewidth',3);
plot(X0,FIP5,'-x','linewidth',3);
plot(X0,EJP5,'-s','linewidth',3);
plot(X0,NJPP5,'-p','linewidth',3);
plot(X0,NJP5,'-h','linewidth',3);
set(gca,'fontsize',20,'fontweight','bold');
hold off
%axis([3, 22, 0.24, 0.285])
ylabel('Recall')
xlabel('D')
title('Gowalla - Recall','fontsize',30,'fontweight','bold')

subplot(2,3,6);
hold on
plot(X0,AA6,'-*','linewidth',3);
plot(X0,NOde2Vec6,'-o','linewidth',3);
plot(X0,ASNE6,'-+','linewidth',3);
plot(X0,FIP6,'-x','linewidth',3);
plot(X0,EJP6,'-s','linewidth',3);
plot(X0,NJPP6,'-p','linewidth',3);
plot(X0,NJP6,'-h','linewidth',3);
set(gca,'fontsize',20,'fontweight','bold');
hold off
%set(get(h(1),'BaseLine'),'LineWidth',1,'LineStyle',':')
ylabel('F1')
xlabel('D')
title('Gowalla - F1','fontsize',30,'fontweight','bold')


