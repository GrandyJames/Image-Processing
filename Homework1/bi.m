function []=bi(a)
% a为放大或者缩小的倍数
img=imread('test.png');
method='linear';
[imgH,imgW,nothing]=size(img);
x1=1:1/a:imgW;
y1=1:1/a:imgH;
[x2,y2,z2]=meshgrid(x1,y1,1:3);
% 调用系统的三位线性插值
newImg = interp3(double(img),x2,y2,z2,method); 
size(newImg)
imshow(uint8(newImg));
end