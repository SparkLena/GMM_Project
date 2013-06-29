function h = plot_graphs(psnr_mat)

figure; annotation('textbox', [0 0.9 1 0.1], 'String', 'PSNR vs. num of components and num of patches',  'EdgeColor', 'none',     'HorizontalAlignment', 'center')
num_patches = [1000 26000 51000 76000 101000];
p=plot(num_patches,psnr_mat(1,:),'k-');
hold on;
p=plot(num_patches,psnr_mat(2,:),'k-');
set(p,'Color','red','LineWidth',1)
hold on;
p=plot(num_patches,psnr_mat(3,:),'k-');
set(p,'Color','yellow','LineWidth',1)
hold on;
p=plot(num_patches,psnr_mat(4,:),'k-');
set(p,'Color','blue','LineWidth',1)
hold on;
p=plot(num_patches,psnr_mat(5,:),'k-');
set(p,'Color','green','LineWidth',1)
p=plot(num_patches,psnr_mat(6,:),'k-');
set(p,'Color','magenta','LineWidth',1)
hleg1 = legend('1 component','21 components','41 components','61 components','81 components','101 components');
xlabel('Number of patches we used when learning the MoG');
ylabel('PSNR');


end