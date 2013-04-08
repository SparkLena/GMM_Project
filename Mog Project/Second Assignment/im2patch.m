function out = im2patch(img)

% Comment by Tal
% 2nd comment by Tal

m = size(img,1);
n = size(img,2);

out = zeros(64, (m-7)*(n-7));
patchIdx = 0;

for i=1:m-7
    for j=1:n-7
        patchIdx = patchIdx + 1;
        temp = img(i:i+7, j:j+7);
        out(:, patchIdx) = vec2mat(temp, 1);
    end
end

        
