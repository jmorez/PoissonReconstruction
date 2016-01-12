load example
close all
[Dx,Dy,xx,yy]=discretizeVectorField([x(idx)' y(idx)'],[Nx' Ny'],75);
quiver(xx,yy,Dx,Dy);
set(gca,'XTick',xx(1,:));
set(gca,'YTick',yy(:,1));
set(gca,'XTicklabel',[]);
set(gca,'YTicklabel',[]);
xlabel('x'); ylabel('y');
hold on
plot(x,y)
quiver(x(idx),y(idx),Nx,Ny);
legend('Discretized normals','Original curve','Normals')
grid on
axis image
hold off

%Now we convolve with a gaussian kernel to smooth out the vector field
kernel_size=50;
kernel_width=10;
[xk,yk]=meshgrid(-kernel_size:kernel_size,-kernel_size:kernel_size);
kernel=(2*pi*kernel_width)^(-1/2)*exp(-(xk.^2+yk.^2)/kernel_width^2);
Dx_s=conv2(Dx,kernel); 
Dy_s=conv2(Dy,kernel);
figure;
%quiver(Dx_s,Dy_s);
%% 
% Here we see a problem: the vector field has no homogenous divergence
% because the curve is sampled more densily at parts of the curve with more
% control points. We'll have to calculate the path length and divide the
% sampling points (for the normals) more evenly
figure;
surf(flipud(sqrt(diff(Dx_s).^2+diff(Dy_s).^2)));

%% Divergence
figure;
%quiver(diff(Dx_s),diff(Dy_s),3)
%quiver(Dx_s,Dy_s,1)
imagesc(log(1+diff(Dx_s)+diff(Dy_s))); axis image;
%axis image; colormap('hot')