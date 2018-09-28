clear all;clc;
format long e
nlist=[5,10,20,40,80]
count_n=length(nlist)

figure(1)
hold on
title("log(h)-log(Eh)")
Ehlist=zeros(1,count_n);
hlist=zeros(1,count_n)
for z=1:count_n
    n=nlist(z)
    alpha=zeros(1,n);beta=zeros(1,n);gamma=zeros(1,n-1);
    A=zeros(n,n);
    for i=1:n
      for j=1:n
        if j==i
            A(i,j)=2;
        elseif (j-i==-1)||(j-i==1)
            A(i,j)=-1;
        else
            A(i,j)=0;
        end
      end
    end
    alpha=diag(A)'
    gamma=diag(A,1)'
    beta(2:n)=gamma
    
    %diagonal dominant examination
    b=zeros(1,n);
    x=zeros(1,n+1);
    h=1/(n+1)

    for k=1:(n+1)
        x(k)=k*h;
    end
    x
    for k=1:n
        b(k)=(3*x(k)+x(k)^2)*exp(x(k))/(n+1)^2;
    end    
    b

    m=zeros(1,n);phi=m;
    c=zeros(n,1);v=c;

    phi(1)=alpha(1);
    c(1)=b(1);
    for k=2:n
        m(k)=beta(k)/phi(k-1);
        phi(k)=alpha(k)-m(k)*gamma(k-1);
        c(k)=b(k)-m(k)*c(k-1);
    end

    phi
    m
    c

    v(n)= c(n)/phi(n);
    for k=(n-1):-1:1
        v(k)=(c(k)-gamma(k)*v(k+1))/phi(k);
    end
    v

    u=zeros(1,n);
    for k=1:n
        u(k)=x(k)*(1-x(k))*exp(x(k));
    end
    u

    temp=zeros(1,n);
    for k=1:n
        temp(k)=abs(v(k)-u(k));
    end
    h
    temp
    [Eh,p] = max(temp);
    fprintf('%.8f',Eh);
    Ehlist(z)=Eh;
    hlist(z)=h;
end
Ehlist
rateofconvergence=zeros(1,count_n-1);
for k=2:count_n
    rateofconvergence(k-1)=rate(Ehlist(k),Ehlist(k-1),hlist(k),hlist(k-1));
end
rateofconvergence    
plot(log(hlist),log(Ehlist),'r-*');

function [slope]=rate(e1,e2,h1,h2)
slope=(log(e1)-log(e2))/(log(h1)-log(h2));
end

