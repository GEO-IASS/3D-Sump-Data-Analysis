%1. Create new variable and rename to raw_data
%2. Copy x,y,z point cloud data into variable contents
%3. Run script

%clear window and all variables except for raw_data
clc
clearvars -except raw_data

n = 1;  %resolution of meshgrid

%Extract X, Y, Z as arrays from raw_data matrix
X = abs(raw_data(:,1));
Y = abs(raw_data(:,2));
Z = raw_data(:,3);

%Define meshgrid ranges
xRange = min(X)+n:n:max(X)-n;
yRange = min(Y)+n:n:max(Y)-n;

%Define meshgrid matrices
[Xq,Yq] = meshgrid(xRange, yRange);

%Interpolate Z values on meshgrid
Zq = griddata(X,Y,Z,Xq,Yq, 'cubic');

%Plot surface
figure(1)
set(gcf,'Renderer','painters')
surf(Xq, Yq, Zq);
title('Spread Deck Flatness')
zlim([35 40])

%Plot contour
figure(2)
set(gcf,'Renderer','painters')
contourf(Xq, Yq, Zq, 50);
title('Spread Deck Flatness')
zlim([35 40])

