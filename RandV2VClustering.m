function [ClusterMat,kthClusterNum]=RandV2VClustering(ClusterNum,V2Vnum)
ClusterMat=zeros(ClusterNum,V2Vnum);
kthClusterNum=zeros(1,ClusterNum);

for i=1:V2Vnum
    %���ѡ��һ����
    VLCselect=randint(1,1,[1,ClusterNum]);
    ClusterMat(VLCselect,kthClusterNum(1,VLCselect)+1)=i;%��i�����VLCselect
    kthClusterNum(1,VLCselect)=kthClusterNum(1,VLCselect)+1;%��VLCselect,����
end
