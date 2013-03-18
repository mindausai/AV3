load data1

left = frame(5).XYZ;
leftr=left(:,:,2);
leftedges = edge(leftr,'canny',[0.08,0.2],3);
[lr,lc] = find(leftedges==1);

% plot edges from left image

figure(1)
plot(lc,lr,'k.')
title('left image edges')
axis([0 640 0 480])
axis ij