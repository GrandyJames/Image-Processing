function []=geometricMeanFilter(fsize)
% ��ȡ�����Ϊ0.5�Ľ�������ͼ��
sImg = addSaltNoise(0.5);
% ��ȡ��ֵΪ0����׼��Ϊ0.1�ĸ�˹����ͼ��
gImg = addGaussianNoise(0,0.1);
[imgH,imgW]=size(sImg);
sNewImg=sImg;
gNewImg=gImg;
% �����˲����ߴ����볤
if mod(fsize,2)
    flength = (fsize-1)/2;
else
    flength = fsize/2;
end
% ����ͼ�񣬽���ֱ𱣴���sNewImg��gNewImg
for i=1+flength:imgH-flength
    for j=1+flength:imgW-flength
        sTemp = sImg(i-flength:i+flength,j-flength:j+flength);
        sNewImg(i,j)=prod(prod(sTemp(:)))^(1/numel(sTemp)); 
        gTemp = gImg(i-flength:i+flength,j-flength:j+flength);
        gNewImg(i,j)=prod(prod(gTemp(:)))^(1/numel(gTemp)); 
    end
end
subplot(1,2,1);
imshow(sImg),title('��������ͼ��'); 

subplot(1,2,2);
imshow(sNewImg),title('���ξ�ֵ�˲���������ͼ��'); 
figure();
subplot(1,2,1);
imshow(gImg),title('��˹����ͼ��'); 

subplot(1,2,2);
imshow(gNewImg),title('���ξ�ֵ�˲���������ͼ��');
end