load data1;

%{
for j=1:21
imshow(frame(j).image);
pause(1);
end;
%}

left = test3(frame(5).image);

figure(6)
imshow(frame(10).image(:,:,2));

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
  
  maxMean1 = 640;
  maxMean2 = 640;
  yMax1 = 0;
  xMax1 = 0;
  yMax2 = 0;
  xMax2 = 0;
  centre = [240,320,0];
  minDis1 = 999999;
  minDis2 = 999999;
  
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
        %{
        maxX = max(frl);
        maxY = max(fcl);
        minX = min(frl);
        minY = min(fcl);
        
        v1 = [maxX, maxY,0];
        v2 = [minX, minY,0];
        distance = point_to_line(centre,v1,v2);
        
        if distance < minDis1
            yMax1 = frl;
            xMax1 = fcl;
            minDis1 = distance;
        else if distance < minDis2
                minDis2 = distance;
                yMax2 = frl;
                xMax2 = fcl;
            en]d
        end
        %}
        
        
        meanY = mean(frl);
        if meanY < maxMean1
            maxMean1 = meanY;
            yMax1 = frl;
            xMax1 = fcl;
        else if meanY < maxMean2
                maxMean2 = meanY;
                yMax2 = frl;
                xMax2 = fcl;
            end
        end
        
    end
  end
  
  figure(5)
  clf
  hold on
  plot(xMax1,yMax1)
  plot(xMax2,yMax2)
  axis([0 640 0 480])
  axis ij