function locsDoG = getLocalExtrema(DoGPyramid, DoGLevels, ...
                        PrincipalCurvature, th_contrast, th_r)
%%Detecting Extrema
% INPUTS
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
% DoG Levels  - The levels of the pyramid where the blur at each level is
%               outputs
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix contains the
%                      curvature ratio R
% th_contrast - remove any point that is a local extremum but does not have a
%               DoG response magnitude above this threshold
% th_r        - remove any edge-like points that have too large a principal
%               curvature ratio
%
% OUTPUTS
% locsDoG - N x 3 matrix where the DoG pyramid achieves a local extrema in both
%           scale and space, and also satisfies the two thresholds.


   

    %Considering 8 neighbours to detect local extremas -> 3 x 3 block 
    
    locsDoG=[];
    for gauss_num = 1: size(PrincipalCurvature,3)
        % For each DoG filter/Level in the Pyramid......
        PC_response=PrincipalCurvature(:,:,gauss_num);
        DoG_response=DoGPyramid(:,:,gauss_num);
        for i = 2 : size(PrincipalCurvature,1)-1
            for j = 2 :size(PrincipalCurvature,2)-1
                % 3X3 Neighbourhood....
                block = (DoG_response(i-1 : i+1, j-1 : j+1 ));
%                 if gauss_num > 1
%                    block(4,1) =  DoGPyramid(i,j,gauss_num-1);
%                 end
%                 if gauss_num < numel(DoGLevels)
%                     
%                     block(4,2) =  DoGPyramid(i,j,gauss_num+1); 
%                 end
                if gauss_num > 1 && gauss_num < numel(DoGLevels)
                    lower = DoGPyramid(i,j,gauss_num-1);
                    upper = DoGPyramid(i,j,gauss_num+1);
                elseif gauss_num == 1
                    lower = [];
                    upper = DoGPyramid(i,j,gauss_num+1);
                else
                    lower = DoGPyramid(i,j,gauss_num-1);
                    upper = []; 
                end
                %Finding the local extrema...
                all_neighbours = [block(:);lower;upper];
%                 all_neighbours = block(:);
                [max_val,~]=max(all_neighbours);
                
                [min_val,~]=min(all_neighbours);
                if max_val == DoG_response(i,j) || min_val == DoG_response(i,j)
                    if (abs(DoG_response(i,j))> th_contrast && PC_response(i,j) < th_r) 
                        % key [point > theta_c and local extrema
                        locsDoG=vertcat(locsDoG,[j,i,DoGLevels(gauss_num)]);
                        
                        
                    end
                end
            end
        end
        
        
        
        
    end
%     locsDoG=locsDoG(2:end,:);
%     imshow(rgb2gray(im));
%     hold on;
%     plot(locsDoG(:,1),locsDoG(:,2),'g.','MarkerSize',15);


end









