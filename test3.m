function[channel] = test3(image1)

image2 = image1(:,:,2) < 50 & image1(:,:,2) > 0;

% label all the connected objects in image
[channel,num] = bwlabel(image2,4);
% get the properties of each labeled area
stats = regionprops(channel, 'Area','PixelIdxList','PixelList');

maxArea = -1;

% find the biggest area in image
for m = 1:length(stats)
    area = stats(m).Area;
    if maxArea < area;
        maxArea = area;
    end
end

for reg = 1:length(stats)

    % cut all smaller areas than maximum
    if stats(reg).Area < maxArea
        channel(stats(reg).PixelIdxList) = 0;
    end
end