function [x,y,Nx,Ny,idx]=sketchCurveFromPoints(max_points)
    %Set up the window and create the necessary variables
    close all;
    figure();  axis image; xlim([0 10]); ylim([0 10]);
    %title('Draw something...');
    hold on
    
    %Control point arrays
    xn=[]; yn=[];
    
    %Default value if no input was given.
    if nargin==0
        max_points=5;
    end
    
    %Control point counter
    n=0;
    hold on
    while true
        %Get coordinates from user input
        [x_in,y_in]=ginput(1);
        
        %Close the curve if the maximum amount of points is reached.
        if n==max_points-1
            xn=[xn xn(1)];
            yn=[yn yn(1)];
        %Else just append the new inputs
        else
            xn=[xn x_in];
            yn=[yn y_in];
        end
        
        %Create the line object in the first iteration
        if n==0
            dots=line(xn,yn,'Marker','o','LineStyle','none','Color','k');
        else
            %Update data otherwise
            set(dots,'XData',xn,'YData',yn);
        end
        
        %With at least 3 points we can start generating splines. This
        %if-construct can probably be formulated more elegantly. 
        if length(xn)== 3 && length(yn) == 3
            pp=csape(1:length(xn),[xn ;yn]);                        
            points=fnpltHR(pp); %Fetch the actual points
            %Create the line object that we'll update with each iteration.
            curve=line(points(1,:),points(2,:),'Marker','.','LineStyle','none','Color','k');
        elseif length(xn)> 3 && length(yn) > 3 && n < max_points-1
            %We now just update the control points and recalculate the
            %spline and update the curve.
            pp=csape(1:length(xn),[xn ;yn]);
            points=fnpltHR(pp);
            set(curve,'XData',points(1,1:end),'YData',points(2,1:end));
        elseif n==max_points-1
            %In the end we want periodic conditions as it is a closed
            %curve.
            pp=csape(1:length(xn),[xn ;yn],'periodic');
            points=fnpltHR(pp);
            set(curve,'XData',points(1,1:end),'YData',points(2,1:end)); 
        end     
        drawnow; 
        
        %End the loop if the max amount of control points is reached.
        if n==max_points-1
            break
        end
        n=n+1;
    end
    
    %Something very mysterious happens during the interpolation. Around
    %control points, we get duplicate (x,y) pairs. This seems to be an
    %artifact of the csape/fnpltHR function, or simply because of my own incorrect use. 
    %I will simply remove the duplicates by looking at their value.
    x=points(1,1:end)';
    y=points(2,1:end)';    
    
    duplicates=diff(x) == 0 & diff(y) == 0;
    sum(duplicates)
    x(duplicates)=[];
    y(duplicates)=[];
    
    
    [Nx,Ny,idx]=curveNormals(x,y,1);
    quiver(x(2:end),y(2:end),Nx,Ny,'Color','k');
    
    x=x(2:end);
    y=y(2:end);
    
    hold off
end

