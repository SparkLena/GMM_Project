function [x]=reconstMOGavg3d(pii,icov,mus,y,sig_noise,ws)
    d=ws^2;
    [n1,n2,n3]=size(y);
    N=n1*n2;
    indsM=reshape([1:N],n1,n2);
    hws=floor(ws/2);
   
   
    y=reshape(y,N,n3);
    
    pN=(n1-ws+1)*(n2-ws+1);
    yL=zeros(d,n3,pN);
 
    i=0;
    for j1=1:n1-ws+1
       for j2=1:n2-ws+1
           j1u=j1+ws-1; j2u=j2+ws-1;  
           inds=indsM(j1:j1u,j2:j2u);
           inds=inds(:);
           ty=y(inds(:),:);
           i=i+1;
           yL(:,:,i)=ty;
          
       end
    end
    yL=reshape(yL,size(yL,1),size(yL,2)*size(yL,3));
    [exL]=reconstMOGgm(pii,icov,mus,yL,eye(d),sig_noise,d);
    exL=reshape(exL,d,n3,pN);
   
    x=zeros(N,n3);
    xsum=zeros(N,1);
   
    i=0;
    for j1=1:n1-ws+1
       for j2=1:n2-ws+1
           i=i+1;
           j1u=j1+ws-1; j2u=j2+ws-1;  
           inds=indsM(j1:j1u,j2:j2u);
           inds=inds(:);
           
           x(inds(:),:)=x(inds(:),:)+exL(:,:,i);
           xsum(inds(:))= xsum(inds(:))+1;
              
       end
    end
    x=x./repmat(xsum,[1,n3]);
    x=reshape(x,n1,n2,n3);