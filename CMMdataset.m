classdef CMMdataset
   properties
       name
       type
       data
   end
   
   methods
       function Obj = CMMdataset(dataIn)
           Obj.data = dataIn;
       end
       
       function output3D(Obj, plotOutput, type, res)
            switch plotOutput
                case 'Y'    %make Y the dependant variable to plot
                    U = Obj.data(:,1);
                    V = Obj.data(:,3);
                    W = Obj.data(:,2);    
                case 'X'    %make X the dependant variable to plot
                    U = Obj.data(:,3);
                    V = Obj.data(:,1);
                    W = Obj.data(:,2);
                otherwise   %make Z the default dependant variable to plot
                    U = Obj.data(:,1);
                    V = Obj.data(:,2);
                    W = Obj.data(:,3);   
            end
            
            n = (max(U)-min(U))/res;
            m = (max(V)-min(V))/res;
            wMin = min(W);
            wMax = max(W);

            %Define meshgrid ranges
            uRange = min(U)+n:n:max(U)-n;
            vRange = min(V)+m:m:max(V)-m;
            wScale = abs(wMax - wMin)*1.2;
            wRange = [wMin-wScale wMax+wScale];

            %Define meshgrid matrices
            [Xq,Yq] = meshgrid(uRange, vRange);

            %Interpolate Z values on meshgrid
            Zq = griddata(U,V,W,Xq,Yq, 'cubic');

            if strcmp(type,'surf')
                %Plot surface
                set(gcf,'Renderer','painters')
                surf(Xq, Yq, Zq);
                title(Obj.name)
                zlim(wRange)
            elseif strcmp(type,'contour')
                %Plot contour
                set(gcf,'Renderer','painters')
                contourf(Xq, Yq, Zq, 50);
                title(Obj.name)
                zlim(wRange)
            else
               %Plot mesh
                set(gcf,'Renderer','painters')
                mesh(Xq, Yq, Zq);
                title(Obj.name)
                zlim(wRange) 
            end

       end
   end
end

