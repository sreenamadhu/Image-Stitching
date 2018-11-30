function [panoImg]=blendimage(img1_warped,img2_warped)


% Initialy while adding the image
% Dont add the overlapped area
for channel = 1:size(img2_warped,3)
    for row = 1:size(img2_warped,1)
        for col = 1:size(img2_warped,2)
            if row <= size(img1_warped,1) && col <=size(img1_warped,2)
                panoImg(row,col,channel)=img1_warped(row,col,channel)+img2_warped(row,col,channel);
                if panoImg(row,col,channel)~=img1_warped(row,col,channel) || panoImg(row,col,channel)~=img2_warped(row,col,channel)
                    panoImg(row,col,channel)= max(img1_warped(row,col,channel),img2_warped(row,col,channel));
                end
            else
                panoImg(row,col,channel)=img2_warped(row,col,channel);
            end
        end
    end
end
end