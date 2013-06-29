function patch_db = harvest_patches_by_num(big_patch_db, out_patch_dim,num_patches_to_harvest)

nPatches = size(big_patch_db,3);

test = im2patch(big_patch_db(:,:,1));
nSmallPatchesInBigPatch = size(test, 2);

final_iter = ceil(num_patches_to_harvest/nSmallPatchesInBigPatch);
out = zeros(out_patch_dim, out_patch_dim, final_iter*nSmallPatchesInBigPatch);
for i=1:final_iter
    i
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
     