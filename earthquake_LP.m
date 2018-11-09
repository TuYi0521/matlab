A=zeros(3,2)
X=zeros(2,1)
b=zeros(3,1)

x0=100
y0=-300
cos_a=zeros(3,1);
cos_b=zeros(3,1);
x=[0,150,630];
y=[0,0,0];
t=[0.125,0.10,0.26];
for j=1:3
    for i=1:3
        cos_a(i)= (x(i)-x0)/sqrt((y(i)-y0)^2+(x(i)-x0)^2);
        cos_b(i)= (y(i)-y0)/sqrt((y(i)-y0)^2+(x(i)-x0)^2);
        b(i)=-sqrt((y(i)-y0)^2+(x(i)-x0)^2)/2000+t(i);
    end
    A=[-cos_a/2000,-cos_b/2000];
    size(A);
    X=(A'*A)^(-1)*(A')*b;
    x0=x0+X(1);
    y0=y0+X(2);
end
x0
y0