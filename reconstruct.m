function [X_v,X_exact, global_err, e_iter,r_iter]= reconstruct(x,y,Nx,Ny,m)
%% Parameters
xrange=[0 10];  %Depends on the sketchCurveFromPoints drawing window size, should remain unchanged
yrange=[0 10];
kernel_size=10;     %Number of points to use in the Gaussian kernel
kernel_sigma=1;  %Width of the kernel, should be proportional to m 

%% 1. Load data
% First we load some set of oriented points. (You can generate these
% yourself by calling sketchCurveFromPoints(n) )


%% 3. Discretize ('splat') vector field

[Dx,Dy,xx,yy]=discretizeVectorField([x y],[Nx Ny],m,xrange,yrange);

%% 4. Convolve with a smoothing filter
[Dx_s,Dy_s]=smoothVectorFieldGaussian(Dx,Dy,kernel_size,kernel_sigma);

%% 5. Calculate the divergence

div=divergence(Dx_s,Dy_s);

%% 6. Solve the poisson equation to find the (smoothed) indicator function

A1D=helmholtz(length(Dx_s)+1,0);
A2D=kron(A1D,speye(size(A1D)))+kron(speye(size(A1D)),A1D);

X=A2D\div(:);
X_exact=reshape(X,size(Dx_s));

%% 7. Now we threshold this function to extract the true indicator function (which should be sharply delineated).
[counts,bins]=hist(X_exact(:),50);
[pks,locs]=findpeaks(counts,bins);
[~,idx]=sort(pks);
locs=locs(idx);
threshold=mean(locs((end-1):end));
X_thr=X_exact > threshold;

%% 8. Let's figure out the ground truth by extracting the indicator function from the curve.
in=inpolygon(xx,yy,x,y);
global_err=norm(in- X_thr)/numelements(X);

%% 9. 
[X_v, e_iter, r_iter]=vcycle2D(zeros(size(div(:))),div(:),A2D,3,3,2/3);
X_v=reshape(X_v,size(div));

end
