function [Dx_s,Dy_s] = smoothVectorFieldGaussian(Dx, Dy, kernel_size, kernel_sigma)
    %Set up kernel
    [xk,yk]=meshgrid(-kernel_size:kernel_size,-kernel_size:kernel_size);
    kernel=(2*pi*kernel_sigma)^(-1/2)*exp(-(xk.^2+yk.^2)/kernel_sigma^2);
    
    %Apply kernel to all components
    Dx_s=conv2(Dx,kernel,'same'); 
    Dy_s=conv2(Dy,kernel,'same');
end