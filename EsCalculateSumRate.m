function [SumRateMat]=EsCalculateSumRate(V2Inum,V2Vnum)

RBnum=V2Inum;
ClusterNum=V2Inum;
SumRateMat=zeros(V2Inum,RBnum,ClusterNum);

%��һ������ִ�
ClusterNum=V2Inum;
% [V2VCluster,kthClusterNum]=RandClustering(ClusterNum,V2Vnum);
% save V2VCluster.mat V2VCluster  %�������Ĵ���V2V����
% save kthClusterNum.mat kthClusterNum  %����V2V
% 
% %ʹ������ִغ������
% load V2VCluster.mat V2VCluster;
% load kthClusterNum.mat  kthClusterNum;
% %�ڶ�������Ȩֵ���ó����ʾ���
count=0;
for i=1:V2Inum
    for f=1:RBnum
        for k=1:ClusterNum
          [Rifk]=CalculateWeightofV2I_RB_VLC(i,f,k,V2VCluster,kthClusterNum);
          SumRateMat(i,f,k)=Rifk;
          count=count+1
        end
    end
end
% SumRateMat
save('SumRateMat');
