clc
clear

import pkg.*

path = 'data\';
file = 'WV5.csv';
filename = strcat(path, file);

WV5 = partData(filename);
