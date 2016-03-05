classdef partData
    %PARTDATA Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        SN
        dataset
    end
    
    methods
        function Obj = partData(filename)
        %initial conditions
            load = 0;
            run = 1;
            n = 1;
            i = 1;
            z = 1;
            
            fileID = fopen(filename);
            C = textscan(fileID, '%s %f %f %f', 'Delimiter', [',' '\n']);
            M = [C{2},C{3},C{4}];
            V = C{1};
            [x, y] = size(M);

            while i<=(x-3)
                dimension(n) = CMMdataset([]);     %Create new dataset instance
                dimension(n).name = V{i};
                dimension(n).type = V{i+1};
                i = i+2;
                %Check if row is start or end of dataset
                importOn = 1;
                while importOn == 1 

                    %if end of dataset, don't import and move to next row
                    if isnan(M(i,1))
                        importOn = 0;
                        n = n + 1;
                        z = 1;
                    %if row is part of dataset to import, scan row and add to dimension(n).data    
                    else
                        collectrow = 1;
                        j = 1;
                        %scan row and add to dimension(n).data
                        while (collectrow == 1) && (j<=3)
                            if isnan(M(i,j))
                                collectrow = 0;
                            else
                                dimension(n).data(z,j) = M(i,j);
                                j=j+1;
                            end
                        end

                        %increment to next row
                        i = i + 1;
                        z = z + 1;
                    end
                end
            end

            Obj.dataset = dimension;
        end    
           
    end
    
end

