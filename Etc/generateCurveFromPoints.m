function [x,y]=generateCurveFromPoints(xn,yn)
   x=[]; y=[];
   xn=[-1 0 1 0 0 -1]; yn=[0 -1 0 1 0 0];
   pp=csape(0:(length(xn)-1),[xn ;yn],'periodic');
   fnplt(pp)
end