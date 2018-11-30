function [panoImg] = imageStitching_noClip(img1,img2,H2to1)


% Finding the corners of the img2 and transforming the corners in the
% warping space
corners_img2=[1 size(img2,2) 1 size(img2,2) ; 1 1 size(img2,1) size(img2,1)];
corners_img2(3,:)=[1,1,1,1];
% Warped corners

warped_corners=H2to1*corners_img2;
warped_corners=warped_corners./warped_corners(3,:);

% Finding the width and height

width = max(max(warped_corners(1,:)),size(img1,2)) - min(min(warped_corners(1,:)),1);
height = max(max(warped_corners(2,:)),size(img1,1)) - min(min(warped_corners(2,:)),1);
%Aspect Ratio

aspect_ratio = width/height;

% Outsize Width and Outsize height

outsize_width = size(img1,2)+size(img2,2);
outsize_height = outsize_width/aspect_ratio;

% Scaling and Translational Matrices

%Scaling :

S = [outsize_width/width 0 0 ; 0 outsize_height/height 0 ; 0 0 1];
T = [1 0 -min(1,min(warped_corners(1,:))) ; 0 1 -min(1,min(warped_corners(2,:))) ; 0 0 1];
M=S*T;
warped_img1 = warpH(img1,M,[floor(outsize_height),ceil(outsize_width)]);
warped_img2 = warpH(img2,M*H2to1,[floor(outsize_height),ceil(outsize_width)]);
[panoImg]=blendimage(warped_img1,warped_img2);
end