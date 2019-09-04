function [SumRateMat]=CalculateSumRate(SystemCoefficient,V2Inum,V2Vnum)
RBnum=V2Inum;
ClusterNum=V2Inum;
SumRateMat=zeros(V2Inum,RBnum,ClusterNum);

%��һ������ִ�
ClusterNum=V2Inum;
% [V2VCluster,kthClusterNum]=RandV2VClustering(ClusterNum,V2Vnum);

[V2VCluster,kthClusterNum]=DistanceBasedSelection(SystemCoefficient,V2Inum,V2Vnum,2);

% save V2VCluster.mat V2VCluster  %�������Ĵ���V2V����
% save kthClusterNum.mat kthClusterNum  %����V2V
% 
% %ʹ������ִغ������
% load V2VCluster.mat V2VCluster;
% load kthClusterNum.mat  kthClusterNum;
%�ڶ�������Ȩֵ���ó����ʾ���
count=0;
for i=1:V2Inum
    for f=1:RBnum
        for k=1:ClusterNum
          [Rifk]=CalculateWeightofV2I_RB_VLC(SystemCoefficient,i,f,k,V2VCluster,kthClusterNum);
          SumRateMat(i,f,k)=Rifk;
          count=count+1
        end
    end
end
% SumRateMat
% save('SumRateMat');
