clc
clear

import pkg.*

path = 'data\';
file = 'WV5.csv';
filename = strcat(path, file);

%Put this in loop to look at each CSV file in a later commit.

%load file
printer = partData(filename);
n = length(printer.dataset);

for i = 1:n
    %switch .dataset(i).type
    switch lower(dataset(i).type)
        case 'pointcloud'

        case 'line'

        case 'singleparameter'
            
    end

end