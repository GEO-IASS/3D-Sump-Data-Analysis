function A = fileReadCMM(filename)

    %initial conditions
    load = 0;
    run = 1;
    n = 1;
    i = 1;
    z = 1;

    M = csvread(filename);
    [x, y] = size(M);

    while i<=x
        dimension(n) = CMMdataset;     %Create new dataset instance

        %Check if row is start or end of dataset
        importOn = 1;
        while importOn == 1 

            %if end of dataset, don't import and move to next row
            if M(i,1)==0
                importOn = 0;
                i = i + 1;
                n = n + 1;
                z = 1;
            %if row is part of dataset to import, scan row and add to dimension(n).data    
            else
                collectrow = 1;
                j = 1;
                %scan row and add to dimension(n).data
                while collectrow == 1
                    if M(i,j)==0
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
    
    A = dimension;
end