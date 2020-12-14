function origin_triangle(x1,y1,x2,y2,x3,y3)
    p1=polyfit([x1 x2],[y1 y2],1);
    p2=polyfit([x2 x3],[y2 y3],1);
    p3=polyfit([x3 x1],[y3 y1],1);
    if p1(2)*(p1(1)*x3-y3+p1(2))<0
        disp('原點沒有在裡面')
    elseif p2(2)*(p2(1)*x1-y1+p2(2))<0
        disp('原點沒有在裡面')
    elseif p3(2)*(p3(1)*x2-y2+p3(2))<0
        disp('原點沒有在裡面')
    else
        disp('原點在裡面')
    end
end