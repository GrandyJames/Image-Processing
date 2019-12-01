function []=adaptFilter(fsize)
% ��ȡ��ֵΪ0����׼��Ϊ0.1�ĸ�˹����ͼ��
gImg = double(addGaussianNoise(0,0.1));
[imgH,imgW]=size(gImg);
gNewImg = gImg;
% �����˲����ߴ����볤
if mod(fsize,2)
    flength = (fsize-1)/2;
else
    flength = fsize/2;
end

    % ����ͼ�񣬽��������gNewImg
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
imshow(gImg),title('��˹����ͼ��'); 

subplot(1,2,2);
imshow(gNewImg),title('����Ӧ�˲��������ͼ��');
end
