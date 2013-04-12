function [mus,icov,pii,p]=fitMOGm(x,mN,p,maxItr,mus,icov,pii,outname)

    [d,N]=size(x);
    if ~exist('outname','var')
      outname=sprintf('MOGm_params_d%03d_mN%03d',d,mN)
    end
    oVT=ones(mN,1);
    oV=ones(1,N);
  
    if  (~exist('pii','var'))
       if  (~exist('p','var')|isempty(p))
          norx=sum(x.^2,1);
          [sv,sinds]=sort(norx);
          for j1=1:mN
            ind=sinds(ceil(rand*N*0.1+N*0.9));
            mus(:,j1)=x(:,ind);      
            icov(:,:,j1)=(0.1^3*eye(d));
          end
          pii=ones(mN,1)/mN;
       else
          spc=sum(p,2);
          p=p./(spc*oV);
          mus=x*p';
          cov=zeros(d,d,mN);
          for j1=1:mN
             %for d1=1:d
             %   for d2=1:d
             %      cov(d1,d2,j1)=sum(x(d1,:).*conj(x(d2,:)).*p(j1,:));
             %   end
             %end
             tx=x.*repmat(p(j1,:).^0.5,[d,1]);
             cov(:,:,j1)=tx*tx';
         
             cov(:,:,j1)=cov(:,:,j1)-mus(:,j1)*mus(:,j1)';
             [u,e]=eig(cov(:,:,j1));
             e=diag(1./max(diag(e),0.1^8));
             icov(:,:,j1)=u*e*u';
          end
          pii=spc;
       end
    end
    if ~exist('maxItr','var')
        maxItr=200;
    end   
    if ~exist('cov','var')
        cov=zeros(d,d,mN);
    end
    
    for itr=1:maxItr
      itr
      tic
      for j1=1:mN
        [u,e]=eig(icov(:,:,j1));
        logdet(j1)=sum(log(abs(diag(e))));
        hicov(:,:,j1)=(e.^0.5)*u';
        logp(j1,:)=-0.5*sum((hicov(:,:,j1)*(x-mus(:,j1*oV))).^2,1)+0.5*logdet(j1)+log(pii(j1));
        
      end
      
      meanp(itr)=mean(sum(exp(logp),1))
      logpm=max(logp,[],1);
      logp=logp-oVT*logpm;
      
      p=exp(logp); sp=sum(p,1); p=p./(oVT*sp);
      spc=sum(p,2);
      p=p./(spc*oV);
      
      mus=x*p';
      
      for j1=1:mN
        %tic  
        %for d1=1:d
        %  for d2=1:d
        %    cov(d1,d2,j1)=sum(x(d1,:).*conj(x(d2,:)).*p(j1,:));%/spc(j1);
        %  end
        %end
        %toc
        tx=x.*repmat(p(j1,:).^0.5,[d,1]);
        cov(:,:,j1)=tx*tx';
                
        cov(:,:,j1)=cov(:,:,j1)-mus(:,j1)*mus(:,j1)';
        [u,e]=eig(cov(:,:,j1));
        e=diag(1./max(diag(e),0.1^8));
        icov(:,:,j1)=u*e*u';
        %j1
        %max(abs(imag(u(:))))
        %max(abs(imag(e(:))))
        
      end
      
      pii=spc;
      pii=pii/sum(pii);
      toc
      if (mod(itr,10)==0)
          eval(['save ',outname,' mus icov pii'])
      end
      
    end
    
    