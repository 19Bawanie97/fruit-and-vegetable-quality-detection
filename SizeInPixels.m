function SizeInPixels = SizeInPixels(img)
    obj = imread(img);
    blue = obj(:,:,3);
    bw = imbinarize(blue);
    se = strel('disk',2);
    bw = imopen(bw,se);
    SizeInPixels = sum(bw(:)==0);
end