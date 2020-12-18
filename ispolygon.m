%�D��:�h��ΧP�_:�ϥΪ̥��N�̧ǿ�������W n ���I, �P�_��O�_���h��ΡC
%�ϥΪ̦b�ù��W�ηƹ�����̧ǿ�J�I�A���ƹ��k�䰱���J�A�{���|�P�_�N�I�̧ǳs�_�Ӫ��ϧάO�_���h��ΡC
function ispolygon
    X=[];
    Y=[];
    pall=[];
    point_combination=[];
    array_vector=[];
    check_polygon=true;
    isconvex=true;
    
    if size(X,2)==3                       %�T���I�@�w�O�h���
        disp('�O�h���')
        return
    end
    axis([0 3 0 3]);
    hold on
    while 1
        [x,y,BUTTON] = ginput(1);         %�ƹ������J�I
        if(BUTTON==3)                     % ���ƹ��k��N������J
            break
        end
        X=[X x];
        Y=[Y y];
        plot([X],[Y],'k-');              %�e�X�I�X���h���
    end
    plot([X X(1)],[Y Y(1)]);              %�e�X�I�X���h���
    
    %�H�U�˴��ϧάO�W�ΥY�h��ΡA�̧Ǭ����V�q(1,2)�B(2,3),...,(n,1)�A�A�˴��۾F�V�q��determinant���t���L�ܰʡA���ܫh���W�h��ΡC
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

    
    for ii=1:(size(X,2)-1)
        p=polyfit([X(ii) X(ii+1)],[Y(ii) Y(ii+1)],1);          %���X�L�۾F���I���h�����A�I�Fn���I�N��n���h����
        point_combination=[point_combination [ii;ii+1]];       %紬����h�����O�ѭ�����I�Φ���
        pall=[pall;p];                                         
    end
    p=polyfit([X(size(X,2)) X(1)],[Y(size(X,2)) Y(1)],1);      %�̫�@�I�s�^�Ĥ@�I����W��
    point_combination=[point_combination [size(X,2);1]];
    pall=[pall;p];
    
    %�H�U�j������(1,3)�B(1,4)�B...�B(1,n-1)�����u�զX�C((1,2)�M(1,n)���۾F��A��������)
    for ii=1:(size(pall,1)-1)                                  %���簣�F�۾F�������H�~��������u�O�_���ۥ�b�ϧΪ���W�A�Y���h�ϧΤ��O�h��ΡC
        for jj=ii+2:size(pall,1)-1                             
            if(pall(ii,1)~=pall(jj,1))                         %�ײv���@�ˤ~������
                xinter=-1*(pall(ii,2)-pall(jj,2))/(pall(ii,1)-pall(jj,1)); %�p�����u���I
                yinter=polyval(pall(ii,:),xinter);
                x1=X(point_combination(1,ii));                 %�qpoint_combination�������u�O�ѭ��|���I�Φ�
                x2=X(point_combination(2,ii));
                x3=X(point_combination(1,jj));
                x4=X(point_combination(2,jj));
                y1=Y(point_combination(1,ii));
                y2=Y(point_combination(2,ii));
                y3=Y(point_combination(1,jj));
                y4=Y(point_combination(2,jj));
                if(xinter<max([x1 x2])&&xinter>min([x1 x2])&&yinter<max([y1 y2])&&yinter>min([y1 y2])...
                        &&xinter<max([x3 x4])&&xinter>min([x3 x4])&&yinter<max([y3 y4])&&yinter>min([y3 y4]))
                    check_polygon=false;                       %�Y���I�b��W�h���O�h���
                end
            end
        end
    end
    %�H�U�j�������L�����u�զX�C
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
            disp('�Y�h���')
        else
            disp('�W�h���')
        end
    else
        disp('���O�h���')
    end
end