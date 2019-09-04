function [ClusterMat,kthClusterNum]=RandClustering(ClusterNum,V2Vnum2)
%randomly generate the V2V clusters
if V2Vnum2<ClusterNum %������V2V�����쳣
    fprintf(1,'Warning:the Cluster number is more than that of V2V,Exit!!! ');
    ClusterMat=0;
    kthClusterNum=0;
else
    ClusterMat=zeros(ClusterNum,V2Vnum2);
% %     load('V2Vcoord.mat');
% %     [~,V2Vcoordnum]=size(V2Vcoord);
% %     [ranvec2]=GenerateRandintVector(V2Vcoordnum);
% %     V2Vranvec=ranvec2(1:V2Vnum2);%�����ѡ��V2Vnum�� 
    
    V2Vranvec=(1:V2Vnum2);%�����ѡ��V2Vnum�� 
    kthClusterNum=ones(1,ClusterNum);
    
    %�������һ��V2V��ÿ���أ�ȷ��ÿ����������һ��
    ranvec1=V2Vranvec(1:ClusterNum);
    ClusterMat(:,1)=ranvec1';
   
    %������������أ��ٷ���һ��V2V�������
    Restranvec=V2Vranvec(1+ClusterNum:V2Vnum2);
    [~,restv2vNum]=size(Restranvec);
    for i=1:restv2vNum
        CluNum=randint(1,1,[1,ClusterNum]);%����ѡ��һ��
        for j=1:V2Vnum2
            if ClusterMat(CluNum,j)==0 %if ClusterMat(CluNum,j)is empty,insert new element
                ClusterMat(CluNum,j)=Restranvec(1,i);%��δ�����V2V���ӵ�һ����ʼ���䵽����Ĵ�
                kthClusterNum(1,CluNum)=kthClusterNum(1,CluNum)+1;
                break;
            end
        end
    end
end



