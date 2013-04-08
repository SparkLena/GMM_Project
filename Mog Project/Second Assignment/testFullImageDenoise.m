function [dimg,nimg,npsnr,nrmse,dpsnr,drmse,fpsnr,frmse]=testFullImageDenoise(img,GS,noiseSTD)
randn('seed',0);

%nimg = imnoise(img,'gaussian',0,noiseSTD^2);
nimg=img + noiseSTD*randn(size(img));
dimg = fullImageDenoise(nimg, GS, noiseSTD);
[npsnr nrmse] = calcpsnr(nimg,img);
[dpsnr drmse] = calcpsnr(dimg,img);
ker=fspecial('gaussian',10,0.85);
fimg = imfilter(nimg, ker, 'replicate');
[fpsnr frmse]=calcpsnr(img,fimg);
fprintf('noisy psnr=%g noisy rmse=%g denoised psnr=%g denoised rmse=%g filtered psnr=%g filtered rmse=%g\n',npsnr,nrmse,dpsnr,drmse,fpsnr,frmse);
[m n]=size(img);
sep = zeros(m,1);
imshow([img sep nimg sep dimg sep fimg]);
collage = [img sep nimg sep dimg sep fimg];

imwrite(collage,'collage.tiff');
imwrite(dimg,'our_denoised.tiff');