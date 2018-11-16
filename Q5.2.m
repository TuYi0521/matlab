clc;
clear all;
close all;
Llist = 1:4;

for L = Llist
    h = 2^(-L);
    F = h*ones(2^L-1,1);
    
    A = diag(2*ones(2^L-1,1)) - diag(ones(2^L-2,1),1)- diag(ones(2^L-2,1),-1);
    A = 1/h*A;
    c=(A'*A)^(-1)*(A')*F;

    error(L) = 1/12 - h * sum(c);
end

hList = 2.^(-Llist);
plot(log(hList),log(error));
xlabel('log h');
ylabel('log error');

LinearModel.fit(log(hList)', log(error))

u = zeros(2^L-1,1);
for i=1:(2^L-1)
    u(i)=1/2 * (i*2^(-L)-(i*2^(-L))^2);
end
x = 1:(2^L-1);
x = 2^(-L)*x;
figure;
plot(x,c,'r-*');
hold on;
plot(x,u,'b--');
hold off;
legend('finite element','exact')
