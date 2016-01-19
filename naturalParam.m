function idx_u = naturalParam(x,y,n)
    %For a given parametric curve specified by (x,y), this function attempts to
    %find the discrete indices such that you move in uniform steps along the
    %arc length (i.e. natural parametrization).
    [L,K] = polyPerimeter(x,y);
    deltaL= L/n;
    idx_u = zeros(n,1);
    for i=1:n
        [~,idx]=min(abs(i*deltaL-K));
        idx_u(i)=round(idx);
    end
end