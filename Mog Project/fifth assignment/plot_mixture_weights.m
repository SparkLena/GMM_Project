function x = plot_mixture_weights(GS1,GS2,GS3)

figure; title('Mixture weights for mixtures of different sizes')


p=plot(1:size(GS1.mixweights),sort(GS1.mixweights,'descend'));
set(p,'Color','red','LineWidth',1);
hold on;

p=plot(1:size(GS2.mixweights),sort(GS2.mixweights,'descend'));
set(p,'Color','green','LineWidth',1);
hold on;

p=plot(1:size(GS3.mixweights),sort(GS3.mixweights,'descend'));
set(p,'Color','blue','LineWidth',1);
hold on;
xlabel('component number (sorted)');
ylabel('component weight');
hleg1 = legend('21 components','61 components','101 components');

end
