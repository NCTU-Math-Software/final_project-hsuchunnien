%題目:多邊形判斷:使用者任意依序選取平面上 n 個點, 判斷其是否為多邊形。
%下載程式放在MATLAB資料夾中後，在Command Window中輸入ispolygon，執行程式。
%程式要求使用者在「檢驗多邊形」的視窗中用滑鼠左鍵依序輸入點，按在視窗內按滑鼠右鍵停止輸入，
%程式會判斷將點依序連起來的圖形是凸多邊形、凹多邊形或不是多邊形，並輸出在Command Window中。
    X=[];
    Y=[];
    pall=[];
    point_combination=[];
    array_vector=[];
    check_polygon=true;
    isconvex=true;
    f=figure('name','檢驗多邊形','NumberTitle','off');
    if size(X,2)==3                       %三個點一定是多邊形
        disp('是多邊形')
        return
    end
    axis([0 3 0 3]);
    hold on
    while 1
        [x,y,BUTTON] = ginput(1);         %滑鼠左鍵輸入點
        if(BUTTON==3)                     % 按滑鼠右鍵就結束輸入
            break
        end
        X=[X x];
        Y=[Y y];
        plot([X],[Y],'k-');              %畫出點出的多邊形
    end
    plot([X X(1)],[Y Y(1)]);              %畫出點出的多邊形
    
    %以下檢測圖形是凹或凸多邊形，依序紀錄向量(1,2)、(2,3),...,(n,1)，再檢測相鄰向量構成矩陣的determinant正負有無變動，有變則為凹多邊形。
    for ii=1:(size(X,2)-1)
        vector=[X(ii+1)-X(ii);Y(ii+1)-Y(ii)];
        array_vector=[array_vector vector];
    end
    vector=[X(1)-X(size(X,2));Y(1)-Y(size(X,2))];
    array_vector=[array_vector vector];
    for ii=1:(size(array_vector,2)-2)
        if det([array_vector(:,ii) array_vector(:,ii+1)])*det([array_vector(:,ii+1) array_vector(:,ii+2)])<0
            isconvex=false;
        end
    end
    if(det([array_vector(:,size(array_vector,2)-1) array_vector(:,size(array_vector,2))])*det([array_vector(:,size(array_vector,2)) array_vector(:,1)])<0)
        isconvex=false;
    end
    if(det([array_vector(:,size(array_vector,2)) array_vector(:,1)])*det([array_vector(:,1) array_vector(:,2)])<0)
        isconvex=false;
    end

    %以下迴圈用polyfit做出相鄰兩點多項式
    for ii=1:(size(X,2)-1)
        p=polyfit([X(ii) X(ii+1)],[Y(ii) Y(ii+1)],1);          %做出過相鄰兩點的多項式，點了n個點就做n條多項式
        point_combination=[point_combination [ii;ii+1]];       %紀錄多項式是由哪兩個點形成的
        pall=[pall;p];                                         
    end
    p=polyfit([X(size(X,2)) X(1)],[Y(size(X,2)) Y(1)],1);      %最後一點連回第一點的單獨做
    point_combination=[point_combination [size(X,2);1]];
    pall=[pall;p];
    
    %以下迴圈檢驗(1,3)、(1,4)、...、(1,n-1)的直線組合。((1,2)和(1,n)為相鄰邊，不需檢驗)
    for ii=1:(size(pall,1)-1)                                  %檢驗除了相鄰的兩條邊以外的任兩條線是否有相交在圖形的邊上，若有則圖形不是多邊形。
        for jj=ii+2:size(pall,1)-1                             
            if(pall(ii,1)~=pall(jj,1))                         %斜率不一樣才需檢驗
                xinter=-1*(pall(ii,2)-pall(jj,2))/(pall(ii,1)-pall(jj,1)); %計算兩條線交點
                yinter=polyval(pall(ii,:),xinter);
                x1=X(point_combination(1,ii));                 %從point_combination中找兩條線是由哪四個點形成
                x2=X(point_combination(2,ii));
                x3=X(point_combination(1,jj));
                x4=X(point_combination(2,jj));
                y1=Y(point_combination(1,ii));
                y2=Y(point_combination(2,ii));
                y3=Y(point_combination(1,jj));
                y4=Y(point_combination(2,jj));
                if(xinter<max([x1 x2])&&xinter>min([x1 x2])&&yinter<max([y1 y2])&&yinter>min([y1 y2])...
                        &&xinter<max([x3 x4])&&xinter>min([x3 x4])&&yinter<max([y3 y4])&&yinter>min([y3 y4]))
                    check_polygon=false;                       %若交點在邊上則不是多邊形
                end
            end
        end
    end
    %以下迴圈檢驗其他的直線組合。
    for ii=2:(size(pall,1)-2)                                  
        for jj=ii+2:size(pall,1) 
            if(pall(ii,1)~=pall(jj,1))
                xinter=-1*(pall(ii,2)-pall(jj,2))/(pall(ii,1)-pall(jj,1));
                yinter=polyval(pall(ii,:),xinter);
                [xinter yinter];
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
        if(isconvex)
            disp('凸多邊形')
        else
            disp('凹多邊形')
        end
    else
        disp('不是多邊形')
    end
end
