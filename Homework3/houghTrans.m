function []=houghTrans()
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
data=[x;y];  
number=psize+nsize; 
% ����ռ�  
nma=5;
h=zeros(315,2*nma);  
ti=1;  
% �����ֵ 
ma=80; 
for theta=0:0.01:3.14  
    p=[-sin(theta),cos(theta)];  
    d=p*data;  
    for i=1:number  
   %���ڻ���ռ���d�Ƚϴ󣬶�dֵ����������  
    h(ti,round(d(i)/10+nma))=h(ti,round(d(i)/10+nma))+1;  
    end  
    ti=ti+1;  
end  
[tx,p]=find(h>ma);
% ����ֱ������  
lines=size(tx);
% ����ԭ�ؾ���R  
r=(p-nma)*10;
% ��theta��ԭ  
tx=0.01*tx;
x=min(data(:)):0.05:max(data(:));  
% �����������  
    for i=1:40:lines  
        y = tan(tx(i))*x+r(i)/cos(tx(i));
        plot(x,y,'r');  
    end
end

