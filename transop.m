function [Ir,Ip]=transop(n)
    e=ones(n,1);
    Ir=spdiags([e*0.25 e*0.5 e*0.25],[1 0 -1],n,n);
    Ir=Ir(2:2:end,:);
    Ip=spdiags([e*0.5 1*e e*0.5],[1 0 -1],n,n);
    Ip=Ip(:,2:2:end);
end