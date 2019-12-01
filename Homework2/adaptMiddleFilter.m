function []=adaptMiddleFilter(fmax)
% ��ȡ�����Ϊ0.5�Ľ�������ͼ��
sImg = double(addSaltNoise(0.5));
% ��ȡ��ֵΪ0����׼��Ϊ0.1�ĸ�˹����ͼ��
gImg = double(addGaussianNoise(0,0.1));
[imgH,imgW]=size(sImg);
sNewImg=sImg;
gNewImg=gImg;
% �����˲������볤
if mod(fmax,2)
    flength = (fmax-1)/2;
else
    flength = fmax/2;
end
% ����ͼ�񣬽���ֱ𱣴���sNewImg��gNewImg
% zmaxΪs�����еĻҶ����ֵ
% zminΪs�����еĻҶ���Сֵ
% zmedΪs�����еĻҶ��м�ֵ
    for i=1+flength:imgH-flength
        for j=1+flength:imgW-flength
            len = 1;
            while len<=flength
                    sTemp = sImg(i-len:i+len,j-len:j+len);
                    sTemp=sort(sTemp(:));
                    zsmed=sTemp((numel(sTemp)-1)/2);
                    zsmin=min(sTemp);
                    zsmax=max(sTemp);
                    ag1 = zsmed-zsmin;
                    ag2 = zsmed-zsmax;
                if ag1>0 && ag2<0
                    break;
                else 
                    len=len+1;
                end
            end
            if len==flength+1
                sNewImg(i,j)=sImg(i,j);
            else
                bs1=sImg(i,j)-zsmin;
                bs2=sImg(i,j)-zsmax;
                if bs1>0 && bs2<0
                    sNewImg(i,j)=sImg(i,j);
                else
                    sNewImg(i,j)=zsmed;
                end
            end
            len = 1;
            while len<=flength
                    gTemp = gImg(i-len:i+len,j-len:j+len);
                    gTemp=sort(gTemp(:));
                    zgmed=gTemp((numel(gTemp)-1)/2);
                    zgmin=min(gTemp);
                    zgmax=max(gTemp);
                    ag1 = zgmed-zgmin;
                    ag2 = zgmed-zgmax;
                if ag1>0 && ag2<0
                    break;
                else 
                    len=len+1;
                end
            end
            if len==flength+1
                gNewImg(i,j)=gImg(i,j);
            else
                bg1=gImg(i,j)-zgmin;
                bg2=gImg(i,j)-zgmax;
                if bg1>0 && bg2<0
                    gNewImg(i,j)=gImg(i,j);
                else
                    gNewImg(i,j)=zgmed;
                end
            end
        end
    end
% �������ת��Ϊuint8
sImg=uint8(sImg);
sNewImg=uint8(sNewImg);
subplot(1,2,1);
imshow(sImg),title('��������ͼ��'); 

subplot(1,2,2);
imshow(sNewImg),title('����Ӧ��ֵ�˲��������ͼ��');
gImg=uint8(gImg);
gNewImg=uint8(gNewImg);
figure();
subplot(1,2,1);
imshow(gImg),title('��˹����ͼ��'); 

subplot(1,2,2);
imshow(gNewImg),title('����Ӧ��ֵ�˲��������ͼ��');
end