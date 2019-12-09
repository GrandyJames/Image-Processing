function []=RANSACImg()
img=imread('test.png');
%  拉普拉斯算子
filter=[0,1,0;1,-4,1;0,1,0];
% 算子大小
fsize=3;
flength = (fsize-1)/2;
% 图像灰度转换
bwImg = double (rgb2gray(img));
[imgH,imgW]=size(bwImg);
p=1;
imshow(bwImg);
% 处理图像，结果保存在gNewImg
for i=1+flength:imgH-flength
    for j=1+flength:imgW-flength
            temp = bwImg(i-flength:i+flength,j-flength:j+flength);
            newImg(i,j)=sum(sum(temp.*filter));
%             记录边缘点坐标
            if newImg(i,j) ~= 0 
                x(p)=i;
                y(p)=j;
                p=p+1;
            end
    end
end
imshow(newImg);
% 对于边缘点拟合曲线
data = [x' y']';
% 显示数据点
% figure;
% scatter(data(1,:),data(2,:));
hold on; 
number = size(data,2);
k=0; 
b=0; 
% 最佳匹配的参数
sigma=1;
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
    if total>25            
        pretotal=total;
        bestline=line;
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
    end  
end
 




