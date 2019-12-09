function []=houImg()
img=imread('test.png');
%  拉普拉斯算子
filter=[0,1,0;1,-4,1;0,1,0];
% 算子大小
fsize=3;
flength = (fsize-1)/2;
% 图像灰度转换
bwImg = double (rgb2gray(img));
[imgH,imgW]=size(bwImg);
id=1;
imshow(bwImg);
% 处理图像，结果保存在gNewImg
for i=1+flength:imgH-flength
    for j=1+flength:imgW-flength
            temp = bwImg(i-flength:i+flength,j-flength:j+flength);
            newImg(i,j)=sum(sum(temp.*filter));
%             记录边缘点坐标
            if newImg(i,j) ~= 0 
                x(id)=i;
                y(id)=j;
                id=id+1;
            end
    end
end
imshow(newImg);
% figure;
% scatter(x,y);
ahold on;
data=[x;y];  
number=size(data,2); 
% 霍夫空间  
nma=20;
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
x=min(data(:)):20:max(data(:));  
% 画出拟合曲线  
    for i=1:80:lines  
        y = tan(tx(i))*x+r(i)/cos(tx(i));
        if max(y)<160 && min(y)>0
          plot(x,y,'r');  
        end
    end
end