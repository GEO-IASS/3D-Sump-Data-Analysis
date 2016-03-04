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
       
       function output3D(Obj, name, type, res)
            X = abs(Obj.data(:,1));
            Y = abs(Obj.data(:,2));
            Z = Obj.data(:,3);

            n = (max(X)-min(X))/res;
            m = (max(Y)-min(Y))/res;

            %Define meshgrid ranges
            xRange = min(X)+n:n:max(X)-n;
            yRange = min(Y)+m:m:max(Y)-m;
            zRange = [0.95*min(Z) 1.05*max(Z)];

            %Define meshgrid matrices
            [Xq,Yq] = meshgrid(xRange, yRange);

            %Interpolate Z values on meshgrid
            Zq = griddata(X,Y,Z,Xq,Yq, 'cubic');

            if strcmp(type,'surf')
                %Plot surface
                set(gcf,'Renderer','painters')
                surf(Xq, Yq, Zq);
                title(name)
                zlim(zRange)
            elseif strcmp(type,'contour')
                %Plot contour
                set(gcf,'Renderer','painters')
                contourf(Xq, Yq, Zq, 50);
                title(name)
                zlim(zRange)
            else
               %Plot mesh
                set(gcf,'Renderer','painters')
                mesh(Xq, Yq, Zq);
                title(name)
                zlim(zRange) 
            end

       end
   end
end

