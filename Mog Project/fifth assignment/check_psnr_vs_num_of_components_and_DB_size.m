function  psnr = check_psnr_vs_num_of_components_and_DB_size(img_name)
psnr = zeros(6,5);
I = double(rgb2gray(imread(img_name)))/255;
i=0;
for num_comps=1:20:101
    i=i+1;
    j=0;
    for num_patches=1000:25000:101000
    tic
    j=j+1;
    num_comps
    num_patches
    GS  = trainMOG(num_comps,num_patches);
    [dimg,nimg,npsnr,nrmse,dpsnr,drmse,fpsnr,frmse]=testFullImageDenoise(I,GS,25/255);
    psnr(i,j)=dpsnr;
    toc
    end
end

save('psnr_mat.mat','psnr')
surf(psnr)
% imwrite(nimg,'noisy.png');
% 
% axis([-Inf Inf 25 35])
% 
% plot(1:10,psnr,'--rs','LineWidth',2,...
% 'MarkerEdgeColor','k',...
% 'MarkerFaceColor','g',...
% 'MarkerSize',10)
% title('Peppers picture PSNR vs number of components Function');
% xlabel('Components');
% ylabel('PSNR');
