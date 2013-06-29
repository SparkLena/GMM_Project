function retval = read_images_in_dir()

% Get list of all BMP files in this directory
% DIR returns as a structure array.  You will need to use () and . to get
% the file names.
imagefiles = dir('*.jpg');
nfiles = length(imagefiles);    % Number of files found
currentimage = imread(imagefiles(1).name);

images=zeros(size(currentimage,1),size(currentimage,2),nfiles);
for ii=1:nfiles
    ii
    currentfilename = imagefiles(ii).name;
    currentimage = imread(currentfilename);
    
    if size(currentimage,1)==size(images,1)
        images(:,:,ii) = im2double(rgb2gray(currentimage));
    else
        images(:,:,ii) = im2double(rgb2gray(currentimage))';
    end
    
    
end
save('images_BSD.mat','images');
end
