load LMSmpPatches21x21g_Big2

N=500000;
mN=21;

ws=11
d=ws^2;
hws1=floor((ws-1)/2)
hws2=ceil((ws-1)/2)

hxs=ceil(size(xL,1)/2);
xL=xL(:,:,1:N);
meanx=mean(mean(mean(xL(hxs-hws1:hxs+hws2,hxs-hws1:hxs+hws2,1:N))))
xL=xL-meanx;
x=xL(hxs-hws1:hxs+hws2,hxs-hws1:hxs+hws2,1:N);
x=reshape(x,d,N);


outname=sprintf('MOGm_params_d%03d_mN%03d',d,mN)
eval(['load ',outname]) 

xcov=x*x'/N;
xcov0=zeros(d,d);
for j=1:mN
    xcov0=xcov0+pii(j)*inv(icov(:,:,j));
end

x0L=xL;
x0=x;

sN=2000;
%sN=100;
%sN=500;

dirname{1}='LM_ExmpDg_pws9x9_noise0729',
dirname{2}='LM_ExmpDg_pws13x13_noise2187'
dirname{3}='LM_ExmpDg_pws21x21_noise6561',

load LMSmpPatches21x21g_wide 
valid_inds=find(~empty_inds);
bxL=xL;
err0=[]; err0L=[]; err3=[]; err4=[]; err6=[]; err9=[];

for ind=3%1:3
eval(sprintf('load %s/noisyData',dirname{ind})) 
sig_noise

xL=bxL(:,:,1:sN);
hxs=ceil(size(xL,1)/2);
hsxs=floor(size(yL,1)/2);
oyL=yL; yL=xL+sig_noise*randn(size(xL)); 
yL(hxs-hsxs:hxs+hsxs,hxs-hsxs:hxs+hsxs,1:sN)=oyL(:,:,1:sN);

xL0=xL-meanx;
yL0=yL-meanx;
xL=xL(hxs-hws1:hxs+hws2,hxs-hws1:hxs+hws2,1:sN);
yL=yL(hxs-hws1:hxs+hws2,hxs-hws1:hxs+hws2,1:sN);
x=reshape(xL,d,sN)-meanx;
y=reshape(yL,d,sN)-meanx;

winM=1/sig_noise^2*inv(1/sig_noise^2*eye(d)+inv(xcov));

%reconstroction using central pixel approach
ex1=reconstMOGgm(pii,icov,mus,y,eye(d),sig_noise,d);
%Wiener filter reconstruction
ex2=winM*y;

stp=100;
'start ex6'
%reconstroction using patch avaraging 
%split to 100 patche blocks because of memory problems
for j=1:stp:sN
   j  
   tic
   ex6(:,:,j:j+stp-1)=reconstMOGavg3d(pii,icov,mus,yL0(:,:,j:j+stp-1),sig_noise,ws);
   toc
end

'start ex9'
%reconstroction using EPLL 
%split to 100 patche blocks because of memory problems
for j=1:stp:sN
    j
    tic
    ex9(:,:,j:j+stp-1)=reconstMOGrob3d(pii,icov,mus,yL0(:,:,j:j+stp-1),sig_noise,ws,20,ex6(:,:,j:j+stp-1));
    toc
end

ci=hws1*ws+hws1+1

err1(ind)=mean((ex1(ci,valid_inds)-x(ci,valid_inds)).^2)
err2(ind)=mean((ex2(ci,valid_inds)-x(ci,valid_inds)).^2)

ci0=ceil(size(yL0,1)/2)

err6(ind)=mean((ex6(ci0,ci0,valid_inds)-xL0(ci0,ci0,valid_inds)).^2)
err9(ind)=mean((ex9(ci0,ci0,valid_inds)-xL0(ci0,ci0,valid_inds)).^2)

%keyboard

eval(sprintf('load %s/evalRespp',dirname{ind})) 
if (length(er1)>=(ws-2))
err0(ind)=er1(ws-2)
err0L(ind)=v1(ws-2)
end
eval(sprintf('save testFitMOGresb_ws%02d_ind%02d err0 err0L err1 err2 err3 err4 err6 err9',ws,ind))
end

10*log10(err1./err0)

10*log10(err2./err0)
10*log10(err6./err0)

10*log10(err9./err0)

