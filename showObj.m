function showObj(object,varargin)
%Plots the object, 
    if ~isempty(varargin)
        if strcmp(varargin{1},'normals')
        %Problem: vertex normals are not consistently aligned
        [nx,ny,nz]=patchnormals_double( object.f(:,1),object.f(:,2),object.f(:,3), ...
                                        object.v(:,1),object.v(:,2),object.v(:,3));
        %normals=unifyMeshNormals(object.v,object.f,'alignTo','out');                            
        hold on;
        quiver3(object.v(:,1),object.v(:,2),object.v(:,3),-nx,-ny,-nz,5);
        hold off;
        else
            fprintf(1,'Invalid option supplied: %s \n',varargin{1});
        end
        
        p=patch('Vertices',object.v,'Faces',object.f, ...
            'LineWidth',0.1,'FaceLighting','gouraud', ...
            'EdgeColor',[0 0 0],'FaceColor',[0.7 0.7 0.7], ...
            'VertexNormals',cat(2,nx,ny,nz));
    else
        p=patch('Vertices',object.v,'Faces',object.f, ...
            'LineWidth',0.1,'FaceLighting','gouraud', ...
            'EdgeColor',[0 0 0],'FaceColor',[0.7 0.7 0.7]);
    end
    axis image; view(3); xlabel('x');ylabel('y');zlabel('z');
    set(gca,'Color',[0.5 0.5 0.5]); set(gcf,'Color',[0.5 0.5 0.5]);
end

