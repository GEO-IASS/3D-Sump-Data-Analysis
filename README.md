# 3D-Sump-Data-Analysis
Script Tools to analyize point cloud CMM data

This program is used to take CMM data (which has been pre-processed to remove extraneous labels and columns), and perform analysis on it.

The main program is specific to a certain part design, but the architecture is meant to be scaleable to any part that is being measured on our CMM. CMMdataset.m and partData.m are meant to be libraries for performing analysis functions on CSV files of part data, and will hopefully serve as building blocks for future metrology work/analysis.

