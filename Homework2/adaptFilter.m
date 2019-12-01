function []=adaptFilter(fsize)
% 获取均值为0，标准差为0.1的高斯噪声图像
gImg = double(addGaussianNoise(0,0.1));
[imgH,imgW]=size(gImg);
gNewImg = gImg;
% 根据滤波器尺寸计算半长
if mod(fsize,2)
    flength = (fsize-1)/2;
else
    flength = fsize/2;
end

    % 处理图像，结果保存在gNewImg
    for i=1+flength:imgH-flength
        for j=1+flength:imgW-flength
                gTemp = gImg(i-flength:i+flength,j-flength:j+flength);
                avg = mean(gTemp(:));
                v = var(gTemp(:));
                gNewImg(i,j)=gImg(i,j)-255*255*0.01/v*(gImg(i,j)-avg);
        end
    end
gImg = uint8(gImg);
gNewImg=uint8(gNewImg);
figure();
subplot(1,2,1);
imshow(gImg),title('高斯噪声图像'); 

subplot(1,2,2);
imshow(gNewImg),title('自适应滤波器处理后图像');
end
