function [sImg] = addSaltNoise(snr)
img=imread('test.tif');
[imgH,imgW]=size(img);
sImg=img;
% ����ͼ������Ȳ�������������
sp=imgH*imgW;
np=sp*(1-snr);
% ������У���ͼ���������
    for i=1:np
        x=uint32(rand()*imgH);
        y=uint32(rand()*imgW);
        if x && y
            r=rand()>0.5;
            if r
                sImg(x,y)=0;
            else
                sImg(x,y)=255;
            end
        end
    end
%     subplot(1,2,1);
%     imshow(img),title('ԭʼͼ��'); 
% 
%     subplot(1,2,2);
%     imshow(sImg),title('�����Ϊ0.5�Ľ�������ͼ��'); 
end