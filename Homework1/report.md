## 图像处理作业1

**姓名：刘焱宁&emsp;&emsp;&emsp; 班级：2017级软工二班&emsp;&emsp;&emsp;学号：3017218100**

1. 使用matlab写一个函数 img=generateFigure（imgW,imgH）,其作用为产生一副彩色图像，图像中用红色显示[0，2\*pi]的正弦波，用绿色显示[0，2\*pi]的余弦波，蓝色显示[0，2\*pi]的y=x^2图像。

   构建如下函数在文件 generateFigure.m 中

   ```matlab
   function [] = generateFigure(imgH ,imgW )
   img = zeros(imgH,imgW,3);
   img = uint8(img);
   % 把图片设置为白色
   img(:,:,1)=255;
   img(:,:,2)=255;
   img(:,:,3)=255;
   % 生成x的0-2*pi数据
   x=0:2*pi/(imgW-1):2*pi;
   % 计算相应的y
   red_y=sin(x);
   green_y=cos(x);
   blue_y=x.^2;
   % 把x映射到图片的宽
   x=int32(x/2/pi*imgW);
   % 把y映射到图片的高
   red_y=int32(imgH/40*39-round(red_y*imgH/40));
   green_y=int32(imgH/40*39-round(green_y*imgH/40));
   blue_y=int32(imgH/40*39-round(blue_y*imgH/40));
   % 遍历数据渲染图片
   for i=1:imgW
       if x(i)==0
           x(i)=x(i)+1;
       end
       if red_y(i)>0 && red_y(i)<=imgH
           img(red_y(i),x(i),2)=0;
           img(red_y(i),x(i),3)=0;
       end
       if green_y(i)>0 && green_y(i)<=imgH
           img(green_y(i),x(i),3)=0;
           img(green_y(i),x(i),1)=0;
       end
       if blue_y(i)>0 && blue_y(i)<=imgH
           img(blue_y(i),x(i),1)=0;
           img(blue_y(i),x(i),2)=0;
       end
   end
   % 绘制黑色坐标轴
   img(:,1,:)=0;
   img(round(imgH/40*39),:,:)=0;
   imshow(img);
   end
   ```

构建的大小为800x600图像如下所示：

[![MGOgKA.md.png](https://s2.ax1x.com/2019/11/13/MGOgKA.md.png)](https://imgchr.com/i/MGOgKA)

2. 不使用for循环，实现bilinear interpolation

测试图片为test.png，把原图片放大二倍

```matlab
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
```

- 原图像

![MGXrd0.png](https://s2.ax1x.com/2019/11/13/MGXrd0.png)

- 放大二倍之后

[![MGXAVx.md.png](https://s2.ax1x.com/2019/11/13/MGXAVx.md.png)](https://imgchr.com/i/MGXAVx)



