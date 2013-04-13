function [covs,means,weights]=mstep(x,post)
% [covs,means,weights]=mstep(x,post)
%
% Compute covs, means and weights that maximize expected likelihood.
% X(:,i) is the i-th observation
% POST(c,i) is p(c|x_i)
[k n]=size(post);

%calc p
weights = zeros(k,1);
weightsUnNormalized=zeros(size(p));
for c=1:k
    %fprintf('working on class %d\n',c);
    weightsUnNormalized(c)=sum(post(c,:));
    weights(c)=weightsUnNormalized(c)/n;
    %calc means     
    means(:,c)=x*post(c,:)';
    means(:,c)=means(:,c)/weightsUnNormalized(c);
    %calc covs
    
end


