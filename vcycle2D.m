function [v, e_iter, r_iter] = vcycle2D(v0,f,A,nu1,nu2,w)
    n=round(sqrt(length(f))+1);
    if(n > 2)
        [Ir,~]=transop(n-1);
        Ir2D=kron(Ir,Ir);   %Set up restriction operator
        Ip2D=4*Ir2D';       %Set up interpolation operator
        
        Ac=Ir2D*A*Ip2D;     %Calculate restricted operator 
        v=v0;
        for j=1:nu1
            v=wjacobi(v,f,A,1,w);
        end
        r=Ir2D*(f-A*v);     %Calculate restricted residual
        [e, e_iter,r_iter]=vcycle2D(zeros(size(r)),r,Ac,nu1,nu2,w); %Go down one level and calculate the error
        e=Ip2D*e;           %Interpolate the error
        v=v+e;              %Update solution with the error
        for j=1:nu2         
            v=wjacobi(v,f,A,1,w); %Relax nu2 times on new guess
        end
        e_iter=cat(1,norm(e),e_iter);
        r_iter=cat(1,norm(r),r_iter);

    else
        v=A\f;              %On the coarsest grid we just solve the system
        e_iter=[];
        r_iter=[];
    end
end