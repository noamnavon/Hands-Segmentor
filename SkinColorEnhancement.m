function result = SkinColorEnhancement(frame)
    frame_hsv = rgb2hsv(frame);
    frame_lab = rgb2lab(frame);

    frame_hue = frame_hsv(:,:,1);
    frame_hue = frame_hue + 0.1;
    frame_hue(frame_hue > 1) = 1 - frame_hue(frame_hue > 1);

    frame_sat = frame_hsv(:,:,2);

    frame_val_thresh = double(frame_hsv(:,:,3) > 0.1);

    frame_a = frame_lab(:,:,2);
    frame_a = frame_a - min(frame_a,[],"all");
    frame_a = frame_a/(max(frame_a,[],"all"));

    result = sqrt((1-frame_hue).*(0.5+frame_sat/2).*frame_a.*frame_val_thresh);
end