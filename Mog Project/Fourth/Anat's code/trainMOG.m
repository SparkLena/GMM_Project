load LMSmpPatches21x21g_Big2
N=2;
mN=21;

ws=13;

d=ws^2;
hws1=floor((ws-1)/2)
hws2=ceil((ws-1)/2)

hxs=ceil(size(xL,1)/2);
xL=xL(:,:,1:N);
meanx=mean(mean(mean(xL(hxs-hws1:hxs+hws2,hxs-hws1:hxs+hws2,1:N))))
xL=xL-meanx;
x=xL(hxs-hws1:hxs+hws2,hxs-hws1:hxs+hws2,1:N);
x=reshape(x,d,N);

%%[mus,icov,pii]=fitMOGm(x,mN); 
[mus,icov,pii]=fitMOGm_hir_ws(xL,mN,ws);

