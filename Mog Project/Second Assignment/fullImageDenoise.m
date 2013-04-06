function [dimg] = fullImageDenoise(img, GS, noiseSTD)

[m n] = size(img);
patches = im2patch(img);
dPatches = zeros(size(patches));

nPatches = size(patches,2);

%for patchIdx = 1:nPatches
%    dPatches(:, patchIdx) = patchmmse(patches(:,patchIdx), GS, noiseSTD);
%end

dPatches = multipatchmmse(patches,GS, noiseSTD);

dimg = patch2im(dPatches, m, n);

end