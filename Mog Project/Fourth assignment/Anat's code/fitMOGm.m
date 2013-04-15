function [mus,icov,pii,p]=fitMOGm(x,mN,p,maxItr,mus,icov,pii,outname)
%
% Fits a MoG to the data in x
% x- is a [patchwidth^2 ]x[number of patches] matrix
% mN is the number of components in the mixture
% maxItr is the maximum iterations number of the EM algorithm
% 


%initialization of the argumenets and params for the EM algorithm
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
       else % 'p' exists
          spc=sum(p,2);
          p=p./(spc*oV);
          mus=x*p';
          cov=zeros(d,d,mN);
          for j1=1:mN
             tx=x.*repmat(p(j1,:).^0.5,[d,1]);
             cov(:,:,j1)=tx*tx';
         
             cov(:,:,j1)=cov(:,:,j1)-mus(:,j1)*mus(:,j1)';
             [u,e]=eig(cov(:,:,j1));
             e=diag(1./max(diag(e),0.1^8));
             icov(:,:,j1)=u*e*u';
          end %for
          pii=spc;
       end % 'p' exists
    end % 'pii'  exists
    if ~exist('maxItr','var')
        maxItr=200;
    end   
    if ~exist('cov','var')
        cov=zeros(d,d,mN);
    end
    
    
    %start EM iterations
    for itr=1:maxItr
      itr
      tic
      %  for all the components
      for j1=1:mN
         % calculate the eigen value decomposition of the j1 inverse
         % covariance matrix
        [u,e]=eig(icov(:,:,j1));
        % calculate the log of the determinant of the j1 inverse covariance matrix
        logdet(j1)=sum(log(abs(diag(e))));
        % hicov is the 'root' of the j1 covariance matrix [ Cholesky decomposition]
        hicov(:,:,j1)=(e.^0.5)*u';
        % calc log likelihood of every patch in x according to Gaussian j1
        logp(j1,:)=-0.5*sum((hicov(:,:,j1)*(x-mus(:,j1*oV))).^2,1)+0.5*logdet(j1)+log(pii(j1));
      end
      
      meanp(itr)=mean(sum(exp(logp),1));
      logpm=max(logp,[],1);
      logp=logp-oVT*logpm;
      
      p=exp(logp); sp=sum(p,1); p=p./(oVT*sp);
      spc=sum(p,2);
      p=p./(spc*oV);
      
      mus=x*p';
      
      for j1=1:mN
        tx=x.*repmat(p(j1,:).^0.5,[d,1]);
        cov(:,:,j1)=tx*tx';
                
        cov(:,:,j1)=cov(:,:,j1)-mus(:,j1)*mus(:,j1)';
        [u,e]=eig(cov(:,:,j1));
        e=diag(1./max(diag(e),0.1^8));
        icov(:,:,j1)=u*e*u';
      end
      
      pii=spc;
      pii=pii/sum(pii);
      toc
      if (mod(itr,10)==0)
          eval(['save ',outname,' mus icov pii']);
      end
      
    end
    
    %Haggai - Save in GS format
    GS.covs=cov;
    GS.mixweights=pii;
    GS.means=mus;
    GS_fname = 'trained_GS_%d_components';
    GS_fname=sprintf(GS_fname,mN);
    save(GS_fname,'GS')

    
    