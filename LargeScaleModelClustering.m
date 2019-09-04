function [ClusterMat,kthClusterNum]=LargeScaleModelClustering(V2Inum,V2Vnum)
% function LargeScaleModelClustering()
% V2Inum=8,V2Vnum=15

load V2Icoord.mat V2Icoord;
load V2Vcoord.mat V2Vcoord;


ClusterNum=V2Inum;
kthClusterNum=zeros(1,ClusterNum);
ClusterMat=zeros(ClusterNum,V2Vnum);

% V2Vvec=randperm(numel(1:V2Vnum));%���V2V����
V2Vvec=1:V2Vnum;
%% ��ʼ����ÿ������һ��V2V
if V2Vnum<ClusterNum
    InitVLCnum=V2Vnum;
else
     InitVLCnum=ClusterNum;
end
for i=1:InitVLCnum
    ClusterMat(i,1)=V2Vvec(1,i);
    kthClusterNum(1,i)=1;
end

%% ʣ���V2V�����ݾ���ѡ��
InterI2K=zeros(1,ClusterNum);
if ClusterNum<V2Vnum %��V2VԶ���ڴ�������ʼ������һ����ѡȡ
    for i=ClusterNum+1:V2Vnum       
        ithV2V=V2Vvec(1,i);
        for j=1:ClusterNum %��
            ClusterInter=0;
            for k=1:kthClusterNum(1,j) %����V2V����
                %����V2V i �� ���� V2V k�ĸ���
                i2k_Iter=Distan_a_b(V2Vcoord(1,ithV2V),V2Vcoord(2,ithV2V),...
                    V2Vcoord(3,ClusterMat(j,k)),V2Vcoord(4,ClusterMat(j,k)));
                k2i_Iter=Distan_a_b(V2Vcoord(1,ClusterMat(j,k)),V2Vcoord(2,ClusterMat(j,k)),...
                    V2Vcoord(3,ithV2V),V2Vcoord(4,ithV2V));
                ClusterInter=ClusterInter+i2k_Iter+k2i_Iter;               
            end
            Average=ClusterInter/(2*kthClusterNum(1,j));
            InterI2K(1,j)=Average/1000;
        end
        [~,VLC_selected]=max(InterI2K);%ѡ����
        ClusterMat(VLC_selected,kthClusterNum(1,VLC_selected)+1)=ithV2V;%��iV2V�Ž�����
        kthClusterNum(1,VLC_selected)=kthClusterNum(1,VLC_selected)+1;
    end
end
