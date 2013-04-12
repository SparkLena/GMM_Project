function [covs,means,weights,logL]=runem(x,k,tol,iter)
% [theta,p,logL]=runem(x,k,tol,iter)
% 
% Run EM for a mixture of multivariate Gaussian distributions with K
% components on data X (column observations) with K components.
% TOL: stop after change in log-likelihood falls below this (default
% 1.0)
% ITER: stop after this number of iterations (default INF)
% (Iterations stop when either condition is met)
%
% Uses : estep.m, mstep.m, logLikelihood.m

logL=zeros(100,1);
if (nargin < 3)
  tol=1.0;
end
if (nargin < 4)
  iter=inf;
end

means=unifrnd(0,1,size(x,1),k);
weights=ones(k,1)/k;
[oldlogL,pcond]=logLikelihood(x,theta,weights);

t=0;
while (1)
  t=t+1;
  %fprintf('iteration number %d\n',t);
  %fprintf('excecuting E-step\n');
  post=estep(pcond,weights);
  %fprintf('excecuting M-step\n');
  [covs,means,weights]=mstep(x,post);
  %fprintf('calculating log likelihood and conditional probabilities\n');
  [logL(t),pcond]=logLikelihood(x,covs,means,weights);
  fprintf(2,'EM, iter %d:  %.4f\n',t,logL(t));

  if (logL(t)-oldlogL < tol)
    break;
  elseif (t > iter)
    break;
  end
oldlogL=logL(t);
end
