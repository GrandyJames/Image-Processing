function []=RANSAC()
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
scatter(x,y);
hold on;
data = [x' y']';
number = psize+nsize;
k=0; 
b=0; 
% ���ƥ��Ĳ���
sigma=1;
% �������ģ�͵����ݵĸ���
pretotal=0;     

for i=1:100
% ���ѡ��������
    idx = randperm(number,2);
    sample = data(:,idx)
% ���ֱ�߷��� y=kx+b
    x = sample(1, :)
    y = sample(2, :);
% ֱ��б��
    k=(y(1)-y(2))/(x(1)-x(2));      
    b = y(1) - k*x(1);
    line = [k -1 b];
% ��ÿ�����ݵ����ֱ�ߵľ���
    mask=abs(line*[data; ones(1,size(data,2))]);
% �������ݾ���ֱ��С��һ����ֵ�����ݵĸ���
    total=sum(mask<sigma);             
% �ҵ��������ֱ�������������ֱ��
    if total>pretotal            
        pretotal=total;
        bestline=line;
    end  
end
 
% �����ϵ�����
mask=abs(bestline*[data; ones(1,size(data,2))])<sigma;    
k=1;
for i=1:length(mask)
    if mask(i)
        inliers(1,k) = data(1,i);
        k=k+1;
    end
end

% �������ƥ������
k = -bestline(1)/bestline(2);
b = -bestline(3)/bestline(2);
x = min(inliers(1,:)):0.1:max(inliers(1,:));
y = k*x + b;
plot(x,y,'r');
title(['���ֱ��Ϊ:  y =  ',num2str(k),'x + ',num2str(b)]);