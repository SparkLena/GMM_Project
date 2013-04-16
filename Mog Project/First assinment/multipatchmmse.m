function xmmse = multipatchmmse(patches,GS,sigma)
[n nPatches] = size(patches);
% remove dc component of each patch
dc = repmat(mean(patches,1),[n 1]);
patches = patches - dc;


xmmse=zeros(size(patches));

weightVec = zeros(length(GS.mixweights), nPatches);

for i=1:numel(GS.mixweights)
    weightVec(i,:) = mvnpdf(patches', GS.means(:,i)',GS.covs(:,:,i)+sigma^2*eye(64))';
end
    
fy=GS.mixweights' * weightVec;

for j=1:length(GS.mixweights)
        w = repmat(GS.means(:,j),[1 nPatches]) +((eye(64)+sigma^2*inv(GS.covs(:,:,j)))\(patches-repmat(GS.means(:,j),[1 nPatches])));
        xmmse = xmmse + GS.mixweights(j) * repmat(weightVec(j,:), [64 1]) .* w;
end

xmmse = xmmse./repmat(fy, [64 1]) + dc;