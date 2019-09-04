function [MATCHING,COST,TIME]=ThreeD__GameAsignment(A,MaxBalance)
t0=cputime;
[CUnumb,D2Dnumb,RSnumb]=size(A);
CU=1:CUnumb;
[D2D]=GenerateRandintVector(D2Dnumb);%���D2D���
[RS]=GenerateRandintVector(RSnumb);%���RS���
R=0;
for i=1:CUnumb%�����ܺ�
    R=A(CU(1,i),D2D(1,i),RS(1,i))+R;
end
count=0;
R2=zeros(1,3);
loop=5*MaxBalance;
R5=zeros(1,loop);

    MATCHING(1,:)=CU;
    MATCHING(2,:)=D2D;
    MATCHING(3,:)=RS;
    TIME=cputime-t0;
    COST=R;
% if  CUnumb==1 %���ֻ��һ����ֱ�ӷ��ؽ��
%     MATCHING(1,:)=CU;
%     MATCHING(2,:)=D2D;
%     MATCHING(3,:)=RS;
%     TIME=cputime-t0;
%     COST=R;
% else
%     for i=1:loop
%         Goup=GenerateRandintVector(CUnumb);
%         R1=A(CU(1,Goup(1,1)),D2D(1,Goup(1,1)),RS(1,Goup(1,1)))+...%��ʼ����ĺ�
%             A(CU(1,Goup(1,2)),D2D(1,Goup(1,2)),RS(1,Goup(1,2)));
%         R2(1,1)=A(CU(1,Goup(1,1)),D2D(1,Goup(1,2)),RS(1,Goup(1,1)))+...%D2D����
%             A(CU(1,Goup(1,2)),D2D(1,Goup(1,1)),RS(1,Goup(1,2)));
%         R2(1,2)=A(CU(1,Goup(1,1)),D2D(1,Goup(1,1)),RS(1,Goup(1,2)))+...%RS����
%             A(CU(1,Goup(1,2)),D2D(1,Goup(1,2)),RS(1,Goup(1,1)));
%         R2(1,3)=A(CU(1,Goup(1,1)),D2D(1,Goup(1,2)),RS(1,Goup(1,2)))+...%D2D,RSͬʱ����
%             A(CU(1,Goup(1,2)),D2D(1,Goup(1,1)),RS(1,Goup(1,1)));
%         
%         [x,y]=min(R2);%ȡ��Сֵ
%         
%         if x<R1
%             switch(y)
%                 case 1
%                     Temp=D2D(1,Goup(1,1));
%                     D2D(1,Goup(1,1))=D2D(1,Goup(1,2));
%                     D2D(1,Goup(1,2))=Temp;
%                 case 2
%                     Temp=RS(1,Goup(1,1));
%                     RS(1,Goup(1,1))=RS(1,Goup(1,2));
%                     RS(1,Goup(1,2))=Temp;
%                 otherwise
%                     Temp=D2D(1,Goup(1,1));
%                     D2D(1,Goup(1,1))=D2D(1,Goup(1,2));
%                     D2D(1,Goup(1,2))=Temp;
%                     Temp=RS(1,Goup(1,1));
%                     RS(1,Goup(1,1))=RS(1,Goup(1,2));
%                     RS(1,Goup(1,2))=Temp;
%             end
%             
%             R=R-(R1-x);%�������ܺ�
%             count=0;
%             
%         else
%             count=count+1;
%         end
%         R5(1,i)=R;
%         k=i;
%         if(count>MaxBalance)%�������ƽ����������Ϊ�ﵽ��ʲ����
%             break;
%         end
%         
%     end
%     MATCHING(1,:)=CU;
%     MATCHING(2,:)=D2D;
%     MATCHING(3,:)=RS;
%     TIME=cputime-t0;
%     COST=R;
% end

%  plot(1:k,R5(1,1:k),'-*','linewidth',1.5,'MarkerSize',5);

