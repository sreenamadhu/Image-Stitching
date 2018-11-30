function [locs, desc] = briefLite(im)
% INPUTS
% im - gray image with values between 0 and 1
%
% OUTPUTS
% locs - an m x 3 vector, where the first two columns are the image coordinates 
% 		 of keypoints and the third column is the pyramid level of the keypoints
% desc - an m x n bits matrix of stacked BRIEF descriptors. 
%		 m is the number of valid descriptors in the image and will vary
% 		 n is the number of bits for the BRIEF descriptor

load 'parameters.mat'
[locs, GaussianPyramid] = DoGdetector(im, sigma0, k, ...
                                                levels, th_contrast, th_r);

% imshow(im);
% hold on;
% plot(locs(:,1),locs(:,2),'g.','MarkerSize',15);
% hold off;
load testPattern.mat
[locs,desc] = computeBrief(im, GaussianPyramid, locs, k, ...
                                        levels, compareA, compareB);

end