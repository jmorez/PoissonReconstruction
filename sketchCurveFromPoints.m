function sketchCurveFromPoints()
    close all;
    fh=figure(); title('Draw something...'); axis image; xlim([0 10]); ylim([0 5]);
    hold on
    xn=[]; yn=[];
    x1=[]; y1=[]; x2=[]; y2=[];
    %Todo: 
    hold on
    n=0;
    while true
        [x,y]=ginput(1);
        xn=[xn x];
        yn=[yn y];
        if n==0
            l1=line(xn,yn,'Marker','o','LineStyle','none');
        else
            set(l1,'XData',xn,'YData',yn);
        end
       
        if length(xn)== 3 && length(yn) == 3
            pp=csape(1:length(xn),[xn ;yn],'periodic');
            points=fnplt(pp);
            l2=line(points(1,:),points(2,:));
        elseif length(xn)> 3 && length(yn) > 3
            pp=csape(1:length(xn),[xn ;yn],'periodic');
            points=fnplt(pp);
            set(l2,'XData',points(1,:),'YData',points(2,:));
            
        end
       
%         if length(xn)>2 && length(yn)>2
%             pp=csape(1:length(xn),[xn ;yn],'periodic');
%             points=fnplt(pp);
%             plot(gca,points(1,:),points(2,:))
%         end
%         plot(gca,x,y,'o')
%         x2=x1; y2=y1;
%         x1=x; y1=y;
        n=n+1;
        drawnow;
    end
    hold off
end

function KeyPressFcn()
    
end
% function sketchCurveFromPoints()
%     close all;
%     h=figure(); title('Draw something...'); axis square; 
%     %Arrays that store points
%     xn=[]; yn=[];
%     %Arrays that store the curve
%     xc=[]; yc=[];
% 
%     line_points=line;
%     line_curve=line;
%     set(line_points,'Parent',gca);
%     set(line_curve,'Parent',gca);
%     
%     %Main loop should purely update the 
%     n=1;
%     while true
%         %Get the coordinates of each mouseclick
%         [x,y] = ginput(1);
%         %Add them to the rest
%         xn=[xn x];
%         yn=[yn y];
%         
%         %With 3 points we can begin making the curve
%         if n > 2
%             pp=csape(1:length(xn),[xn ;yn],'periodic');
%             curve=fnplt(pp); xc=curve(1,:); yc=curve(2,:);            
%         end
%         
%         refreshdata;
%         drawnow;
% 
%         n=n+1;
%     end
%     %hold off
% end
