clear all
clc
clf

%采用三层BP网络结构
%输入层神经元数为5，隐含层神经元数为3，输出层神经元数为1

%最大迭代次数
max_iter=3000;

%e为计算输出和样本实际输出差
%在内存中开辟maxcishu个存储空间
e=zeros(max_iter,1);

% 输入数据维度5，输入节点数5
% 调用数据

data=importdata('dow_jones_index.xlsx');
[n1 m1]=size(data.data);
n1

% 当日最高价序列
% 当日最低价序列
% 当日开盘价
% 当日收盘价
% tnum当日成交量
open_price=data.data(:,4)';
maxprice=data.data(:,5)';
minprice=data.data(:,6)';
close_price=data.data(:,7)';
tradenum=data.data(:,10)';

%将数据集按照2:1分为训练样本集，和测试样本集
num=length(close_price);
num=ceil(num/3*2) ;

%测试样本集是2/3处到最后一个
openprice_test=open_price(num+1:end);
maxp_test=maxprice(num+1:end);
minp_test=minprice(num+1:end);
tnum_test=tradenum(num+1:end);
closeprice_test=close_price(num+1:end);

%训练样本集
open_price=open_price(1:num);
maxprice=maxprice(1:num);
minprice=minprice(1:num);
tradenum=tradenum(1:num);
close_price=close_price(1:num);

%记录下每组的最大值最小值，为训练样本集的归一化准备
maxp_max=max(maxprice);
maxp_min=min(maxprice);
minp_max=max(minprice);
minp_min=min(minprice);
cp_max=max(close_price);
cp_min=min(close_price);
op_max=max(open_price);
op_min=min(open_price);
tnum_max=max(tradenum);
tnum_min=min(tradenum);

% 目标数据为次日的收盘价，相当于把当日收盘价时间序列向前挪动一个单位
goalprice=close_price(2:num);

%数据归一化,将所有数据归一化到(0 1)
normalize=@(A)((A-min(A))/(max(A)-min(A)));
maxprice=normalize(maxprice);
minprice=normalize(minprice);
open_price=normalize(open_price);
close_price=normalize(close_price);
tradenum=normalize(tradenum);

% 后面的目标数据goalp个数是cp向前移动一位得到，所以最后一组的目标数据缺失
% 所以，要把除了目标数据goalp以外的所有数据序列删除最后一个
maxprice=maxprice(1:num-1);
minprice=minprice(1:num-1);
open_price=open_price(1:num-1);
close_price=close_price(1:num-1);
tradenum=tradenum(1:num-1);

%需要循环学习次数loopn，即训练样本的个数
loopn=length(maxprice);
%为了方便表示将5个行向量放到一个5*loopn的矩阵中simp中,每一列是一个样本向量
simp=[maxprice;minprice;open_price;close_price;tradenum];

%隐含层节点n
%根据相关资料，隐含层节点数比输入节点数少，一般取1/2输入节点数
bn=3;

%隐含层激活函数为S型函数
sigmoid=@(x)(1/(1+exp(-x)));

%bx用来存放隐含层每个节点的输出
%bxe用来保存bx经过S函数处理的值，即输出层的输入
bx=zeros(bn,1);
bxe=zeros(bn,1);

%权值学习率u
u=0.02;

%W1(m,n)表示隐含层第m个神经元节点的第n个输入数值的权重，
%即，每一行对应一个节点
%所以输入层到隐含层的权值W1构成一个bn*5的矩阵，初值随机生成
W1=rand(bn,5);

%W2(m)表示输出节点第m个输入的权值，初值采用随机生成
W2=rand(1,bn);

%loopn个训练样本，对应loopn个输出
out=zeros(loopn,1);

for k=1:1:max_iter
    
    %训练开始,i表示为本次输入的是第i个样本向量
    for i=1:1:loopn
        
        %求中层每个节点bx(n)的输出，系数对应的是W1的第n行
        for j=1:1:bn
            bx(j)=W1(j,:)*simp(:,i);
            bxe(j)=sigmoid(bx(j));
        end
        
        %求输出
        out(i)=W2*bxe;
        
        %误差反向传播过程
        %计算输出节点的输入权值修正量,结果放在行向量AW2中
        %输出神经元激活函数 f(x)=x
        %为了书写方便，将deta用A代替
        delta_W2=zeros(1,bn);
        delta_W2=u*(goalprice(i)-out(i))*bxe';
        
        %计算隐含层节点的输入权值修正量,结果放在行向量AW1中,需要对隐含层节点逐个处理
        delta_W1=zeros(bn,5);
        for j=1:1:bn
            delta_W1(j,:)=u* (goalprice(i)-out(i))*W2(j)*bxe(j)*(1-bxe(j))*simp(:,i)';
        end
        W1=W1+delta_W1;
        W2=W2+delta_W2;
    end
    
    %计算样本偏差
    e(k)=sum((out-goalprice').^2)/2/loopn;
    %误差设定
    if e(k)<=0.01
        disp('迭代次数')
        disp(k)
        disp('训练样本集误差')
        disp(e(k))
        break
    end
end

%显示训练好的权值
W1
W2
%绘制误差收敛曲线，直观展示收敛过程
figure(1)
hold on
e=e(1:k);
plot(e)
title('训练样本集误差曲线')
% 计算输出和实际输出对比图
figure(2)
plot(out,'r-p')
hold on
plot(goalprice,'b-o')
title('训练样本集计算输出和实际输出对比')

%学习训练过程结束

%进行测试样本阶段,变量用末尾的t区分训练样本
maxp_test=(maxp_test-maxp_min)/(maxp_max-maxp_min);
minp_test=(minp_test-minp_min)/(minp_max-minp_min);
openprice_test=(openprice_test-op_min)/(op_max-op_min);
cptduibi=closeprice_test(2:end);
closeprice_test=(closeprice_test-cp_min)/(cp_max-cp_min);
tnum_test=(tnum_test-tnum_min)/(tnum_max-tnum_min);

% 同样，将多维数据放入一个矩阵中，便于处理
simpt=[maxp_test;minp_test;openprice_test;closeprice_test;tnum_test];

%因为是用当前的数据预测下一天的，所以检验样本第一天的收盘价和预测的最后一天的收盘价因为没有比对值而舍弃
for i=1:1:length(maxp_test)-1
    for j=1:1:bn
        bx(j)=W1(j,:)*simpt(:,i);
        bxe(j)=sigmoid(bx(j));
    end
    
    %输出预测序列
    out_test(i)=W2*bxe;
end

%预测输出和实际对比散点图
figure(3)
hold on
plot(out_test,'r-p')
plot(cptduibi,'b-o')
title('测试样本集预测输出和实际对比')

%计算全局误差
disp('测试样本集误差')
disp(1/length(cptduibi)*0.5*sum((cptduibi-out_test).^2))

