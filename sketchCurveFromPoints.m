function sketchCurveFromPoints()
    close all;
    fh=figure(); title('Draw something...'); axis square; xlim([0 5]); ylim([0 5]);
    hold on
    xn=[]; yn=[];
    x1=[]; y1=[]; x2=[]; y2=[];
    %Todo: 
    while true
        [x,y]=ginput(1);
        xn=[x2 x1 x];
        yn=[y2 y1 y];
        if length(xn)>2 && length(yn)>2
            pp=csape(1:length(xn),[xn ;yn],'periodic');
            points=fnplt(pp);
            plot(gca,points(1,:),points(2,:))
        end
        plot(gca,x,y,'o')
        x2=x1; y2=y1;
        x1=x; y1=y;
        
        drawnow
    end
    hold off
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
