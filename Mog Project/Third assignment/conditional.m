function pcond=conditional(x,cov,mean)
% pcond=conditional(x,cov,means)
%
% Compute conditional p(x|cov,mean). Returns a row-vector.

% if (size(x,2)==1 & size(theta,2)>1)
%   x=repmat(x,1,size(theta,2));
% elseif (size(x,2)>1 & size(theta,2)==1)
%   theta=repmat(theta,1,size(x,2));
% end

pcond=mvnpdf(x',mean,cov);
