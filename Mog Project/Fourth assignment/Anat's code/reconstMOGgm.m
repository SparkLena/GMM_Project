function [ex,covx]=reconstMOGgm(pii,icov,mus,y,A,sig_noise,d)
 
    sN=size(y,2);
    mN=length(pii);
    ccov=zeros(d,d,mN);
    cov=zeros(d,d,mN);
    ex0j=zeros(d,sN,mN);
    py=zeros(sN,mN);
    for j=1:mN      
      cov(:,:,j)=inv(icov(:,:,j));
    end
    piiL=pii;
    
    
   
    for j=1:mN  
 
      tccov=inv(1/sig_noise^2*eye(d)+icov(:,:,j));
      ccov(:,:,j)=tccov;
      twien=tccov*1/sig_noise^2*eye(d);
  
      ex0j(:,:,j)=twien*y+(-twien*mus(:,j)+mus(:,j))*ones(1,sN);

      tcov= cov(:,:,j)+sig_noise^2*eye(d);
      itcov=inv(tcov);
      [uu,ee]=eig(itcov);
      logdet(j)=sum(log(diag(ee)))/2;
      
      ty=y-repmat(mus(:,j),[1,sN]);
      py(:,j)=sum((itcov*ty).*ty,1)';
      
      %for l=1:sN
      %  py(l,j)=(y(:,l)-mus(:,j))'*itcov*(y(:,l)-mus(:,j));
      %end
      
      
   end

  
  piv=log(piiL(:)')+logdet;

  py=-0.5*py+ones(sN,1)*((piv))  ;
  mpy=max(py,[],2);
  py=py-mpy*ones(1,mN);
  pmg=exp(py);
  pmg=pmg./(sum(pmg,2)*ones(1,mN));

  %ex=zeros(d,sN);
  %for l=1:sN
  %  for j=1:mN
  %    ex(:,l)=ex(:,l)+pmg(l,j)*ex0j(:,l,j);
  %  end
  %end
  %oex=ex;
  ex=zeros(d,sN);
  for i=1:d
      ex(i,:)=ex(i,:)+sum(squeeze(ex0j(i,:,:)).*pmg(:,:),2)';
  end  
  
  
  
  if (nargout>1)
    covx=zeros(d,d,sN);  
    for l=1:sN
      for j=1:mN
        mud=  ex0j(:,l,j)-ex(:,l);
        covx(:,:,l)=covx(:,:,l)+pmg(l,j)*(mud*mud'+ccov(:,:,j));
      end
    end
 
  end
  
  
return

figure, hold on,
cols=['rgbcmky']
for j=1:7
   l=ceil(rand*sN);
   plot(pmg(l,:),cols(j))
    plot(pmg(l,:),[cols(j),'.'])
   
end
keyboard