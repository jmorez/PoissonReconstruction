function sketchCurveFromPoints()
    close all;
    fh=figure(); title('Draw something...'); axis image; xlim([0 10]); ylim([0 5]);
    hold on
    xn=[]; yn=[];
    x1=[]; y1=[]; x2=[]; y2=[];
    %Todo: 
    while true
        [x,y]=ginput(1);
        xn=[x2 x1 x];
        yn=[y2 y1 y];
        %if length(xn)>2 && length(yn)>2
        %    pp=csape(1:length(xn),[xn ;yn],'periodic');
        %    points=fnplt(pp);
        %    plot(gca,points(1,:),points(2,:))
        %end
        plot(gca,x,y,'o')
        x2=x1; y2=y1;
        x1=x; y1=y;
        
        drawnow
    end
    hold off
end