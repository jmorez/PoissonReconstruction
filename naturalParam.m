function [idx_n,x_n,y_n] = naturalParam(x,y,n)
    %For a given parametric curve specified by (x,y), this function attempts to
    %find the discrete indices such that you move in uniform steps along the
    %arc length (i.e. natural parametrization). This is not ideal. You
    %should actually recalculate the (x,y) values so 
    [L,K] = polyPerimeter(x,y);
    deltaL= L/n;
    idx_n = zeros(n,1);
    x_n = zeros(n,1);
    y_n = zeros(n,1);
    for i=1:n
        %Find the curve point closest to the natural (discrete) parameter.
        %[tau,idx] = min(abs(i*deltaL-K));
        for j=1:length(K)
            d=i*deltaL-K(j);
            if d < 0
                idx=j-1;
                break
            end
        end
        tau=i*deltaL-K(idx-1);
        x_n(i)=x(idx)*(1-tau)+x(idx+1)*tau;
        y_n(i)=y(idx)*(1-tau)+y(idx+1)*tau;  
        idx_n(i)=idx;
    end
end