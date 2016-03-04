clc
clear

import pkg.*

path = 'data\';
file = 'WV5.csv';
filename = strcat(path, file);

dimension = fileReadCMM(filename);

figure(1)
output3D(dimension(1).data, 'Spread Gap', 'surf', 30)

%add additional outputs here