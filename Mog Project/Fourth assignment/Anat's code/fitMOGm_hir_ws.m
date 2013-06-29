function [mus,icov,cov,pii]=fitMOGm_hir_ws(xL,mN,ws)
% learns Gaussian models from patches in xL , with number of components mN,
% up to patch size of ws

% L is the maximum size of patch we want to learn
L=ws-1;    
% N = num of patches in xL
N=size(xL,3);
%
hxs=ceil(size(xL,1)/2);
% number of iterations for each patch size
itrsN=100;
% init p
p=[];
%start iterations on patch sizes
%for itr=1:L
    %  @hack-Haggai to train only one level
 for itr=L:L
   tws=itr+1;
   %calc the sizes of the patches we will use
   hws1=floor((tws-1)/2);
   hws2=ceil((tws-1)/2);
   % generate a database of patches of the appropriate size
   xL0=xL(hxs-hws1:hxs+hws2,hxs-hws1:hxs+hws2,1:N);
   x=reshape(xL0,tws^2,N);
   % call GMM learner on the current patch size
   [mus,icov,cov,pii,p]=fitMOGm(x,mN,p,itrsN);
 end

