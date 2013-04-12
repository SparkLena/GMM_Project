function [x]=reconstMOGrob3d(pii,icov,mus,y,sig_noise,ws,itrN,x)
    d=ws^2;
    [n1,n2,n3]=size(y);
    N=n1*n2;
    indsM=reshape([1:N],n1,n2);
    hws=floor(ws/2);
   
    if ~exist('x','var')
       x=y;
    end
    if (~exist('itrN','var'))
        itrN=20;
    end
    x=reshape(x,N,n3);
    y=reshape(y,N,n3);
    
    pN=(n1-ws+1)*(n2-ws+1);
    
    b=0.5; scl=2;
    for itr=1:itrN
        i=0;
        xL=zeros(d,n3,pN);
        for j1=1:n1-ws+1
           for j2=1:n2-ws+1
               j1u=j1+ws-1; j2u=j2+ws-1;  
               inds=indsM(j1:j1u,j2:j2u);
               inds=inds(:);
               tx=x(inds(:),:);
               i=i+1;
               xL(:,:,i)=tx;
           end
        end
        %bw=1/sqrt(d*b);
        bw=1/sqrt(2*b);
        xL=reshape(xL,size(xL,1),size(xL,2)*size(xL,3));
        %tic
        [exL]=reconstMOGgm(pii,icov,mus,xL,eye(d),bw,d);
        %toc
        exL=reshape(exL,size(exL,1),n3,pN);
        x=(d/2)/sig_noise^2*y;
        xsum=(d/2)/sig_noise^2*ones(N,1);
   
        i=0;
        for j1=1:n1-ws+1
           for j2=1:n2-ws+1
               i=i+1;
               j1u=j1+ws-1; j2u=j2+ws-1;  
               inds=indsM(j1:j1u,j2:j2u);
               inds=inds(:);
             
               x(inds(:),:)=x(inds(:),:)+b*exL(:,:,i);
               xsum(inds(:))= xsum(inds(:))+b;           
           end
        end
        x=x./repmat(xsum,[1,n3]);
        b=b*scl;
    end
    
    x=reshape(x,n1,n2,n3);