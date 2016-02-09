load example
%TODO: update example to have [Nx  Ny] naturally parametrized
close all

idx=naturalParam(x,y,200);
[Dx,Dy,xx,yy]=discretizeVectorField([x(idx) y(idx)],[Nx(idx) Ny(idx)],75);
quiver(xx,yy,Dx,Dy);
set(gca,'XTick',xx(1,:));
set(gca,'YTick',yy(:,1));
set(gca,'XTicklabel',[]);
set(gca,'YTicklabel',[]);
xlabel('x'); ylabel('y');
hold on
plot(x,y)
quiver(x(idx),y(idx),Nx(idx),Ny(idx));
legend('Discretized normals','Original curve','Normals')
grid on
axis image
hold off

%Now we convolve with a gaussian kernel to smooth out the vector field
kernel_size=20; %Number of kernel points
kernel_width=1;%Spread of the gaussian
[xk,yk]=meshgrid(-kernel_size:kernel_size,-kernel_size:kernel_size);
kernel=(2*pi*kernel_width)^(-1/2)*exp(-(xk.^2+yk.^2)/kernel_width^2);
Dx_s=conv2(Dx,kernel,'same'); 
Dy_s=conv2(Dy,kernel,'same');
figure;
%quiver(Dx_s,Dy_s);
%% 
% Here we see a problem: the vector field has no "homogeneous" divergence
% because the curve is sampled more densily at parts of the curve with more
% control points. We'll have to parametrize somehow... 
%figure;
div=divergence(xx,yy,Dx_s,Dy_s);
imagesc(div)
%% 
A1D=helmholtz(length(xx)+1,0);
A2D=kron(A1D,speye(size(A1D)))+kron(speye(size(A1D)),A1D);

X=A2D\div(:);
X=flipud(reshape(X,size(Dx_s)));
imagesc(X); axis image;

%%
[counts,bins]=hist(X(:),50);
[pks,locs]=findpeaks(counts,bins);
[pks_sorted,idx]=sort(pks);
locs=locs(idx);

bar(bins,counts)
hold on
plot(locs((end-1):end),pks_sorted((end-1):end),'r+')
threshold=mean(locs((end-1):end));
hold off 
figure 
imagesc(X > threshold); axis image;

%% Extract region from the parametric curve and compare with the solution
in=flipud(inpolygon(xx,yy,x,y));
imagesc(in- (X > threshold)); axis image;
global_err=norm(in- (X > threshold))/numelements(X);

