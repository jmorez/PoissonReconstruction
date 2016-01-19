function H=helmholtz(n,sigma)
    h=1/n;
    B=repmat([-1 2 -1],n-1,1);
    H=spdiags(B,[-1 0 1],n-1,n-1)./h^2+sigma.*speye(n-1);
end