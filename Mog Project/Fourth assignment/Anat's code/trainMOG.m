function GS  = trainMOG(num_components,num_patches)
%
% learns a mixture model from the patches loaded from a file. Learns
% mixtures according to the central patch in each patch supplied with sizes
%  up to ws
%

% load patches
load small_patch_db.mat
%number of patches to be used
N=num_patches;
% number of components in the mixture
mN=num_components;
% maximum size of patch we want to learn
ws=8;
% size of patch calculations for mean removal
hws1=floor((ws-1)/2);
hws2=ceil((ws-1)/2);
% hxs is the center pixel of a patch in xl [if the patch size is 51X51  then it is 25]
hxs=ceil(size(patch_db,1)/2);


% cut the patch database to wanted size
patch_db=patch_db(:,:,1:N);
%calc mean of patches
meanx=mean(mean(mean(patch_db(hxs-hws1:hxs+hws2,hxs-hws1:hxs+hws2,1:N))));
%remove mean
patch_db=patch_db-meanx;
% call a function to learn the mixture params
[mus,icov,cov,pii]=fitMOGm_hir_ws(patch_db,mN,ws);

%Haggai - Save in GS format
GS.covs=cov;
GS.mixweights=pii;
GS.means=mus;
GS_fname = 'trained_GS_%d_componentsand_%d_patches';
GS_fname=sprintf(GS_fname,mN,num_patches);
save(GS_fname,'GS')
