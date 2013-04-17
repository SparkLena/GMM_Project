function patch_db = harvest_patches(big_patch_db, out_patch_dim)

nPatches = size(big_patch_db,3);

test = im2patch(big_patch_db(:,:,1));
nSmallPatchesInBigPatch = size(test, 2);
out = zeros(out_patch_dim, out_patch_dim, nSmallPatchesInBigPatch * nPatches);

for i=1:nPatches
    tempPatches = im2patch(big_patch_db(:,:,i));
    
    fprintf('One big patch\n');
    for j=1:nSmallPatchesInBigPatch
        p = tempPatches(:,j);
        p = vec2mat(p,out_patch_dim);
        out(:,:,(i-1)*nSmallPatchesInBigPatch + j)= p;
    end   
end

patch_db = out;

save('small_patch_db.mat','patch_db');
     