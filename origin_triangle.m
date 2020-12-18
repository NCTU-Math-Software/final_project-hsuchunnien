% 此程式要求使用者輸入平面上的一個三角形，程式會判斷原點是否在輸入的三角形內，原點若在邊上視為在三角形內。
% 輸入形式為:origin_triangle(x1,y1,x2,y2,x3,y3)
% 例如:
% input:origin_triangle(1,1,-2,3,-5,-4)
% output:原點沒有在裡面
function origin_triangle(x1,y1,x2,y2,x3,y3)
    p1=polyfit([x1 x2],[y1 y2],1);             %取任兩點用polyfit得到過兩點的多項式
    p2=polyfit([x2 x3],[y2 y3],1);
    p3=polyfit([x3 x1],[y3 y1],1);
    if p1(2)*(p1(1)*x3-y3+p1(2))<0             %檢驗另一點與原點是否在兩點畫出的直線同側，另一點與原點需均在三條直線同側，原點才在三角形中。
        disp('原點沒有在裡面')
    elseif p2(2)*(p2(1)*x1-y1+p2(2))<0
        disp('原點沒有在裡面')
    elseif p3(2)*(p3(1)*x2-y2+p3(2))<0
        disp('原點沒有在裡面')
    else
        disp('原點在裡面')
    end
end
