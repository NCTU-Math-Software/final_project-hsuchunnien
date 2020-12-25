# 多邊形判斷
使用者任意依序選取平面上 n 個點, 判斷其是否為多邊形.

## ispolygon

#### 執行方法

* 下載ispolygon.m程式放在MATLAB資料夾中後，在Command Window中輸入ispolygon，執行程式。

#### 程式介紹

* 程式要求使用者在「check polygon」的視窗中用滑鼠左鍵依序輸入點，按滑鼠右鍵停止輸入，程式會判斷將點依序連起來的圖形是凸多邊形、凹多邊形或不是多邊形，並輸出在Command Window中。


#### 是否是多邊形

* 用ginput拿到輸入點分別的x座標陣列和y座標陣列

* 相鄰兩點用polyfit做多項式

* 檢測不相臨兩多項式的交點有無在多項式的邊上(頂點不算)，若有則不是多邊形

![image](https://github.com/NCTU-Math-Software/final_project-hsuchunnien/blob/main/%E4%B8%8D%E6%98%AF%E5%A4%9A%E9%82%8A%E5%BD%A2%E4%BE%8B%E5%AD%90.jpg)



#### 凸或凹多邊形

* 用x座標陣列和y座標陣列得出第1點到第2點、第2點到第3點、...、第n點到第1點的向量

* 計算相鄰兩向量構成的矩陣的determinant，觀察每個矩陣的determinant，若有變號即為凹多邊形
