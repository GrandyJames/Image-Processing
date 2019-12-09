function []=leastSquareMethod()
% 数据点集的大小
psize = 100;
% 产生高斯分布数据
x=normrnd(0,0.1,1,psize);
% 原曲线为y=x
y=x;
% 噪声点数量
nsize=20;
% 产生噪声点
noise1=rand(1,nsize)*(max(x)-min(x))+min(x);
noise2=rand(1,nsize)*(max(x)-min(x))+min(x);
% 合并数据
x=[x noise1];
y=[y noise2];
scatter(x,y);hold on;
% 最小二乘法的系数设置
    a = x*x';
    b = sum(x);
    c = x*y';
    d = sum(y);
% 求解斜率k
k = (length(x).*c-b*d)./(length(x).*a-b*b)
% 求解截距t
t = (a.*d-c.*b)/(a*length(x)-b.*b)
y2=x*k+t;
plot(x,y2,'r');
title(['拟合直线为:  y =  ',num2str(k),'x + ',num2str(t)]);
