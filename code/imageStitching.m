function [panoImg] = imageStitching(img1, img2, H2to1)
%
% INPUT
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear
%         equation
%
% OUTPUT
% Blends img1 and warped img2 and outputs the panorama image
img2_warped=warpH(img2,H2to1,[size(img2,1),size(img2,2)+size(img1,2)]);
% Initialy while adding the image
% Dont add the overlapped area
for channel = 1:size(img2_warped,3)
    for row = 1:size(img2_warped,1)
        for col = 1:size(img2_warped,2)
            if row <= size(img1,1) && col <=size(img1,2)
                panoImg(row,col,channel)=img1(row,col,channel)+img2_warped(row,col,channel);
                if panoImg(row,col,channel)~=img1(row,col,channel) || panoImg(row,col,channel)~=img2_warped(row,col,channel)
                    panoImg(row,col,channel)= max(img1(row,col,channel),img2_warped(row,col,channel));
                end
            else
                panoImg(row,col,channel)=img2_warped(row,col,channel);
            end
        end
    end
end




end

