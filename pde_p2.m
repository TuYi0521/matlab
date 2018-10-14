clc;
clear all;
close all;
%% initiation
P=[1,2,3];
for p_index =1:length(P)
    p=P(p_index);
    M=[20,40,80,160];
    % M=100;
    Ehlax=zeros(length(M),1);
    Ehupwind=zeros(length(M),1);
    hlist=zeros(length(M),1);
    ratelax=zeros(length(M-1),1);
    rateupwind=zeros(length(M-1),1);
    for m_index=1:length(M)
        m=M(m_index);
        h = 10.0 / m; %dx
        hlist(m_index)=h;
        n = 1.5*m;
        k = 1.0 / n; %dt
        a = 1.0;
        lambda = k./h;
        lambda

        v = zeros ( m+1,n+1 );
        x = linspace ( -5.0, 5.0, m+1 );

        t = linspace ( 0.0, 1.0, n+1 );
        for z=1:(n+1)
            v(1,z)=0;
        end
        for i=1:(m+1)
            v(i,1) = ((x(i)+5)./10).^p .*(exp(-0.2*x(i))-1);
        end
    %     v(m,1) = ((x(m)+5)./10).^p .*(exp(-0.2*x(m))-1);
        vexact=zeros(m+1,n+1);
        for j=1:(n+1)
            for i=1:(m+1)
                if x(i)-t(j)>=-5
                    vexact(i,j)=((x(i)-t(j)+5)./10).^p .*(exp(-(x(i)-t(j))./5)-1);
                end
            end
        end
        u=vexact(:,n+1);
        figure;
        plot(x,u,'r','LineWidth',2);
        s=sprintf('V(x),upwind, m=%d, p=%d',m,p);
        title (s);
        hold on;
        v1=lax_wendroff(n,m,lambda,v,x,t,p);
        Eh_lax=max(abs(v1-u));
        Ehlax(m_index)=Eh_lax;
    %     v2=upwind(n,m,lambda,v,x,t,p);
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
    s=sprintf('lax wendroff numberical errors, p=%d', p);
    title (s);

    LinearModel.fit(log(hlist), log(Ehlax))

    % figure;
    % % plot(log(hlist),log(Ehlist),'r-*');
    % loglog(log(hlist),log(Ehupwind),'r-*');
    % xlabel ( 'log h' );
    % ylabel ( 'log Eh');
%     s=sprintf('upwind numberical errors, p=%d', p);
%     title (s);
end
%% LAX-WENDROFF method
function v1 = lax_wendroff (n,m,lambda,v,x,t,p)
for j=1:n
    for i=2:m
     v(i,j+1)=v(i,j)+1/2.*lambda.^2*(v(i+1,j)-2*v(i,j)+v(i-1,j))-lambda/2*(v(i+1,j)-v(i-1,j));
%      v(i,j+1)=(lambda*(1+lambda)./2)*v(i-1,j)+(1-lambda.^2)*v(i,j)-1/2*lambda*(1-lambda)*v(i+1,j);
    end
    i=m+1;
    v0=((x(i)+10.0 / m-t(j)+5)./10).^p .*(exp(-(x(i)+10.0 / m-t(j))./5)-1);
    v(i,j+1)=v(i,j)+1/2.*lambda.^2*(v0-2*v(i,j)+v(i-1,j))-lambda/2*(v0-v(i-1,j));
end
V=v(1:(m+1),n+1);
plot(x,V,'b*','LineWidth',2);
% hold off;
xlabel ( '<--X-->' );
ylabel ( '<--V-->');
s=sprintf('V(x),lax-wendroff, m=%d, p=%d',m,p);
title (s);

% filename = 'lax_wendroff_case1.png';
% %print ( '-dpng', filename );
% fprintf ( 1, '\n' );
% fprintf ( 1, '  Saving plot as "%s".\n', filename );
v1=V;
return
end

function v2=upwind(n,m,lambda,v,x,t,p)
for j=1:n
    for i=2:(m+1)
     v(i,j+1)=(1-lambda).*v(i,j)+lambda.*v(i-1,j);
    end
end
V=v(1:(m+1),n+1);
plot(x,V','--bs','LineWidth',2)
hold off;
xlabel ( '<--X-->' );
ylabel ( '<--V-->');
s=sprintf('V(x),upwind, m=%d, p=%d',m,p);
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
