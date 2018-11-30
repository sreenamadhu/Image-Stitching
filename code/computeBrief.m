function [locs,desc] = computeBrief(im, GaussianPyramid, locsDoG, k, ...
                                            levels, compareA, compareB)
    %%Compute BRIEF feature
    % INPUTS
    % im      - a grayscale image with values from 0 to 1
    % locsDoG - locsDoG are the keypoint locations returned by the DoG detector
    % levels  - Gaussian scale levels that were given in Section1
    % compareA and compareB - linear indices into the patchWidth x patchWidth image 
    %                         patch and are each nbits x 1 vectors
    %
    % OUTPUTS
    % locs - an m x 3 vector, where the first two columns are the image coordinates 
    %		 of keypoints and the third column is the pyramid level of the keypoints
    % desc - an m x n bits matrix of stacked BRIEF descriptors. m is the number of 
    %        valid descriptors in the image and will vary


    locs=[];

    %For every keypoint, take a neighbouring 9x9 patch
    % Convert the test pattern into indices, so u will have 256 pairs
    % compute the brief binary strings among these 256 pairs=> 256 bits 
    % Do the same for all keypoints m
    % mxn -> mx256 



    % Caluclating the DoG pyramid....
    [DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels);

    locs = [];
    % Looping over all keypoints......

    num_keypoints=size(locsDoG,1);

    n=1;
    for num = 1: num_keypoints

        r_key=locsDoG(num,2);
        c_key=locsDoG(num,1);
        channel=locsDoG(num,3)+1;
        % temp is the DoG response of the image at that channel
        % Extracting the 9x9 patch around the keypoint
        if ((r_key - 4) > 0) && ((r_key +4) <= size(im,1)) && ((c_key-4) >0) && (c_key +4) <= size(im,2)
             patch=im(r_key-4:r_key+4,c_key-4:c_key+4);

             locs=vertcat(locs,[c_key,r_key,channel-1]);
            % Converting the test pattern to indices

            for i = 1:size(compareA,1)
                [ax,ay]=ind2sub([9,9],compareA(i));
                [bx,by]=ind2sub([9,9],compareB(i));
                if patch(ax,ay) < patch(bx,by)
                   desc(n,i) = 1;

                else 
                    desc(n,i)=0;
                end

            end
            n=n+1;
        end
    end

end
