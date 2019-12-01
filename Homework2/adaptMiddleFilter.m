function []=adaptMiddleFilter(fmax)
% 获取信噪比为0.5的椒盐噪声图像
sImg = double(addSaltNoise(0.5));
% 获取均值为0，标准差为0.1的高斯噪声图像
gImg = double(addGaussianNoise(0,0.1));
[imgH,imgW]=size(sImg);
sNewImg=sImg;
gNewImg=gImg;
% 计算滤波器最大半长
if mod(fmax,2)
    flength = (fmax-1)/2;
else
    flength = fmax/2;
end
% 处理图像，结果分别保存在sNewImg和gNewImg
% zmax为s区域中的灰度最大值
% zmin为s区域中的灰度最小值
% zmed为s区域中的灰度中间值
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
% 处理完后转化为uint8
sImg=uint8(sImg);
sNewImg=uint8(sNewImg);
subplot(1,2,1);
imshow(sImg),title('椒盐噪声图像'); 

subplot(1,2,2);
imshow(sNewImg),title('自适应中值滤波器处理后图像');
gImg=uint8(gImg);
gNewImg=uint8(gNewImg);
figure();
subplot(1,2,1);
imshow(gImg),title('高斯噪声图像'); 

subplot(1,2,2);
imshow(gNewImg),title('自适应中值滤波器处理后图像');
end