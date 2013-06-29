function h = sample_from_GS(GS)
covs = GS.covs;
means = GS.means;
mix_weights = GS.mixweights;
patch_size = sqrt(length(means(:,1)));
samples = zeros(patch_size,patch_size,16);
for i=1:16
    samples(:,:,i)=mogrnd(covs,means,mix_weights);
end

figure;
for i=1:2
    for j=1:8
        subplot(2,8,(i-1)*8+j);
        imshow(samples(:,:,(i-1)*8+j),[]);
    end
end

end