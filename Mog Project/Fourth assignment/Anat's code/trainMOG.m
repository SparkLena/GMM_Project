function GS  = trainMOG(num_components)
%
% learns a mixture model from the patches loaded from a file. Learns
% mixtures according to the central patch in each patch supplied with sizes
%  up to ws
%

% load patches
load LMSmpPatches21x21g_wide
%number of patches to be used 
N=2000;
% number of components in the mixture
mN=num_components;
% maximum size of patch we want to learn
ws=8;
% size of patch calculations for mean removal
hws1=floor((ws-1)/2);
hws2=ceil((ws-1)/2);
% hxs is the center pixel of a patch in xl [if the patch size is 51X51  then it is 25]
hxs=ceil(size(xL,1)/2);


% cut the patch database to wanted size
xL=xL(:,:,1:N);
%calc mean of patches
meanx=mean(mean(mean(xL(hxs-hws1:hxs+hws2,hxs-hws1:hxs+hws2,1:N))));
%remove mean
xL=xL-meanx;
% call a function to learn the mixture params
[mus,icov,pii,GS]=fitMOGm_hir_ws(xL,mN,ws);


