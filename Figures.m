clear all; 
plot=true; %Switch to turn on or off plots
%% Parameters
m=250;          %Grid size for discretizing the vector field
xrange=[0 10];  %Depends on the sketchCurveFromPoints drawing window size, should remain unchanged
yrange=[0 10];

kernel_size=20*m/250;     %Number of points to use in the Gaussian kernel
kernel_sigma=2;  %Width of the kernel, should be proportional to m 

x_image=linspace(xrange(1),xrange(2),m);
y_image=linspace(yrange(1),yrange(2),m);

%% 1. Load data
% First we load some set of oriented points. (You can generate these
% yourself by calling sketchCurveFromPoints(n) )
load example
close all;
%Plot curve
if plot==true
    figure('Name','Original set of oriented points.');
    plot(x,y,'k'); xlabel('x'); ylabel('y');
    xlim(xrange); ylim(yrange);
    %Plot the normals
    hold on;
    quiver(x,y,Nx,Ny,'k'); 
    hold off
    axis square;
end

%% 3. Discretize ('splat') vector field

[Dx,Dy,xx,yy]=discretizeVectorField([x y],[Nx Ny],m,xrange,yrange);

%Optional visualization
if plot==true
    figure('Name','Discretized vector field')
    quiver(xx,yy,Dx,Dy,'Color','k');
    set(gca,'XTick',xx(1,:));
    set(gca,'YTick',yy(:,1));
    set(gca,'XTicklabel',[]);
    set(gca,'YTicklabel',[]);
    xlabel('x'); ylabel('y');
    hold on
    plot(x,y,'k')
    quiver(x,y,Nx,Ny,'Color','k','Color',[0.5 0.5 0.5],'ShowArrowHead','off');
    %legend('Discretized normals','Original curve','Normals')
    grid on
    axis image
    hold off
end
%% 4. Convolve with a smoothing filter
[Dx_s,Dy_s]=smoothVectorFieldGaussian(Dx,Dy,kernel_size,kernel_sigma);
if plot==true
    figure('Name','Smoothed vector field.')
    quiver(xx,yy,Dx_s,Dy_s,'k'); axis image;
    xlabel('x'); ylabel('y');
end
%% 5. Calculate the divergence

div=divergence(Dx_s,Dy_s);
if plot==true
    figure('Name','Divergence of the smoothed vector field')
    imagesc(linspace(0,10,length(xx)),linspace(0,10,length(yy)),div); axis image; colormap('hot');
    xlabel('x'); ylabel('y'); set(gca,'YDir','normal');
end

%% 6. Solve the poisson equation to find the (smoothed) indicator function

A1D=helmholtz(length(Dx_s)+1,0);
A2D=kron(A1D,speye(size(A1D)))+kron(speye(size(A1D)),A1D);

X=A2D\div(:);
X_exact=reshape(X,size(Dx_s));
if plot==true
    figure('Name','"Exact" solution');
    imagesc(x_image,y_image,X_exact); axis image; colormap('hot')
    xlabel('x'); ylabel('y'); set(gca,'YDir','normal');
end

%% 7. Now we threshold this function to extract the true indicator function (which should be sharply delineated).
[counts,bins]=hist(X_exact(:),50);
[pks,locs]=findpeaks(counts,bins);
if plot==true
    bar(bins,counts);
    set(gca,'YScale','log')
end
[pks_sorted,idx]=sort(pks);
locs=locs(idx);
threshold=mean(locs((end-1):end));
X_thr=X_exact > threshold;

if plot==true
    figure 
    imagesc(x_image,y_image,X_thr); axis image; colormap('gray')
    set(gca,'YDir','normal')
end

%% 8. Let's figure out the ground truth by extracting the indicator function from the curve.

in=inpolygon(xx,yy,x,y);
global_err=norm(in- X_thr)/numelements(X);
if plot==true
    figure
    imagesc(in - X_thr); axis image; colormap('gray');
    xlabel('x'); ylabel('y'); set(gca,'YDir','normal');
    title(['|e|= ' num2str(global_err)])
end

%% 9. 
X_v=vcycle2D(zeros(size(div(:))),div(:),A2D,3,3,2/3);
X_v=reshape(X_v,size(div));
if plot==true
    figure('Name','V-Cycle Solution');
    imagesc(x_image,y_image,X_exact-X_v); axis image; colormap('hot')
    set(gca,'YDir','normal')
end

%% 
if plot==true
	tilefigs
end

%% 
if plot==true
    ha=tightplots(1, 3, 30, [1 1], [0.8 0.8], [0.6 0.7], [0.8 0.3], 'centimeters');
    axes(ha(1));
    imagesc(x_image,y_image,div); axis image; colormap('hot')
    set(gca,'YDir','normal')
    axes(ha(2));
    imagesc(x_image,y_image,X_exact); axis image; colormap('hot')
    set(gca,'YDir','normal')
    axes(ha(3));
    imagesc(x_image,y_image,X_thr); axis image;
    set(gca,'YDir','normal')
end