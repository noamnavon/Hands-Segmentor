function seg_hand_bin = SegmentHand(frame, m, dev)
    enhanced_skin = SkinColorEnhancement(frame);
    
    
    
    thresh = 0.1;
    while true
        hsv_temp = rgb2hsv(frame);
        hsv_temp(:,:,1) = mod(hsv_temp(:,:,1) + 0.5,1);
        seg_frame = uint8(enhanced_skin > thresh).*uint8(hsv_temp*255);
        
        h = seg_frame(:,:,1);
        s = seg_frame(:,:,2);
        v = seg_frame(:,:,3);
        m1 = [mean(h(h ~= 0)) mean(s(s ~= 0)) mean(v(v ~= 0))];
        dev1 = [std(double(h(h ~= 0))) std(double(s(s ~= 0))) std(double(v(v ~= 0)))];

        % mean allowed error = (8, dev(2), Not playing a role) 
        % std allowed error = (5, 18, 30)
        if all(abs(m1 - m) < [8, dev(2), 1000]) && all(abs(dev1 - dev) < [5, 18*(14^3)/(dev(2)^3), 10])
            break
        end
        thresh = thresh + 0.02;
    end
    seg_hand_bin = enhanced_skin > thresh;
end