function [x,y,Nx,Ny,idx]=sketchCurveFromPoints(max_points)
    %Set up the window and create the necessary variables
    close all;
    figure(); title('Draw something...'); axis image; xlim([0 10]); ylim([0 10]);
    hold on
    xn=[]; yn=[];
    
    n=0;
    hold on
    while true
        %Get coordinates from user input
        [x_in,y_in]=ginput(1);
        
        %Close the curve if the maximum amount of points is reached.
        if n==max_points-1
            xn=[xn xn(1)];
            yn=[yn yn(1)];
        else
            xn=[xn x_in];
            yn=[yn y_in];
        end
        
        %Create the line object in the first iteration
        if n==0
            dots=line(xn,yn,'Marker','.','LineStyle','none');
        else
            %Update data otherwise
            set(dots,'XData',xn,'YData',yn);
        end
        
        %With at least 3 points we can start generating splines. 
        if length(xn)== 3 && length(yn) == 3
            pp=csape(1:length(xn),[xn ;yn],'periodic');                         %Generate spline coefficients
            points=fnplt2(pp);                                                  %Get the actual plot points
            curve=line(points(1,:),points(2,:),'Marker','.','LineStyle','none');%Create the line object that we'll update each iteration.
            [Nx,Ny,idx]=curveNormals(points(1,:),points(2,:),4);                %Calculate the normals (only for every 4th point)
            q=quiver(points(1,idx),points(2,idx),Nx,Ny);                        %Draw these normals
        elseif length(xn)> 3 && length(yn) > 3
            pp=csape(1:length(xn),[xn ;yn],'periodic');
            points=fnplt2(pp);
            [Nx,Ny,idx]=curveNormals(points(1,:),points(2,:),4);
            set(curve,'XData',points(1,:),'YData',points(2,:));
            set(q,'XData',points(1,idx),'YData',points(2,idx),'UData',Nx,'VData',Ny); 
        end
        
        drawnow;
        
        if n==max_points-1
            break
        end
        n=n+1;
    end
    
    x=points(1,:);
    y=points(2,:);
    hold off
end

