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
            X = Obj.data(:,1);
            Y = Obj.data(:,2);
            Z = Obj.data(:,3);
            
            switch plotOutput
                case 'Y'    %make Y the dependant variable to plot
                    U = X;
                    V = Z;
                    W = Y;
                    uLabel = 'X (mm)';
                    vLabel = 'Z (mm)';
                case 'X'    %make X the dependant variable to plot
                    U = Y;
                    V = Z;
                    W = X;
                    uLabel = 'Y (mm)';
                    vLabel = 'Z (mm)';
                otherwise   %make Z the default dependant variable to plot
                    U = X;
                    V = Y;
                    W = Z;
                    uLabel = 'X (mm)';
                    vLabel = 'Y (mm)';
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
            elseif strcmp(type,'contour')
                %Plot contour
                set(gcf,'Renderer','painters')
                [s,p] = contourf(Xq, Yq, Zq, 30);
                set(p, 'LineStyle', ':')
                set(p, 'LineWidth', 0.1)
            else
               %Plot mesh
                set(gcf,'Renderer','painters')
                mesh(Xq, Yq, Zq);
            end
            
            title(Obj.name)
            zlim(wRange)
            xlabel(uLabel)
            ylabel(vLabel)
        end
        function output2D(Obj, dependent, independent)
            X = Obj.data(:,1);
            Y = Obj.data(:,2);
            Z = Obj.data(:,3);
            
            switch dependent
                case 'Y'    %make Y the dependant variable to plot
                    W = Y;    
                case 'X'    %make X the dependant variable to plot
                    W = X;
                otherwise   %make Z the default dependant variable to plot
                    W = Z;
            end
            switch independent
                case 'Y'    %make Y the independant variable to plot
                    V = Y;    
                case 'X'    %make X the independant variable to plot
                    V = X;
                otherwise   %make Z the default independant variable to plot
                    V = Z;   
            end
            
            wMin = min(W);
            wMax = max(W);
            wScale = abs(wMax - wMin)*1.2;
            wRange = [wMin-wScale wMax+wScale];
            
            plot(V, W, 'k-o')
            title(Obj.name)
            ylim(wRange)
            grid on
        end
        function autoPlane(Obj)
            X = Obj.data(:,1);
            Y = Obj.data(:,2);
            Z = Obj.data(:,3);
            
            Xvar = abs(max(X) - min(X));
            Yvar = abs(max(Y) - min(Y));
            Zvar = abs(max(Z) - min(Z));
            
            if (Xvar < Yvar) && (Xvar < Zvar)
                plotOutput = 'X';
            elseif (Yvar < Xvar) && (Yvar < Zvar)
                plotOutput = 'Y';
            else
                plotOutput = 'Z';
            end
            
            Obj.output3D(plotOutput, 'contour', 30)
            
        end
        function autoLine(Obj)
            X = Obj.data(:,1);
            Y = Obj.data(:,2);
            Z = Obj.data(:,3);
            
            Xvar = std(X);
            Yvar = std(Y);
            Zvar = std(Z);
            
            if (Xvar < Yvar) && (Xvar < Zvar)
                if (Yvar < Zvar)
                    dependent = 'Y';
                    independant = 'Z';
                else
                    dependent = 'Z';
                    independent = 'Y';
                end
            elseif (Yvar < Xvar) && (Yvar < Zvar)
                if (Xvar < Zvar)
                    dependent = 'X';
                    independent = 'Z';
                else
                    dependent = 'Z';
                    independent = 'X';
                end
            else
                if (Xvar < Yvar)
                    dependent = 'X';
                    independent = 'Y';
                else
                    dependent = 'Y';
                    independent = 'X';
                end
            end
            
            Obj.output2D(dependent, independent)
            
        end
   
   end
end

