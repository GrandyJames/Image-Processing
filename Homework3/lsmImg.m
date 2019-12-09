function []=lsmImg()
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
% scatter(x,y);
hold on;

for i=20:20:400
    x1=x(:,i-19:i);
    y1=y(:,i-19:i);
    % 最小二乘法的系数设置
    a = x1*x1';
    b = sum(x1);
    c = x1*y1';
    d = sum(y1);
    % 求解斜率k
    k = (length(x1).*c-b*d)./(length(x1).*a-b*b);
    % 求解截距t
    t = (a.*d-c.*b)/(a*length(x1)-b.*b);
    y1=x1*k+t;
    plot(x1,y1,'r');
end