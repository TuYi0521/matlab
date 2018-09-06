close all  
clear all  
clc  
% NEWFF——生成一个新的前向神经网络  
% TRAIN——对 BP 神经网络进行训练 
% SIM——对 BP 神经网络进行仿真    
%  定义训练样本矢量  
% P 为输入矢量  
stock=[002225];  %股票代码
[a b c d e f]=kline(stock,360);  %取得股票日K线数据
aa=[a ;b; c ;d; e ;f ];  %搞成矩阵
aa(6,:)=aa(2,:)-aa(3,:);  %开收盘价差
aa(7,:)=aa(4,:)-aa(1,:);  %最高最低盘价差
 
while (1)   %很恶心的代码，取出没开盘的时间数据
   a=size(aa);
   bexit=0;
   for n=1:a(2)
       if aa(7,n)==0 
           aa(:,n)=[];
           bexit = 1;
           break;
       end       
   end
   if bexit==0
        break;    
   end
end
 
a=size(aa);   
bb=aa;
bb(:,1)=[];
cc=aa;
cc(:,a(2))=[];
bb=bb-cc;   %计算前后2天的差分数据，添加进训练数据。我们关系预测价差嘛
 
aa(8:14,2:a(2)) = bb;%计算前后2天的差分数据，添加进训练数据。我们关系预测价差嘛
 
%aa = aa';  
aa(:,1)=[];
 
%  创建一个新的前向神经网络  
net=newff(minmax(aa),[12,5],{'tansig','purelin'});  
disp('1.  L-M 优化算法 TRAINLM'); disp('2.  贝叶斯正则化算法 TRAINBR');  
choice=input('请选择训练算法(1,2):');  
if(choice==1)
    %  采用 L-M 优化算法 TRAINLM  
    net.trainFcn='trainlm';                 
    %  设置训练参数          
    net.trainParam.epochs = 500;          
    net.trainParam.goal = 1e-6;          
    %  重新初始化
    net=init(net);         
%    pause;
elseif(choice==2)
    %  采用贝叶斯正则化算法 TRAINBR          
    net.trainFcn='trainbr';                  
    %  设置训练参数          
    net.trainParam.epochs = 1000;
    net.trainParam.goal=0.001;
 %  重新初始化   
    net = init(net);             
 %   pause;
end 
% 调用相应算法训练 BP 网络 
a=size(aa);
[Pn,minP,maxP,Tn,minT,maxT]=premnmx(aa(:,1:a(2)),aa(1:5,1:a(2)));%归一化处理
[net,tr]=train(net,Pn(:,1:a(2)-1),Tn(:,2:a(2)));
%[net,tr]=train(net,aa(:,1:a(2)-1),aa(1:5,2:a(2)));
%[net,tr]=train(net,aa,T); 
% 对 BP 网络进行仿真 
%yn = sim(net,aa(:,1:a(2)-1)); 
yn=sim(net,Pn);  %仿真 ，+ 同是把昨天数据加入仿真数据，看一下预测数据。
 
%E =  yn - aa(1:5,2:a(2));  %%%看看误差
%MSE=mse(E) ;
 
y=postmnmx(yn,minT,maxT);  %反归一化
 
figure   %%把图画出来
subplot(2,1,1);
plot(aa(4,1:a(2))); 
subplot(2,1,2);
plot(y(4,:)); 