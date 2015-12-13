function [Nx,Ny,idx]=curveNormals(x,y,stride)
%http://mathworld.wolfram.com/NormalVector.html <- This seems to work badly
%for some reason, so we'll use angles.
    idx=2:stride:(length(x)-1);
    dx=(x(idx+1)-x(idx-1));
    dy=(y(idx+1)-y(idx-1));
    theta=atan2(dy,dx);
    Nx=sin(theta);%-dx./sqrt(dx.^2+dy.^2);
    Ny=-cos(theta);%dy./sqrt(dx.^2+dy.^2);
end