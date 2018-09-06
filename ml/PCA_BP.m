clear; clc;
data=load('Table.csv');
pd=data(1:405,:)';
%normalize
[pn,minp,maxp]=premnmx(pd);
pr=[pn(:,1:401);pn(:,2:402);pn(:,3:403);pn(:,4:404);pn(:,5:405)];

p=pr(:,1:300); 
t=pn(4,6:305); 
pX=pr(:,301:400);
pY=pn(4,306:405);

X=p; 
T=t;
[R,N]=size(X);
[S2,N] =size(T);
S1=16;

net=newff(X,T,S1,{'tansig','purelin'}); 
disp('1.  TRAINGDX');
disp('2.  L-M 优化算法 TRAINLM');
disp('3.  贝叶斯正则化算法 TRAINBR');  
choice=input('请选择训练算法(1,2,3):');  

if(choice==1)
    net.trainFcn='traingdx';
    net.trainParam.show = 50;
    net.trainParam.lr = 0.02;
    net.trainParam.lr_inc=1.05;
    net.trainParam.epochs = 300;
    net.trainParam.goal = 1e-3;

    net.trainParam.mc = 0.9;
    net= init(net);
    
elseif(choice==2)
    %   L-M  TRAINLM  
    net.trainFcn='trainlm';                 
           
    net.trainParam.epochs = 500;          
    net.trainParam.goal = 1e-6;          
    
    net=init(net);         
%    pause;

elseif(choice==3)
    %  TRAINBR          
    net.trainFcn='trainbr';                  
           
    net.trainParam.epochs = 1000;
    net.trainParam.goal=0.001;
  
    net = init(net);             

end 

[net,tr] = train(net,X,T);
figure(1)
plot(tr.epoch,tr.perf,tr.epoch,tr.vperf,tr.epoch,tr.tperf)
legend('Training','Validation','Test','Location','BestOutside');
ylabel('Squared Error');
xlabel('Epoch');

train = sim(net,p);
test = sim(net,pX);
a = postmnmx(train,minp,maxp);
a = a';

figure(2)
hold on
plot(train,'b')
plot(t,'r')
legend('training prediction','training factual out','Location','North')
title('comparison of training prediction and factual out')

figure(3)
hold on
plot(test,'b')
plot(pY,'r')
legend('testing prediction','testing factual out','Location','North')
title('testing prediction effects')