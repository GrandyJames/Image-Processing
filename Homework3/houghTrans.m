function []=houghTrans()
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
data=[x;y];  
number=psize+nsize; 
% 霍夫空间  
nma=5;
h=zeros(315,2*nma);  
ti=1;  
% 拟合阈值 
ma=80; 
for theta=0:0.01:3.14  
    p=[-sin(theta),cos(theta)];  
    d=p*data;  
    for i=1:number  
   %由于霍夫空间中d比较大，对d值进行了缩放  
    h(ti,round(d(i)/10+nma))=h(ti,round(d(i)/10+nma))+1;  
    end  
    ti=ti+1;  
end  
[tx,p]=find(h>ma);
% 符合直线条数  
lines=size(tx);
% 将还原回距离R  
r=(p-nma)*10;
% 将theta还原  
tx=0.01*tx;
x=min(data(:)):0.05:max(data(:));  
% 画出拟合曲线  
    for i=1:40:lines  
        y = tan(tx(i))*x+r(i)/cos(tx(i));
        plot(x,y,'r');  
    end
end

