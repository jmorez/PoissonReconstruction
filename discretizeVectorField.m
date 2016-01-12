function [Dx,Dy,xx,yy]=discretizeVectorField(V,N,m)
    %Returns two 2D-matrices with x & y components of the
    %discretized vector field. 
    n=length(N);
    %Set up grid
    xrange=[min(V(:,1)) max(V(:,1))];
    yrange=[min(V(:,2)) max(V(:,2))];
    
    %Note: non-uniform at the moment, will depend on the extent of the
    %vertices in x- and y-direction.
    hx=(xrange(2)-xrange(1))/m;
    hy=(yrange(2)-yrange(1))/m;
    
    x=linspace(xrange(1)-hx,xrange(2),m);
    y=linspace(yrange(1)-hy,yrange(2),m);
    [xx,yy]=meshgrid(x,y);    
    
    %Initialize matrices that will hold the components
    Dx=zeros(length(x),length(y));
    Dy=zeros(length(x),length(y));
    
    %This is the set of indices that form a square with the bottom lower left
    %front index at 0 0. 
    nearbyidx=[0 0; 1 0; 0 1; 1 1];
    
    %Next we "splat" the vector field on some grid.
    for j=1:n
        %Find the index of the closest gridpoint (to the bottom left of ...) 
        dy=V(j,1)-x;
        dx=V(j,2)-y;
        
        idx_x=sum(dx > 0);
        idx_y=sum(dy > 0);
        
        %Calculate component magnitudes in the square in the grid weighed
        %with the distance to some nearby gridpoint. Add this to the
        %previous value because several points might be contained in (or
        %are near to) the square.
        for k=1:4
            idx=sub2ind([m m],idx_x +nearbyidx(k,1),idx_y+nearbyidx(k,2));
            Dx(idx)=Dx(idx)+N(j,1)*abs(V(j,1)-x(idx_x+nearbyidx(k,1)))/hx;
            Dy(idx)=Dy(idx)+N(j,2)*abs(V(j,2)-y(idx_y+nearbyidx(k,2)))/hy;
        end
        
    end  
    %Normalize, not sure if this is necessary...
    norm=sqrt(Dx.^2+Dy.^2);
    Dx=Dx./norm; Dx(isnan(Dx))=0;
    Dy=Dy./norm; Dy(isnan(Dy))=0;
end