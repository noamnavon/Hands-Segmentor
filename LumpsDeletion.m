function clean_image = LumpsDeletion(bin_image, mode, lump_size)
    bin_image = xor(mode,bin_image);
    % Find all connected components
    cc = bwconncomp(bin_image, 8); % 8 defines connectivity (neighbors in all directions)
    % Get properties of connected components, specifically 'Area' for their size
    stats = regionprops(cc, 'Area');
    % Identify small components
    smallComponents = find([stats.Area] < lump_size);
    % Create an empty image to mark small components for removal
    toRemove = false(size(bin_image));
    % Mark pixels belonging to small components
    for k = 1:length(smallComponents)
        toRemove(cc.PixelIdxList{smallComponents(k)}) = true;
    end
    % Remove small components by setting marked pixels to 0 (black)
    bin_image(toRemove) = 0;

    clean_image = xor(mode,bin_image);
end