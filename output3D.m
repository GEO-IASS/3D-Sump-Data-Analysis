function output3D(data, name, type)
    X = abs(data(:,1));
    Y = abs(data(:,2));
    Z = data(:,3);

    n = (max(X)-min(X))/20;
    m = (max(Y)-min(Y))/20;

    %Define meshgrid ranges
    xRange = min(X)+n:n:max(X)-n;
    yRange = min(Y)+m:m:max(Y)-m;

    %Define meshgrid matrices
    [Xq,Yq] = meshgrid(xRange, yRange);

    %Interpolate Z values on meshgrid
    Zq = griddata(X,Y,Z,Xq,Yq, 'cubic');
    
    if strcmp(type,'surf')
        %Plot surface
        figure(1)
        set(gcf,'Renderer','painters')
        surf(Xq, Yq, Zq);
        title(name)
        zlim([35 40])
    else
        %Plot contour
        figure(2)
        set(gcf,'Renderer','painters')
        contourf(Xq, Yq, Zq, 50);
        title(name)
        zlim([35 40])
    end
end

