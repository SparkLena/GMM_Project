function x = visualize_learnt_parameters(GS,num_of_leading_singular_vectors)
%
% Gs is a struct that holds the means, weights and the covariance matrices of the 
% learnt mixture
%

covs = GS.covs;
weights = GS.mixweights;
patch_dim = size(covs,1);
num_components = size(covs,3);

%sort the weights array in decending order
 [B,I]=sort(weights,'descend');
 
 %create temp array to hold the results
 res=zeros(8,8,64,num_components);
 
 % for every component get the singular vectors of the covariance matrix
 for i=1:num_components
     k=I(i);
     [U S V]=svd(covs(:,:,k));
     for j=1:patch_dim
         mat=vec2mat(U(:,j),8);
         res(:,:,j,k)=mat;
     end
 end
 
% construct image of leading singualr vectors of each component 
IMG=ones(9*num_of_leading_singular_vectors,9*num_components);
for i=1:num_components    
    for j=1:num_of_leading_singular_vectors;
        %fprintf('Working on i=%d,j=%d',i,j);
        IMG((j-1)*9+2:j*9,(i-1)*9+2:i*9)=res(:,:,j,i);
    end
end
filename_format='Gaussian_mixture_visualization_%d_components_%d_leading_singular_vectors.tiff';
filename = sprintf(filename_format,num_components,num_of_leading_singular_vectors);
imwrite(IMG,filename);
x=IMG;
    

 
 
         