function  psnr= check_psnr_vs_num_of_components(img_name)
psnr = zeros(1,10);
I = double(rgb2gray(imread(img_name)))/255;
imname_format='%s_denosided_%d_components.png';
for i=1:10
    tic
    i
    GS  = trainMOG(i);
    [dimg,nimg,npsnr,nrmse,dpsnr,drmse,fpsnr,frmse]=testFullImageDenoise(I,GS,25/255);
    psnr(i)=dpsnr
    imname = sprintf(imname_format,img_name,i);
    imwrite(dimg,imname);
    toc
end

imwrite(nimg,'noisy.png');

axis([-Inf Inf 25 35])

plot(1:10,psnr,'--rs','LineWidth',2,...
'MarkerEdgeColor','k',...
'MarkerFaceColor','g',...
'MarkerSize',10)
title('Peppers picture PSNR vs number of components Function');
xlabel('Components');
ylabel('PSNR');
