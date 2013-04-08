function post=estep(pcond,weights)
% post=estep(pcond,p)
% 
% Compute posterior of mixture identities p(c|x) given the conditional
% p(x|c) in PCOND and the mixing probabilities p(c) in P.
% Returns in POST(c,i) the posterior p(z_i=c|x_i; theta,p)
% (note: theta are not given to this function, but used to compute PCOND)

[k n]=size(pcond);
post=zeros(k,n);
for i=1:n
    normalization=pcond(:,i)'*weights;
    post(:,i)=pcond(:,i).*weights/normalization;
end

    
    
    