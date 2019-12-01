function []=mPointFilter(fsize)
% 获取信噪比为0.5的椒盐噪声图像
sImg = addSaltNoise(0.5);
% 获取均值为0，标准差为0.1的高斯噪声图像
gImg = addGaussianNoise(0,0.1);
[imgH,imgW]=size(sImg);
sNewImg=sImg;
gNewImg=gImg;
% 根据滤波器尺寸计算半长
if mod(fsize,2)
    flength = (fsize-1)/2;
else
    flength = fsize/2;
end
% 处理图像，结果分别保存在sNewImg和gNewImg
for i=1+flength:imgH-flength
    for j=1+flength:imgW-flength
        sTemp = sImg(i-flength:i+flength,j-flength:j+flength);
        sNewImg(i,j) = (min(sTemp(:))+max(sTemp(:)))/2;
        gTemp = gImg(i-flength:i+flength,j-flength:j+flength);
        gNewImg(i,j) = (min(gTemp(:))+max(gTemp(:)))/2;
    end
end
subplot(1,2,1);
imshow(sImg),title('椒盐噪声图像'); 

subplot(1,2,2);
imshow(sNewImg),title('中点滤波器处理后图像'); 
figure();
subplot(1,2,1);
imshow(gImg),title('高斯噪声图像'); 

subplot(1,2,2);
imshow(gNewImg),title('中点滤波器处理后图像');
end
