function [gImg] = addGaussianNoise(avg,std)
img=imread('test.tif');
[imgH,imgW]=size(img);
% ������ͼ��ά����ͬ�����������ӵ�ͼ����
gImg=uint8((double(img)/255+avg+std*randn(imgH,imgW))*255);
% subplot(1,2,1);
% imshow(img),title('ԭʼͼ��'); 
% 
% subplot(1,2,2);
% imshow(gImg),title('��ֵΪ'+string(avg)+'��׼��Ϊ'+string(std)+'�ĸ�˹����ͼ��'); 
