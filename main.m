projectFolder = fullfile(fileparts(mfilename('./')), 'data');
addpath(genpath(projectFolder));
disp(['Added ', projectFolder, ' to the path.']);

V = VideoReader('NoamThumbFast.mp4');
disp(V.Name)
frame = readFrame(V);
[m, dev] = handHSVstats(frame)

%   outputVideo = VideoWriter('EnterVideoName.avi');
%   open(outputVideo);

while hasFrame(V)
    frame = readFrame(V);
    seg_hand_bin = SegmentHand(frame, m, dev);
    seg_result_bin = NoiseReduction(seg_hand_bin);
    final_frame = uint8(seg_result_bin).*frame;
    imshow(final_frame,"InitialMagnification","fit"), drawnow;
%       writeVideo(outputVideo,final_frame);
end
%   close(outputVideo);
