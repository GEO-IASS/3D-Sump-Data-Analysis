clc
clear

import pkg.*

path = 'data\';
file = 'WV34.csv';
filename = strcat(path, file);
numPlanes = 0;
numLines = 0;

%Put this in loop to look at each CSV file in a later commit.

%load file
printer = partData(filename);
n = length(printer.dataset);

for i = 1:n
    %switch .dataset(i).type
    switch lower(printer.dataset(i).type)
        case 'pointcloud'
            numPlanes = numPlanes + 1;
        case 'line'
            numLines = numLines + 1;
        case 'singleparameter'
    end
end

planePlot = ceil(numPlanes/3);
linePlot = ceil(numLines/2);
k = 0;
j = 0;

for i = 1:n
    %switch .dataset(i).type
    switch lower(printer.dataset(i).type)
        case 'pointcloud'
            figure(1)
            k=k+1;
            subplot(3, planePlot, k)
            printer.dataset(i).autoPlane
            colorbar
        case 'line'
            figure(2)
            j=j+1;
            subplot(3, linePlot, j)
            printer.dataset(i).autoLine
        case 'singleparameter'
            %Add to sumTable instance
    end
end