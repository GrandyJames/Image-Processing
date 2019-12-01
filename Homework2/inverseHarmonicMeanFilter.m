function []=inverseHarmonicMeanFilter(fsize,q)
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
        sTemp = double (sImg(i-flength:i+flength,j-flength:j+flength));
        sNewImg(i,j)=sum(sTemp(:).^(q+1))/sum(sTemp(:).^(q));
        gTemp = double (gImg(i-flength:i+flength,j-flength:j+flength));
        gNewImg(i,j)=sum(gTemp(:).^(q+1))/sum(gTemp(:).^(q));
    end
end
subplot(1,2,1);
imshow(sImg),title('��������ͼ��'); 

subplot(1,2,2);
imshow(sNewImg),title('��г����ֵ�˲��������ͼ��'); 
figure();
subplot(1,2,1);
imshow(gImg),title('��˹����ͼ��'); 

subplot(1,2,2);
imshow(gNewImg),title('��г����ֵ�˲��������ͼ��');
end
