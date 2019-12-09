function []=RANSAC()
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
scatter(x,y);
hold on;
data = [x' y']';
number = psize+nsize;
k=0; 
b=0; 
% 最佳匹配的参数
sigma=1;
% 符合拟合模型的数据的个数
pretotal=0;     

for i=1:100
% 随机选择两个点
    idx = randperm(number,2);
    sample = data(:,idx)
% 拟合直线方程 y=kx+b
    x = sample(1, :)
    y = sample(2, :);
% 直线斜率
    k=(y(1)-y(2))/(x(1)-x(2));      
    b = y(1) - k*x(1);
    line = [k -1 b];
% 求每个数据到拟合直线的距离
    mask=abs(line*[data; ones(1,size(data,2))]);
% 计算数据距离直线小于一定阈值的数据的个数
    total=sum(mask<sigma);             
% 找到符合拟合直线数据最多的拟合直线
    if total>pretotal            
        pretotal=total;
        bestline=line;
    end  
end
 
% 最佳拟合的数据
mask=abs(bestline*[data; ones(1,size(data,2))])<sigma;    
k=1;
for i=1:length(mask)
    if mask(i)
        inliers(1,k) = data(1,i);
        k=k+1;
    end
end

% 绘制最佳匹配曲线
k = -bestline(1)/bestline(2);
b = -bestline(3)/bestline(2);
x = min(inliers(1,:)):0.1:max(inliers(1,:));
y = k*x + b;
plot(x,y,'r');
title(['拟合直线为:  y =  ',num2str(k),'x + ',num2str(b)]);