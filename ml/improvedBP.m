clear; clc;
%read data
data=load('Table.csv');
pd=data(1:405,:)';
data=[pd(:,1:401);pd(:,2:402);pd(:,3:403);pd(:,4:404);pd(:,5:405)];
p=data(:,1:300); 
t=pd(4,6:305);  
px=data(:,301:400);
py=pd(4,306:405);

%normalize
[pn,meanp,stdp,tn,meant,stdt]=prestd(p,t);
pX = trastd(px,meanp,stdp);
pY = trastd(py,meant,stdt);

[ptrans,transMat] = prepca(pn,0.02);
pXtrans = trapca(pX,transMat);

[R,N]=size(ptrans);
[S2,N] =size(t);
S1=3;

net=newff(ptrans,tn,S1,{'tansig','purelin'}); 

disp('1.  TRAINGDX');
disp('2.  L-M TRAINLM');
disp('3.  Bayes-Regulation TRAINBR');  
choice=input('choose training algorithm (1,2,3):');  

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


elseif(choice==3)
    % BAYES TRAINBR          
    net.trainFcn='trainbr';                  
           
    net.trainParam.epochs = 1000;
    net.trainParam.goal=0.001;
   
    net = init(net);             

end 

[net,tr] = train(net,ptrans,tn);
figure(1)
plot(tr.epoch,tr.perf,tr.epoch,tr.vperf,tr.epoch,tr.tperf)
legend('Training','Validation','Test','Location','BestOutside');
ylabel('Squared Error');
xlabel('Epoch');

train = sim(net,ptrans);
test = sim(net,pXtrans);
a = poststd(train,meant,stdt);
[m,b,r] = postreg(a,t);

figure(2)
hold on
plot(train,'b')
plot(tn,'r')
hold off
legend('training responses','training targets','Location','North')
title('comparison of training net responses and targets')

figure(3)
hold on
plot(test,'b')
plot(pY,'r')
legend('testing responses','testing targets','Location','North')
title('testing prediction effects')
hold off