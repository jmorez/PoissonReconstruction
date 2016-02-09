function [Nx,Ny,idx]=curveNormals(x,y,stride)
%http://mathworld.wolfram.com/NormalVector.html <- This seems to work badly
%for some reason, so we'll use angles.
%Stride has been untested and is not really necessary...
    n=length(x);
    idx=2:stride:n;
    
    %Concatenate the last element to the beginning and vice versa so we can
    %calculate the normals in points 1 and n
    x=[x(n); reshape(x,n,1); x(1)];
    y=[y(n); reshape(y,n,1); y(1)];
    dx=(x(idx+1)-x(idx-1));
    dy=(y(idx+1)-y(idx-1));
    
    %Slope angle
    theta=atan2(dy,dx);
    
    %The minus rotates the slope vector by 90 degrees
    Nx=sin(theta); 
    Ny=-cos(theta); 
    
    idx=1:stride:n;
end