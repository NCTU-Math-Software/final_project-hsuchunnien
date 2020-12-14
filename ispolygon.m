function ispolygon
    X=[];
    Y=[];
    pall=[];
    point_combination=[];
    check_polygon=true;
    while 1
        [x,y,BUTTON] = ginput(1);
        if(BUTTON==3)                     %按滑鼠右鍵就結束
            break
        end
        X=[X x];
        Y=[Y y];
    end
    for ii=1:size(X,2)
        for jj=ii+1:size(X,2)
            p=polyfit([X(ii) X(jj)],[Y(ii) Y(jj)],1);
            point_combination=[point_combination [ii;jj]];
            pall=[pall;p];
        end
    end
    whos
    for ii=1:size(pall,1)
        for jj=ii+1:size(pall,1) 
            if(pall(ii,1)~=pall(jj,1))
                xinter=(pall(ii,2)-pall(jj,2))/(pall(ii,1)-pall(jj,1))
                yinter=polyval(pall(ii,:),xinter)
                x1=X(point_combination(1,ii));
                x2=X(point_combination(2,ii));
                x3=X(point_combination(1,jj));
                x4=X(point_combination(2,jj));
                y1=Y(point_combination(1,ii));
                y2=Y(point_combination(2,ii));
                y3=Y(point_combination(1,jj));
                y4=Y(point_combination(2,jj));
                if(xinter<max([x1 x2])&&xinter>min([x1 x2])&&yinter<max([y1 y2])&&yinter>min([y1 y2])...
                        &&xinter<max([x3 x4])&&xinter>min([x3 x4])&&yinter<max([y3 y4])&&yinter>min([y3 y4]))
                    check_polygon=false;
                end
            end
        end
    end
    if(check_polygon)
        disp('是多邊形')
    else
        disp('不是多邊形')
    end
end