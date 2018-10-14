clc;
clear all;
close all;
%% initiation

% M=[20,40,80,160];
M=40;
Ehlax=zeros(length(M),1);
Ehupwind=zeros(length(M),1);
hlist=zeros(length(M),1);
ratelax=zeros(length(M-1),1);
rateupwind=zeros(length(M-1),1);
for m_index=1:length(M)
    m=M(m_index);
    a = 1.0;
    hlist(m_index)=10.0 / m;
    n = m;
    
    v = zeros ( m+1,n+1 );
    x = linspace ( -5.0, 5.0, m+1 );

    t = linspace ( 0.0, 1.0, n+1 );
    for z=1:(n+1)
        v(1,z)=0;
    end

    %case b
    for i=1:(m+1)
        v(i,1) = f2(x(i));
    end
    vexact=zeros(m+1,n+1);
    for j=1:(n+1)
        for i=1:(m+1)
            vexact(i,j)=f2(x(i)-t(j));
        end
    end

    u=vexact(:,n+1);
%     u=vexact(:,1);
    figure;
    plot(x,u,'r','LineWidth',2);
    s=sprintf('V(x),upwind, m=%d',m);
    title (s);
    hold on;
    v1=lax_wendroff(n,m,v,x,t);
    Eh_lax=max(abs(v1-u));
    Ehlax(m_index)=Eh_lax;
%     v2=upwind(n,m,v,x,t);
%     Eh_up=max(abs(v2-u));
%     Ehupwind(m_index)=Eh_up;

end
%%
for k=2:length(M)
    ratelax(k-1)=rate(Ehlax(k),Ehlax(k-1),hlist(k),hlist(k-1));
    rateupwind(k-1)=rate(Ehupwind(k),Ehupwind(k-1),hlist(k),hlist(k-1));
end
rateupwind
ratelax
figure();
plot(log(hlist),log(Ehlax),'r-*');
%     loglog(log(hlist),log(Ehlax),'r-*');
xlabel ( 'log h' );
ylabel ( 'log Eh');
s=sprintf('lax wendroff numberical errors');
title (s);

LinearModel.fit(log(hlist), log(Ehlax))

% figure;
% % plot(log(hlist),log(Ehlist),'r-*');
% loglog(log(hlist),log(Ehupwind),'r-*');
% xlabel ( 'log h' );
% ylabel ( 'log Eh');
% s=sprintf('upwind numberical errors');
% title (s);

%% LAX-WENDROFF method
function v1 = lax_wendroff (n,m,v,x,t)
k = 1.0 / n; %dt
h = 10.0 / m; %dx
lambda = k./h;
lambda
for j=1:n
    for i=2:m
     v(i,j+1)=v(i,j)+1/2.*lambda.^2*(v(i+1,j)-2*v(i,j)+v(i-1,j))-lambda/2*(v(i+1,j)-v(i-1,j));
%      v(i,j+1)=(lambda*(1+lambda)./2)*v(i-1,j)+(1-lambda.^2)*v(i,j)-1/2*lambda*(1-lambda)*v(i+1,j);
    end
    i=m+1;
    v0=0;
    v(i,j+1)=v(i,j)+1/2.*lambda.^2*(v0-2*v(i,j)+v(i-1,j))-lambda/2*(v0-v(i-1,j));
end
V=v(1:(m+1),n+1);
% V=v(1:(m+1),1);
plot(x,V,'-b*','LineWidth',2);
axis([-5 5 -0.01 1.01])
set(gca, 'FontSize',15);
% hold off;
xlabel ( '<--X-->' );
ylabel ( '<--V-->');
s=sprintf('V(x),lax-wendroff, m=%d',m);
title (s);

% filename = 'lax_wendroff_case1.png';
% %print ( '-dpng', filename );
% fprintf ( 1, '\n' );
% fprintf ( 1, '  Saving plot as "%s".\n', filename );
v1=V;
return
end

function v2=upwind(n,m,v,x,t)
k = 1.0 / n; %dt
h = 10.0 / m; %dx
lambda = k./h;
lambda
for j=1:n
    for i=2:(m+1)
     v(i,j+1)=(1-lambda).*v(i,j)+lambda.*v(i-1,j);
    end
end
V=v(1:(m+1),n+1);
plot(x,V,'--bs','LineWidth',2)
hold off;
xlabel ( '<--X-->' );
ylabel ( '<--V-->');
s=sprintf('V(x),upwind, m=%d',m);
title (s);

% filename = 'upwind_case1.png';
% %print ( '-dpng', filename );
% fprintf ( 1, '\n' );
% fprintf ( 1, '  Saving plot as "%s".\n', filename );
v2=V;
return
end

function [slope]=rate(e1,e2,h1,h2)
slope=(log(e1)-log(e2))/(log(h1)-log(h2));
end

function y = f1(x, p)
    y = ((x + 5) / 10) ^ p * (exp(-x / 5) - 1);
end

function y = f2(x)
    if (x >= -1) && (x <= 1)
        y = 1;
    else
        y = 0;
    end
end