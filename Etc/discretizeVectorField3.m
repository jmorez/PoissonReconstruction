function [Dx,Dy,Dz,xx,yy,zz]=discretizeVectorField3(V,N,m)
    %Returns three 3D-matrices with x, y and z components of the
    %discretized vector field. 
    n=length(N);
    %Set up grid
    xrange=[min(V(:,1)) max(V(:,1))];
    yrange=[min(V(:,2)) max(V(:,2))];
    zrange=[min(V(:,3)) max(V(:,3))];
    
    %Note: non-uniform at the moment!
    hx=(xrange(2)-xrange(1))/m;
    hy=(yrange(2)-yrange(1))/m;
    hz=(zrange(2)-zrange(1))/m;
    
    x=linspace(xrange(1)-hx,xrange(2),m);
    y=linspace(yrange(1)-hy,yrange(2),m);
    z=linspace(zrange(1)-hz,zrange(2),m);
    
    [xx,yy,zz]=meshgrid(x,y,z);    
    
    Dx=zeros(length(x),length(y),length(z));
    Dy=zeros(length(x),length(y),length(z));
    Dz=zeros(length(x),length(y),length(z));
    
    %This is the set of indices that form a cube with the bottom lower left
    %front index at 0 0 0
    nearbyidx=[ 0 0 0; 1 0 0; 0 1 0; 1 1 0; ...
                0 0 1; 0 1 1; 1 0 1; 1 1 1];
    
    %Next we "splat" (I think) the vector field on some grid.
    for j=1:n
        %Find the index of the closest gridpoint (to the left of ...) 
        dx=V(j,1)-x;
        dy=V(j,2)-y;
        dz=V(j,3)-z;
        
        idx_x=sum(dx > 0);
        idx_y=sum(dy > 0);
        idx_z=sum(dz > 0); 
        
        %This gridpoint will locate the cube that contains V(j,:). Next we
        %weigh the values of the discretized vector field based on their
        %distance to the gridpoint in question.
        idx=[idx_x idx_y idx_z];
        
        %Calculate component magnitudes in the cube in the grid weighed
        %with the distance to some nearby gridpoint. Add this to the
        %previous value because several points might be contained in the
        %cube.
        for k=1:8
            grididx=idx+nearbyidx(k,:);
            Dx(grididx)=Dx(idx+nearbyidx(k,:))+N(j,1)*(V(j,1)-x(grididx(1)))/hx;
            Dy(grididx)=Dy(idx+nearbyidx(k,:))+N(j,2)*(V(j,2)-y(grididx(2)))/hy;
            Dz(grididx)=Dz(idx+nearbyidx(k,:))+N(j,3)*(V(j,3)-z(grididx(3)))/hz;
        end
    end  
end