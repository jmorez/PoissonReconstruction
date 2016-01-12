function [V,N]=getVertexNormals(object)
    [nx,ny,nz]=patchnormals_double( object.f(:,1),object.f(:,2),object.f(:,3), ...
                                        object.v(:,1),object.v(:,2),object.v(:,3));
    V=object.v;
    N=[nx ny nz];
end