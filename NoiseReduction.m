function seg_result_bin = NoiseReduction(seg_result_bin)
    for i = 1:3
        se = strel('disk',i);
%         imshow(seg_result_bin,"InitialMagnification","fit"), drawnow;
        seg_result_bin = imopen(seg_result_bin,se);
    end
    
    seg_result_bin = LumpsDeletion(seg_result_bin,0,1000);
%     imshow(seg_result_bin,"InitialMagnification","fit"), drawnow;
    
end