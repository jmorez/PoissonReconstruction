clear all
load example
m=50:50:750;
%m=[50 250 750];
close all
ym=cell(length(m));
profile on;
%m=500;
for j=1:length(m)
    tic
    [~,~,~,r_iter]=reconstruct(x,y,Nx,Ny,m(j));
    t(j)=toc;
    ym{j}=r_iter;
    m(j)
end
profile off; profile viewer
% %% 
% semilogy(ym{1},'k-')
% hold on
% semilogy(ym{2},'k-.')
% semilogy(ym{3},'k-..')
% semilogy(ym{3},'k')
% hold off
% legend('m=50','m=250','m=750')
% hold on
% semilogy(ym{1},'ko')
% semilogy(ym{2},'ko')
% semilogy(ym{3},'ko')
% hold off
% xlabel('K')
% ylabel('|r|')
% export_fig('D:\Google Drive\School\2Ma\Multigrid Methoden\Poisson Reconstructie\residual.eps');
%% 
loglog(1./m,t,'k-o')
xlabel('1/m');
ylabel('t (s)');
export_fig('D:\Google Drive\School\2Ma\Multigrid Methoden\Poisson Reconstructie\scaling.eps');
