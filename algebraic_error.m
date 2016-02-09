clear all
load example
m=50:50:1000;
close all
for j=1:length(m)
    [X_exact,X_v]=reconstruct(x,y,Nx,Ny,m(j));
    ym(j)=norm(X_exact-X_v);
    m(j)
end
%% 
loglog(1./m,ym,'k-o');
xlabel('1/m')
ylabel('|e|')
set(gcf,'Position',[680 685 700 300])
export_fig('D:\Google Drive\School\2Ma\Multigrid Methoden\Poisson Reconstructie\algebraicerror2.eps');