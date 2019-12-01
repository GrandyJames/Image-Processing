function []=alphaFilter(fsize,d)
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
if d<fsize*fsize
    % ����ͼ�񣬽���ֱ𱣴���sNewImg��gNewImg
    for i=1+flength:imgH-flength
        for j=1+flength:imgW-flength
            
                sTemp = sImg(i-flength:i+flength,j-flength:j+flength);
                sTemp = sort(sTemp(:));
                if d>0
                sTemp=sTemp(d:numel(sTemp)-1);
                end
                sNewImg(i,j)=sum(sTemp())/numel(sTemp);
                gTemp = gImg(i-flength:i+flength,j-flength:j+flength);
                gTemp = sort(gTemp(:));
                if d>0
                gTemp=gTemp(d:numel(gTemp)-1);
                end
                gNewImg(i,j)=sum(gTemp())/numel(gTemp);
        end
    end
else
    fprintf("d�봫��0-fsize^2֮�������");
end
subplot(1,2,1);
imshow(sImg),title('��������ͼ��'); 

subplot(1,2,2);
imshow(sNewImg),title('������İ������˲��������ͼ��'); 
figure();
subplot(1,2,1);
imshow(gImg),title('��˹����ͼ��'); 

subplot(1,2,2);
imshow(gNewImg),title('������İ������˲��������ͼ��');
end
