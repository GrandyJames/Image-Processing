function []=bi(a)
% aΪ�Ŵ������С�ı���
img=imread('test.png');
method='linear';
[imgH,imgW,nothing]=size(img);
x1=1:1/a:imgW;
y1=1:1/a:imgH;
[x2,y2,z2]=meshgrid(x1,y1,1:3);
% ����ϵͳ����λ���Բ�ֵ
newImg = interp3(double(img),x2,y2,z2,method); 
size(newImg)
imshow(uint8(newImg));
end