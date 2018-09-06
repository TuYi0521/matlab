clear all
clc
clf

% three layers
%the number of input layer neurons is 5，hidden layer neurons is 3，output layer 1
%max iteration
%the number of hidden layer neurons
bn=3;
fprintf('the number of hidden layer neurons:%d \n',bn);
max_iter=5000;

%e: calculate the difference of net response and targets
e=zeros(max_iter,1);


data=load('Table.csv');
%data = data(1:400,:);
[n1 m1]=size(data);
fprintf('the number of data points:%d \n',n1);

% tradenum
open_price=data(:,1)';
maxprice=data(:,2)';
minprice=data(:,3)';
close_price=data(:,4)';
tradenum=data(:,6)';

%divide the data into training data and testing data by 3:1
num=length(close_price);
num=ceil(num/4*3) ;

%test data starts from 3/4 
openprice_test=open_price(num+1:end);
maxp_test=maxprice(num+1:end);
minp_test=minprice(num+1:end);
tnum_test=tradenum(num+1:end);
closeprice_test=close_price(num+1:end);

%training data
open_price=open_price(1:num);
maxprice=maxprice(1:num);
minprice=minprice(1:num);
tradenum=tradenum(1:num);
close_price=close_price(1:num);

% goal is the close price of next day.
goalprice=close_price(2:num);

%normalize (0 1)
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

normalize=@(A)((A-min(A))/(max(A)-min(A)));
maxprice=normalize(maxprice);
minprice=normalize(minprice);
open_price=normalize(open_price);
close_price=normalize(close_price);
tradenum=normalize(tradenum);

maxprice=maxprice(1:num-1);
minprice=minprice(1:num-1);
open_price=open_price(1:num-1);
close_price=close_price(1:num-1);
tradenum=tradenum(1:num-1);

%the number of training data
loopn=length(maxprice);

simp=[maxprice;minprice;open_price;close_price;tradenum];



%hidden layer activation function
sigmoid=@(x)(1/(1+exp(-x)));

%bx stores the output of hidden layer neurons
%bxe stores the input of the output layer. sigmoid(bx)
bx=zeros(bn,1);
bxe=zeros(bn,1);

%learning rate
u=0.02;


W1=rand(bn,5);

W2=rand(1,bn);

%loopn out
out=zeros(loopn,1);

for k=1:1:max_iter
    
   
    for i=1:1:loopn
        
        for j=1:1:bn
            bx(j)=W1(j,:)*simp(:,i);
            bxe(j)=sigmoid(bx(j));
        end
        
        out(i)=W2*bxe;
        
        delta_W2=zeros(1,bn);
        delta_W2=u*(goalprice(i)-out(i))*bxe';
        
        delta_W1=zeros(bn,5);
        for j=1:1:bn
            delta_W1(j,:)=u* (goalprice(i)-out(i))*W2(j)*bxe(j)*(1-bxe(j))*simp(:,i)';
        end
        W1=W1+delta_W1;
        W2=W2+delta_W2;
    end
    
    %sample error
    e(k)=sum((out-goalprice').^2)/2/loopn;
    
    if e(k)<=0.01
        disp('iteration')
        disp(k)
        disp('training error')
        disp(e(k))
        break
    end
end

W1
W2

figure(1)
hold on
e=e(1:k);
plot(e)
title('E(k)')

figure(2)
hold on
plot(out,'r')
plot(goalprice,'b')
legend('training responses','training targets','Location','North')
title('comparison of training net responses and targets')


%test
maxp_test=(maxp_test-maxp_min)/(maxp_max-maxp_min);
minp_test=(minp_test-minp_min)/(minp_max-minp_min);
openprice_test=(openprice_test-op_min)/(op_max-op_min);
test_target=closeprice_test(2:end);
closeprice_test=(closeprice_test-cp_min)/(cp_max-cp_min);
tnum_test=(tnum_test-tnum_min)/(tnum_max-tnum_min);

simpt=[maxp_test;minp_test;openprice_test;closeprice_test;tnum_test];

for i=1:1:length(maxp_test)-1
    for j=1:1:bn
        bx(j)=W1(j,:)*simpt(:,i);
        bxe(j)=sigmoid(bx(j));
    end
    
    %responses
    test_out(i)=W2*bxe;
end

% test responses and test targets
figure(3)
hold on
plot(test_out,'r')
plot(test_target,'b')

legend('testing responses','testing targets','Location','North')
title('testing prediction effects')

% global testing error
disp('Error of testing data')
disp(1/length(test_target)*0.5*sum((test_target-test_out).^2))

