function [m, dev] = handHSVstats(frame)
    enhanced_skin = SkinColorEnhancement(frame);
    thresh = 1;

    while nnz(enhanced_skin > thresh) < 50000
        thresh = thresh-0.01;
        imshow(uint8(enhanced_skin > thresh).*frame,"InitialMagnification","fit"), drawnow;
    end

    hsv_temp = rgb2hsv(frame);
    hsv_temp(:,:,1) = mod(hsv_temp(:,:,1) + 0.5,1);
    seg_frame = uint8(enhanced_skin > thresh).*uint8(hsv_temp*255);
    h = seg_frame(:,:,1);
    s = seg_frame(:,:,2);
    v = seg_frame(:,:,3);

    m = [mean(h(h ~= 0)) mean(s(s~= 0)) mean(v(v ~= 0))];
    dev = [std(double(h(h ~= 0))) std(double(s(s ~= 0))) std(double(v(v ~= 0)))];
end