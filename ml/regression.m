clear;
clc;
close all;
%% lambda
lambdaA = [0.01;0.05;0.1;0.2;0.3];
lambdaB = [0.01;0.1;0.5;0.6;0.75];
lambdaC = [0.01;0.05;0.1;0.15;0.2];
lambda0 = [1;50;100;200;1000];

lambda = lambdaC;
%% Data A
% trainX = randn(1000,20);
% trainY = randn(1000,1);
% testX = randn(500,20);
% testY = randn(500,1);

%% cloud
data2 = load('cloud.csv');
[num2 dim2] = size(data2);
num2
dim2

label2 = data2(:,7);
V2 = [1 2 3 4 5 6 8 9 10];
features2 = data2(:,V2);
features2

% trainX = features2(1:800,:);
% trainY = label2(1:800,:);
% testX = features2(800:num2,:);
% testY = label2(800:num2,:);
%% forest
data3 = load('forestfires.csv');
[num3 dim3] = size(data3);

labels3 = log(data3(:,13)+1);
V = 1:12;
features3 = data3(:,V);
features3

trainX = features3(1:400,:);
trainY = labels3(1:400,:);
testX= features3(400:num3,:);
testY = labels3(400:num3,:);



%%
[B,S] = lasso(trainX,trainY,'Lambda',lambda);
%lassoPlot(B,S)

[n m] = size(B);
n
m
count = zeros(1,5);
for i=1:m
    for j=1:n
    if(~B(j,i)==0)
       count(i) = count(i)+1;
    end
    end
end
count
figure(1)
plot(lambda,count,'*');
xlabel('lambda'); ylabel('number of non-coef');
title('nunmber of non-zero coef responding to lambda')
figure(2);
pre_y = testX*B;
error= pre_y-testY;
MSE = sum(error.^2)/(num3-400);
plot(MSE)
title('Lasso MSE')

b = ridge(trainY, trainX, lambda0);
figure(3);
[n1 m1] = size(b);
count1 = zeros(1,5);
for i=1:m1
    for j=1:n1
    if(~b(j,i)==0)
        count1(i) = count1(i)+1;
    end
    end
end
count1
plot(lambda0,count1,'o')
xlabel('Ridge lambda'); ylabel('number of non-coef');
title('nunmber of non-zero coef responding to lambda')

figure(4);
pre_y1 = testX*b;
error1= pre_y1-testY;
MSE1 = sum(error1.^2)/(num3-400);
plot(MSE1)
title('Ridge MSE')







