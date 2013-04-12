function [logL,pcond]=logLikelihood(x,covs,means,weights)
% [logL,pcond]=lik(x,covs,means,weights)
% 
% Compute the log-likelihood of data x under the mixture model
% parametrized with parameters THETA and mixing probabilities P
% 
% Also returns in PCOND(c,i) the conditional probability of x_i under the
% c-th component of the mixture

n=size(x,2); % # of examples
k=size(means,2);
for c=1:k
  pcond(c,:) = conditional(x,covs(:,:,c),means(:,c));
end
llik=log(weights'*pcond);
logL=sum(llik);

