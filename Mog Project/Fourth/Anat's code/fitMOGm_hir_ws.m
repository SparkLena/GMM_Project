function [mus,icov,pii]=fitMOGm_hir_ws(xL,mN,ws)

L=ws-1;    
    

 
 
d=ws^2;
N=size(xL,3);
hws=floor(ws/2)
hxs=ceil(size(xL,1)/2);
%itrsN=30;
itrsN=100;

p=[];
for itr=1:L
    
   tws=itr+1;
   hws1=floor((tws-1)/2)
   hws2=ceil((tws-1)/2)
   
   xL0=xL(hxs-hws1:hxs+hws2,hxs-hws1:hxs+hws2,1:N);
   x=reshape(xL0,tws^2,N);
   %keyboard
   [mus,icov,pii,p]=fitMOGm(x,mN,p,itrsN);
end
