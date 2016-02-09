function v = wjacobi(v0,f,A,nu,omega)
    % WJACOBI(v0,f,A,nu,omega)
    % IN:   - v0: initial vector
    %       - f: source vector
    %       - A: matrix of ODE
    %       - nu: number of relaxations
    %       - omega: weight factor
    % OUT:  - v \approx inv(A)f

    if nargin<4 
        nu = 1; 
    end
    if nargin<5
        omega = 2/3;
    end
    
    n = length(v0);
    D = spdiags(diag(A),[0],n,n);
    I = speye(n);
    Rwj = (I-omega*(D\A));

    v = v0;
    for j = 1:nu
        v = Rwj*v+omega*(D\f); % see Briggs p.10.
    end
end