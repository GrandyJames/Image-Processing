function []=mPointFilter(fsize)
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
        sNewImg(i,j) = (min(sTemp(:))+max(sTemp(:)))/2;
        gTemp = gImg(i-flength:i+flength,j-flength:j+flength);
        gNewImg(i,j) = (min(gTemp(:))+max(gTemp(:)))/2;
    end
end
subplot(1,2,1);
imshow(sImg),title('��������ͼ��'); 

subplot(1,2,2);
imshow(sNewImg),title('�е��˲��������ͼ��'); 
figure();
subplot(1,2,1);
imshow(gImg),title('��˹����ͼ��'); 

subplot(1,2,2);
imshow(gNewImg),title('�е��˲��������ͼ��');
end
