## 图像处理作业2

**姓名：刘焱宁&emsp;&emsp;&emsp; 班级：2017级软工二班&emsp;&emsp;&emsp;学号：3017218100**

### 1）产生噪声

- 构造函数`addSaltNoise.m`，接受参数`snr`为图像信噪比，为实验用图`test.tif`增加椒盐噪声

    ```matlab
    % addSaltNoise.m
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
        subplot(1,2,1);
        imshow(img),title('原始图像'); 

        subplot(1,2,2);
        imshow(sImg),title('信噪比为0.5的椒盐噪声图像'); 
    end
    ```

    信噪比为0.5时的**椒盐噪声**图像，如下图所示：

    ![QeSmIf.png](https://s2.ax1x.com/2019/12/01/QeSmIf.png)

- 构造函数`addGaussianNoise.m`，接受参数avg为均值，std为标准差，为实验用图`test.tif`增加高斯噪声

    ```matlab
    % addGaussianNoise.m
    function [gImg] = addGaussianNoise(avg,std)
    img=imread('test.tif');
    [imgH,imgW]=size(img);
    % 产生和图像维度相同的噪声，叠加到图像上
    gImg=uint8((double(img)/255+avg+std*randn(imgH,imgW))*255);
    % subplot(1,2,1);
    % imshow(img),title('原始图像'); 
    % 
    % subplot(1,2,2);
    % imshow(gImg),title('均值为'+string(avg)+'标准差为'+string(std)+'的高斯噪声图像'); 
    ```

    产生的高斯噪声效果如下图

    ![QeMoo8.png](https://s2.ax1x.com/2019/12/01/QeMoo8.png)

### 2） 均值滤波器

- 算术均值滤波器

  编写函数`meanValueFilter.m`，参数`fsize`为滤波器大小

  ```matlab
  % meanValueFilter.m
  function []=meanValueFilter(fsize)
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
  % 处理图像，结果分别保存在sNewImg和gNewImg
  for i=1+flength:imgH-flength
      for j=1+flength:imgW-flength
          sTemp = sImg(i-flength:i+flength,j-flength:j+flength);
          sNewImg(i,j)=sum(sTemp(:))/numel(sTemp);
          gTemp = gImg(i-flength:i+flength,j-flength:j+flength);
          gNewImg(i,j)=sum(gTemp(:))/numel(gTemp);
      end
  end
  subplot(1,2,1);
  imshow(sImg),title('椒盐噪声图像'); 
  
  subplot(1,2,2);
  imshow(sNewImg),title('均值滤波器处理后图像'); 
  figure();
  subplot(1,2,1);
  imshow(gImg),title('高斯噪声图像'); 
  
  subplot(1,2,2);
  imshow(gNewImg),title('均值滤波器处理后图像');
  end
  ```

  大小为3x3的**算术均值**滤波器处理**椒盐噪声**结果

  ![QeNt7d.png](https://s2.ax1x.com/2019/12/01/QeNt7d.png)

  大小为3x3的**算术均值**滤波器处理**高斯噪声**结果

  ![QeNO41.png](https://s2.ax1x.com/2019/12/01/QeNO41.png)

- 几何均值滤波器

  编写函数`geometricMeanFilter.m`，参数`fsize`为滤波器大小

  ```matlab
  function []=geometricMeanFilter(fsize)
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
  % 处理图像，结果分别保存在sNewImg和gNewImg
  for i=1+flength:imgH-flength
      for j=1+flength:imgW-flength
          sTemp = sImg(i-flength:i+flength,j-flength:j+flength);
          sNewImg(i,j)=prod(prod(sTemp(:)))^(1/numel(sTemp)); 
          gTemp = gImg(i-flength:i+flength,j-flength:j+flength);
          gNewImg(i,j)=prod(prod(gTemp(:)))^(1/numel(gTemp)); 
      end
  end
  subplot(1,2,1);
  imshow(sImg),title('椒盐噪声图像'); 
  
  subplot(1,2,2);
  imshow(sNewImg),title('几何均值滤波器处理后图像'); 
  figure();
  subplot(1,2,1);
  imshow(gImg),title('高斯噪声图像'); 
  
  subplot(1,2,2);
  imshow(gNewImg),title('几何均值滤波器处理后图像');
  end
  ```

  大小为3x3的**几何均值**滤波器处理**椒盐噪声**结果

  ![Qedukj.png](https://s2.ax1x.com/2019/12/01/Qedukj.png)

  大小为3x3的**几何均值**滤波器处理**高斯噪声**结果

  ![QedKts.png](https://s2.ax1x.com/2019/12/01/QedKts.png)

- 谐波均值滤波器

  编写函数`harmonicMeanFilter.m`，参数`fsize`为滤波器大小

  ```matlab
  function []=harmonicMeanFilter(fsize)
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
  % 处理图像，结果分别保存在sNewImg和gNewImg
  for i=1+flength:imgH-flength
      for j=1+flength:imgW-flength
          sTemp = sImg(i-flength:i+flength,j-flength:j+flength);
          sTemp=1./sTemp;
          sNewImg(i,j)=numel(sTemp)/sum(sTemp(:));
          gTemp = gImg(i-flength:i+flength,j-flength:j+flength);
          gTemp=1./gTemp;
          gNewImg(i,j)=numel(gTemp)/sum(gTemp(:));
      end
  end
  subplot(1,2,1);
  imshow(sImg),title('椒盐噪声图像'); 
  
  subplot(1,2,2);
  imshow(sNewImg),title('谐波均值滤波器处理后图像'); 
  figure();
  subplot(1,2,1);
  imshow(gImg),title('高斯噪声图像'); 
  
  subplot(1,2,2);
  imshow(gNewImg),title('谐波均值滤波器处理后图像');
  end
  ```

  大小为3x3的**谐波均值**滤波器处理**椒盐噪声**结果

  ![Qe0AeS.png](https://s2.ax1x.com/2019/12/01/Qe0AeS.png)

  大小为3x3的**谐波均值**滤波器处理**高斯噪声**结果

  ![Qe0FL8.png](https://s2.ax1x.com/2019/12/01/Qe0FL8.png)

- 逆谐波均值滤波器   

  编写函数`inverseHarmonicMeanFilter.m`，参数`fsize`为滤波器大小，q为阶数

  ```matlab
  function []=inverseHarmonicMeanFilter(fsize,q)
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
  % 处理图像，结果分别保存在sNewImg和gNewImg
  for i=1+flength:imgH-flength
      for j=1+flength:imgW-flength
          sTemp = double (sImg(i-flength:i+flength,j-flength:j+flength));
          sNewImg(i,j)=sum(sTemp(:).^(q+1))/sum(sTemp(:).^(q));
          gTemp = double (gImg(i-flength:i+flength,j-flength:j+flength));
          gNewImg(i,j)=sum(gTemp(:).^(q+1))/sum(gTemp(:).^(q));
      end
  end
  subplot(1,2,1);
  imshow(sImg),title('椒盐噪声图像'); 
  
  subplot(1,2,2);
  imshow(sNewImg),title('逆谐波均值滤波器处理后图像'); 
  figure();
  subplot(1,2,1);
  imshow(gImg),title('高斯噪声图像'); 
  
  subplot(1,2,2);
  imshow(gNewImg),title('逆谐波均值滤波器处理后图像');
  end
  ```

  大小为3x3，阶数为1.5的**逆谐波均值**滤波器处理**椒盐噪声**结果

  ![QeDgMt.png](https://s2.ax1x.com/2019/12/01/QeDgMt.png)

  大小为3x3，阶数为1.5的**逆谐波均值**滤波器处理**高斯噪声**结果

  ![QeD2sP.png](https://s2.ax1x.com/2019/12/01/QeD2sP.png)

### 3） 统计排序滤波器

- 中值滤波器

  编写函数`middleFilter.m`，参数`fsize`为滤波器大小

  ```matlab
  function []=middleFilter(fsize)
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
  % 处理图像，结果分别保存在sNewImg和gNewImg
  for i=1+flength:imgH-flength
      for j=1+flength:imgW-flength
          sTemp = sImg(i-flength:i+flength,j-flength:j+flength);
          sTemp = sort(sTemp(:));
          sNewImg(i,j)=sTemp((numel(sTemp)-1)/2);
          gTemp = gImg(i-flength:i+flength,j-flength:j+flength);
          gTemp = sort(gTemp(:));
          gNewImg(i,j)=gTemp((numel(gTemp)-1)/2);
      end
  end
  subplot(1,2,1);
  imshow(sImg),title('椒盐噪声图像'); 
  
  subplot(1,2,2);
  imshow(sNewImg),title('中值滤波器处理后图像'); 
  figure();
  subplot(1,2,1);
  imshow(gImg),title('高斯噪声图像'); 
  
  subplot(1,2,2);
  imshow(gNewImg),title('中值滤波器处理后图像');
  end
  ```

  大小为3x3的**中值**滤波器处理**椒盐噪声**结果

  ![QeHpM6.png](https://s2.ax1x.com/2019/12/01/QeHpM6.png)

  大小为3x3的**中值**滤波器处理**高斯噪声**结果

  ![Qe7zxx.png](https://s2.ax1x.com/2019/12/01/Qe7zxx.png)

- 最大值和最小值滤波器

  - 最大值滤波器

    编写函数`maxFilter.m`，参数`fsize`为滤波器大小

    ```matlab
    function []=maxFilter(fsize)
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
    % 处理图像，结果分别保存在sNewImg和gNewImg
    for i=1+flength:imgH-flength
        for j=1+flength:imgW-flength
            sTemp = sImg(i-flength:i+flength,j-flength:j+flength);
            sNewImg(i,j)= max(sTemp(:));
            gTemp = gImg(i-flength:i+flength,j-flength:j+flength);
            gNewImg(i,j)=max(gTemp(:));
        end
    end
    subplot(1,2,1);
    imshow(sImg),title('椒盐噪声图像'); 
    
    subplot(1,2,2);
    imshow(sNewImg),title('最大值滤波器处理后图像'); 
    figure();
    subplot(1,2,1);
    imshow(gImg),title('高斯噪声图像'); 
    
    subplot(1,2,2);
    imshow(gNewImg),title('最大值滤波器处理后图像');
    end
    ```

    大小为3x3的**最大值**滤波器处理**椒盐噪声**结果

    ![QejKLq.png](https://s2.ax1x.com/2019/12/01/QejKLq.png)

    大小为3x3的**最大值**滤波器处理**高斯噪声**结果

    ![Qej8FU.png](https://s2.ax1x.com/2019/12/01/Qej8FU.png)

  - 最小值滤波器

    编写函数`minFilter.m`，参数`fsize`为滤波器大小
    
    ```matlab
    function []=minFilter(fsize)
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
    % 处理图像，结果分别保存在sNewImg和gNewImg
    for i=1+flength:imgH-flength
        for j=1+flength:imgW-flength
            sTemp = sImg(i-flength:i+flength,j-flength:j+flength);
            sNewImg(i,j) = min(sTemp(:));
            gTemp = gImg(i-flength:i+flength,j-flength:j+flength);
            gNewImg(i,j) = min(gTemp(:));
        end
    end
    subplot(1,2,1);
    imshow(sImg),title('椒盐噪声图像'); 

    subplot(1,2,2);
    imshow(sNewImg),title('最小值滤波器处理后图像'); 
    figure();
    subplot(1,2,1);
    imshow(gImg),title('高斯噪声图像'); 

    subplot(1,2,2);
    imshow(gNewImg),title('最小值滤波器处理后图像');
    end
    ```
    
    大小为3x3的**最小值**滤波器处理**椒盐噪声**结果
    
    ![QejGYF.png](https://s2.ax1x.com/2019/12/01/QejGYF.png)
    
    大小为3x3的**最小值**滤波器处理**高斯噪声**结果
    
    ![QejJW4.png](https://s2.ax1x.com/2019/12/01/QejJW4.png)

- 中点滤波器

  编写函数`mPointFilter.m`，参数`fsize`为滤波器大小

  ```matlab
  function []=mPointFilter(fsize)
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
  % 处理图像，结果分别保存在sNewImg和gNewImg
  for i=1+flength:imgH-flength
      for j=1+flength:imgW-flength
          sTemp = sImg(i-flength:i+flength,j-flength:j+flength);
          sNewImg(i,j) = (min(sTemp(:))+max(sTemp(:)))/2;
          gTemp = gImg(i-flength:i+flength,j-flength:j+flength);
          gNewImg(i,j) = (min(gTemp(:))+max(gTemp(:)))/2;
      end
  end
  subplot(1,2,1);
  imshow(sImg),title('椒盐噪声图像'); 
  
  subplot(1,2,2);
  imshow(sNewImg),title('中点滤波器处理后图像'); 
  figure();
  subplot(1,2,1);
  imshow(gImg),title('高斯噪声图像'); 
  
  subplot(1,2,2);
  imshow(gNewImg),title('中点滤波器处理后图像');
  end
  ```

  大小为3x3的**中点**滤波器处理**椒盐噪声**结果

  ![QejtSJ.png](https://s2.ax1x.com/2019/12/01/QejtSJ.png)

  大小为3x3的**中点**滤波器处理**高斯噪声**结果

  ![QejlwV.png](https://s2.ax1x.com/2019/12/01/QejlwV.png)

- 修正后的阿尔法均值滤波器

  编写函数`alphaFilter.m`，参数`fsize`为滤波器大小，d为0-fsize^2之间的数字

  ```matlab
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
              if d>0
                  sTemp = sImg(i-flength:i+flength,j-flength:j+flength);
                  sTemp = sort(sTemp(:));
                  sTemp=sTemp(d:numel(sTemp)-1);
                  sNewImg(i,j)=sum(sTemp())/numel(sTemp);
                  gTemp = gImg(i-flength:i+flength,j-flength:j+flength);
                  gTemp = sort(gTemp(:));
                  gTemp=gTemp(d:numel(gTemp)-1);
                  gNewImg(i,j)=sum(gTemp())/numel(gTemp);
              end
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
  ```

  大小为3x3的**修正后的阿尔法均值**滤波器（d=1）处理**椒盐噪声**结果

  ![QejQe0.png](https://s2.ax1x.com/2019/12/01/QejQe0.png)

  大小为3x3的**修正后的阿尔法均值**滤波器（d=1）处理**高斯噪声**结果

  ![Qej1oT.png](https://s2.ax1x.com/2019/12/01/Qej1oT.png)

### 4） 自适应滤波器

- 自适应滤波器

  编写函数`alphaFilter.m`，参数`fsize`为滤波器大小

  ```matlab
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
  ```

  大小为7x7的**自适应**滤波器处理，方差为6502.5的**高斯噪声**结果

  ![Qm0Cj0.png](https://s2.ax1x.com/2019/12/01/Qm0Cj0.png)

- 自适应中值滤波器

  编写函数`alphaFilter.m`，参数`fmax`为滤波器最大尺寸

  ```matlab
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
  ```

  最大尺寸为7x7的**自适应**滤波器处理**椒盐噪声**结果

  ![Qm0kHU.png](https://s2.ax1x.com/2019/12/01/Qm0kHU.png)

  最大尺寸为7x7的**自适应**滤波器处理**高斯噪声**结果

  ![Qm0EEF.png](https://s2.ax1x.com/2019/12/01/Qm0EEF.png)
