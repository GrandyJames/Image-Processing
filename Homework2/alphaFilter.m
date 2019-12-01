function []=alphaFilter(fsize,d)
% 获取信噪比为0.5的椒盐噪声图像
sImg = addSaltNoise(0.5);
% 获取均值为0，标准差为0.1的高斯噪声图像
gImg = addGaussianNoise(0,0.1);
[imgH,imgW]=size(sImg);
sNewImg=sImg;
gNewImg=gImg;
% 根据滤波器尺寸计算半长
if mod(fsize,2)
    flength = (fsize-1)/2;
else
    flength = fsize/2;
end
if d<fsize*fsize
    % 处理图像，结果分别保存在sNewImg和gNewImg
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
    fprintf("d请传入0-fsize^2之间的数！");
end
subplot(1,2,1);
imshow(sImg),title('椒盐噪声图像'); 

subplot(1,2,2);
imshow(sNewImg),title('修正后的阿尔法滤波器处理后图像'); 
figure();
subplot(1,2,1);
imshow(gImg),title('高斯噪声图像'); 

subplot(1,2,2);
imshow(gNewImg),title('修正后的阿尔法滤波器处理后图像');
end
