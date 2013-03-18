load data1;

%{
for j=1:21
imshow(frame(j).image);
pause(1);
end;
%}

left = test3(frame(10).image);

leftr=left;
leftedges = edge(leftr,'canny',[0.08,0.2],3);
[lr,lc] = find(leftedges==1);

% plot edges from left image

figure(1)
plot(lc,lr,'k.')
title('left image edges')
axis([0 640 0 480])
axis ij

figure(13)
title('left image edges found by RANSAC')
clf
%figure(3)
%clf
%plot(lc,lr,'k.')
%axis([0 640 0 480])
%axis ij
%hold on
figure(4)
clf
plot(lc,lr,'k.')
axis([0 640 0 480])
axis ij
hold on
  
  flag = 1;
  sr = lr;
  sc = lc;
  llinecount = 0;
  llinea = zeros(100,2);
  llinem = zeros(100,2);
  llinel = zeros(100,1);
  llineg = zeros(100,1);
  llinet = zeros(100,1);
  llined = zeros(100,1);
  while flag == 1
    [flag,t,d,nr,nc,count,frl,fcl,newcountl] = ransacline(sr,sc,2,0.1,0.01,0.001,80,3);
    if flag == 1 & newcountl > 0 
      pointsleft = size(nr);
      sr = nr;
      sc = nc;
      llinecount = llinecount+1;
      [llinea(llinecount,:),llinem(llinecount,:),llinel(llinecount), ...
            llineg(llinecount)] = descrseg(frl,fcl,leftr,4);
      llinet(llinecount) = t;
      llined(llinecount) = d;
      
       [cr,cc] = plotline(t,d);
       %figure(3)
        %plot(cc,cr)
        figure(4)
        plot(cc,cr)
        title('overlay of left image lines - from RANSAC')
        pause(0.5)    
    end
  end