clc;
clear all;
close all;
% format long e
%%
n=9;
h=1./(n+1);
h4=h.^4;
x1 = linspace ( 0, 1.0, n+2);
y1 = linspace ( 0, 1.0, n+2);

x = x1(2:(n+1));
y = y1(2:(n+1));

v = zeros(n.^2,1);
u = v;
f = v;
A = zeros(n.^2,n.^2);
C = A;

for j=1:n
    for i=1:n
        u(i+(j-1)*n) = sin(pi * x(i)) * y(j) * (exp(y(j)) - exp(1));
        f(i+(j-1)*n) = sin(pi.*x(i)) * (pi.^2 * y(j) * (exp(y(j)) - exp(1)) - (2*exp(y(j)) + y(j) * exp(y(j)))); 
    end   
end

B2 = diag(8*ones(n,1))+ diag(ones(n-1,1),1)+ diag(ones(n-1,1),-1);
I = eye(n,n);
for i=1:n
    for j=1:n
        for k=1:n
            C(n*(i-1)+j,n*(i-1)+k)=B2(j,k);
        end
    end
end

for i=1:(n-1)
    for j=1:n
        for k=1:n
            C(n*(i-1)+j,n*i+k)=I(j,k);
        end
    end
end

for i=1:(n-1)
    for j=1:n
        for k=1:n
            C(n*i+j,n*(i-1)+k)=I(j,k);
        end
    end
end


B1 = diag((-20)*ones(n,1))+ diag(4*ones(n-1,1),1)+ diag(4*ones(n-1,1),-1);
B3 = diag(4*ones(n,1))+ diag(ones(n-1,1),1)+ diag(ones(n-1,1),-1);
for i=1:n
    for j=1:n
        for k=1:n
            A(n*(i-1)+j,n*(i-1)+k)=B1(j,k);
        end
    end
end

for i=1:(n-1)
    for j=1:n
        for k=1:n
            A(n*(i-1)+j,n*i+k)=B3(j,k);
        end
    end
end

for i=1:(n-1)
    for j=1:n
        for k=1:n
            A(n*i+j,n*(i-1)+k)=B3(j,k);
        end
    end
end




A1=A/(6*(h^2));
C1=C/12;

A1_inv=inv(A1);

v=-(A1_inv*C1)*f;
v;

error1 = -A1*u;
error2 =C1*f;
error=max(abs(error1-error2));

Eh=(max(abs(u-v)));
V=zeros(n,n);
U=zeros(n+2,n+2);
for i=1:n
    for j=1:n
       V(i,j)=v((i-1)*n+j);
       U(i+1,j+1)=u((i-1)*n+j);
    end
end

figure;
mesh ( x, y, V);
xlabel ( '<--x-->' );
ylabel ( '<--y-->');
title ('V(x,y)');

figure;
mesh ( x1, y1, U);
xlabel ( '<--x-->' );
ylabel ( '<--y-->');
title ('U(x,y)');

