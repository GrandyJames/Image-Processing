function []=leastSquareMethod()
% ���ݵ㼯�Ĵ�С
psize = 100;
% ������˹�ֲ�����
x=normrnd(0,0.1,1,psize);
% ԭ����Ϊy=x
y=x;
% ����������
nsize=20;
% ����������
noise1=rand(1,nsize)*(max(x)-min(x))+min(x);
noise2=rand(1,nsize)*(max(x)-min(x))+min(x);
% �ϲ�����
x=[x noise1];
y=[y noise2];
scatter(x,y);hold on;
% ��С���˷���ϵ������
    a = x*x';
    b = sum(x);
    c = x*y';
    d = sum(y);
% ���б��k
k = (length(x).*c-b*d)./(length(x).*a-b*b)
% ���ؾ�t
t = (a.*d-c.*b)/(a*length(x)-b.*b)
y2=x*k+t;
plot(x,y2,'r');
title(['���ֱ��Ϊ:  y =  ',num2str(k),'x + ',num2str(t)]);
