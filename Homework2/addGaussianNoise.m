function [gImg] = addGaussianNoise(avg,std)
img=imread('test.tif');
[imgH,imgW]=size(img);
% 产生和图像维度相同的噪声，叠加到图像上
gImg=uint8((double(img)/255+avg+std*randn(imgH,imgW))*255);
% subplot(1,2,1);
% imshow(img),title('原始图像'); 
% 
% subplot(1,2,2);
% imshow(gImg),title('均值为'+string(avg)+'标准差为'+string(std)+'的高斯噪声图像'); 
