function [CGrate_old,t]=CoorperativeGameforV2V(SystemCoefficient,V2VCluster,kthClusterNum)
%�������Ż�����
V2Inum=size(V2VCluster,1);
RBnum=V2Inum;
ClusterNum=V2Inum;
SumRateMat=zeros(V2Inum,RBnum,ClusterNum);
MaxFailNum=15+(V2Inum+sum(kthClusterNum));
tic
%% �������5*(V2Inum+sum(kthClusterNum))
ClusterNum=V2Inum;
% [V2VCluster,kthClusterNum]=RandV2VClustering(ClusterNum,V2Vnum);V2Inum,V2Vnum,


%% �������ʾ���

for i=1:V2Inum
    for f=1:RBnum
        for k=1:ClusterNum
            [Rifk]=CalculateWeightofV2I_RB_VLC(SystemCoefficient,i,f,k,V2VCluster,kthClusterNum);
            SumRateMat(i,f,k)=Rifk;
        end
    end
end

%% LR��άƥ��

[LRMatching,CGrate_old,LRTIME]=ThreeD_LagrangianRelaxation(SumRateMat);

if V2Inum<2
    
    GameInfor=['Only one V2I link!']
else

    %% ����
    converg=0;
    % MaxFailNum=100;%ʧ�ܴ���
    BreakCount=0;
  
    % ���շݴ����
    ClusterMat_Fin=V2VCluster;
    kthClusterNum_Fin=kthClusterNum;
    
    while (converg==0)
        
        %% ���ѡһ����
        %     RanClu=randint(1,1,[1,ClusterNum])
        [ranvec2]=GenerateRandintVector(ClusterNum);
        for i=1:ClusterNum
            if kthClusterNum(1,ranvec2(1,i))~=0
                RanClu1=ranvec2(1,i);
                ranvec2(:,i)=[];
                break;
            end
        end
        
        %ѡ������һ����
        
        ranvec3=GenerateRandintVector(ClusterNum-1);
        RanC=ranvec2(1,ranvec3(1,1));
        
        %���ѡ��RanClu1���е�һ��V2V
        
        RanV2V1=randint(1,1,[1,kthClusterNum(1,RanClu1)]);
        
        %�������ѡ�������һ����
        %����һ����
        RanClu2=RanC;
        V2VCluster(RanClu2,kthClusterNum(1,RanClu2)+1)=V2VCluster(RanClu1,RanV2V1);%����RanClu2�صĺ���
        
        %��һ���أ����RanV2V1<kthClusterNum(1,RanClu1),��Ҫ�ƶ�,������V2V����
        G=kthClusterNum(1,RanClu1)-RanV2V1;
        if RanV2V1<kthClusterNum(1,RanClu1)
            for i=1:G
                V2VCluster(RanClu1,RanV2V1)= V2VCluster(RanClu1,RanV2V1+i);
            end
        end
        V2VCluster(RanClu1,kthClusterNum(1,RanClu1))=0;
        kthClusterNum(1,RanClu1)=kthClusterNum(1,RanClu1)-1;
        
        %�ڶ����أ�
        kthClusterNum(1,RanClu2)=kthClusterNum(1,RanClu2)+1;%����V2V����
        
        
        
        
        %% �������
        for i=1:V2Inum
            for f=1:RBnum
                for k=1:ClusterNum
                    [Rifk]=CalculateWeightofV2I_RB_VLC(SystemCoefficient,i,f,k,V2VCluster,kthClusterNum);
                    SumRateMat(i,f,k)=Rifk;
                end
            end
        end
        %%  ���¼���LR����
        [LRMatching,LRrate_new,LRTIME]=ThreeD_LagrangianRelaxation(SumRateMat);
        
        if (LRrate_new>CGrate_old)%����и���
            CGrate_old=LRrate_new;
            
            %�����ŵķִط������շִ�
            ClusterMat_Fin=V2VCluster;
            kthClusterNum_Fin=kthClusterNum;
            
            
            BreakCount=0;%��ͷ����
        else
            %���ܸ��ƣ�����ԭ���ķִ�
            V2VCluster=ClusterMat_Fin;
            kthClusterNum=kthClusterNum_Fin;
            
            
            BreakCount=BreakCount+1;%�޷����ƣ������
            if BreakCount>MaxFailNum
                converg=1;%�㷨����
            end
            
        end
        GameInfor=['RanVLC1=',num2str(RanClu1),', RanVLC2=',num2str(RanClu2),',  CGrate_old=',num2str(CGrate_old),', CGrate_new=',num2str(LRrate_new),', BreakCount=',num2str(BreakCount)]
        
    end
end
t=toc;
% V2VCluster
% LRrate_old