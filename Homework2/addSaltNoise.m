function [sImg] = addSaltNoise(snr)
img=imread('test.tif');
[imgH,imgW]=size(img);
sImg=img;
% 根据图像信噪比产生噪声点数量
sp=imgH*imgW;
np=sp*(1-snr);
% 随机行列，给图像添加噪声
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
%     imshow(img),title('原始图像'); 
% 
%     subplot(1,2,2);
%     imshow(sImg),title('信噪比为0.5的椒盐噪声图像'); 
end