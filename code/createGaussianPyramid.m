function [GaussianPyramid] = createGaussianPyramid(im, sigma0, k, levels)
% function [GaussianPyramid] = createGaussianPyramid(im, sigma0, k, levels)
%%Produces Gaussian Pyramid
% inputs
% im - a grayscale image with range 0 to 1
% sigma0 - the standard deviation of the blur at level 0
% k - the multiplicative factor of sigma at each level, where sigma=sigma_0 k^l
% levels - the levels of the pyramid where the blur at each level is
% sigma=sigma0 k^l
% outputs
% A matrix of grayscale images of size (size(im),numel(levels))

im = im2double(im);
if size(im,3)==3
    im= rgb2gray(im);
end

GaussianPyramid = zeros([size(im),length(levels)]);
for i = 1:length(levels)
    sigma_ = sigma0*k^levels(i);
    h = fspecial('gaussian',floor(3*sigma_*2)+1,sigma_);
    
    GaussianPyramid(:,:,i) = imfilter(im,h);
end
end


% Used the optimal kernel size of 3*sigma*2 +1
% Taking radius as 3 sigma gives you more than 97% of the image
% information 
% So, the kernel size would be (3sigma+3sigma) +1 ..as the kernel block
% takes 3 sigma pixels to its left and to its right and the center.