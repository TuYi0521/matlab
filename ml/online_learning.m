close all;clear;clc;
data = load('cloud.csv');
global b
[num dim] = size(data);
num
dim
%data

lable = data(:,7);
V = [1 2 3 4 5 6 8 9 10];
features = data(:,V);
features

color = ['bo' 'r.' 'g*' 'yx'];
figure(1),hold on

pt1 = online_learn(features, lable,1,'r*');
pt2 = online_learn(features, lable,0.25,'bo');
pt3 = online_learn(features, lable,0.01,'g.');
pt4 = online_learn(features, lable,0.0001,'yx');
pt5 = online_learn(features, lable,0.0001,'k+');
hold off


function  pt = online_learn(X,Y,b0,color)
b = b0;
total_loss = 0;
[num,dim] = size(X);
pt = zeros(num,dim);
iter = 1;% t

a = zeros(num,1);%  a records the sum of pt(i)
    
for i=1:dim
         pt(iter,i) = 1/dim;
end
pt(iter,:)

a(iter)= sum(pt(iter,:));

while iter < num
       
       x = X(iter,:);
       y = Y(iter);
       y_predict = Predict(x,pt(iter,:));
       for i = 1: dim
           %loss =  (x(i) - y)*(x(i) - y)';
           loss =  (x(i) - y)^2;
           loss
           pt(iter+1,i) = pt(iter,i) * exp(-b*loss);        
       end
       iter = iter + 1;
       
       pt(iter,:) = pt(iter,:)/sum(pt(iter,:));
       a(iter) = sum(pt(iter,:));
       
       total_loss = total_loss + (y_predict-y)^2;
       average_loss = total_loss/iter;
       
       plot(iter,average_loss,color);
       
end

end


function y_predict = Predict(x,pt)
    
    y_predict = pt*x';

end