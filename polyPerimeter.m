function [L, K] = polyPerimeter(x,y)
    %Calculates the arclength of a polygon specified by points x and y.
       
    n=length(x);
    x=reshape(x,n,1);
    y=reshape(y,n,1);
    
    %Pad the coordinates (motivation: look at the case for e.g. a unit
    %square)
    x=[x; x(1)];
    y=[y; y(1)];
    
    dx=diff(x);
    dy=diff(y);
    
    K=cumsum(sqrt(dx.^2+dy.^2)); %Cumulative arc length
    L=K(end);
end