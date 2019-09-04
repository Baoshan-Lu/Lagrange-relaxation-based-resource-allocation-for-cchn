function  [ClusterMat,kthClusterNum]=DistanceBasedSelection(SystemCoefficient,V2Inum,V2Vnum,option)

%V2I ȷ��һ���ִأ�������·����еľ�����������С


% load V2Icoord.mat V2Icoord;
% load V2Vcoord.mat V2Vcoord;
load([SystemCoefficient.VariablePath '\V2Icoord.mat'],'V2Icoord');
load([SystemCoefficient.VariablePath '\V2Vcoord.mat'],'V2Vcoord');


% V2Inum=3;
% V2Vnum=6;

% [ClusterMat,kthClusterNum]=RandV2VClustering(ClusterNum,V2Vnum)

ClusterMat=zeros(V2Inum,V2Vnum);
kthClusterNum=zeros(1,V2Inum);
InterI2K=zeros(1,V2Inum);

%% ������Զ�㷨

% V2Vvec=randperm(numel(1:V2Vnum))
V2Vvec=1:V2Vnum;
%�Ƚ�һ��V2V�Ž�����
% V2Vinit=randperm(numel(1:V2Inum))
ClusterNum=V2Inum;
if V2Vnum<ClusterNum
    InitVLCnum=V2Vnum;
else
    InitVLCnum=ClusterNum;
end
for i=1:InitVLCnum
    ClusterMat(i,1)=V2Vvec(1,i);
    kthClusterNum(1,i)=1;
end
if ClusterNum<V2Vnum
    
    for i=ClusterNum+1:V2Vnum
        ithV2V=V2Vvec(1,i);
        for j=1:V2Inum
            jthV2I=j;
            %V2V��BS�ľ���
            Dis_V2V_BS=Distan_a_b(V2Vcoord(1,ithV2V),V2Vcoord(2,ithV2V),500,500);
            Dis_V2I_V2V=Distan_a_b(V2Icoord(1,jthV2I),V2Icoord(2,jthV2I),...
                V2Vcoord(3,ithV2V),V2Vcoord(4,ithV2V));
            
            InterV2V_V2I=Dis_V2V_BS+Dis_V2I_V2V;
            
            %V2V�����V2V�ľ���
            Dis_V2V_V2V_sum=0;
            for k=1: kthClusterNum(1,j)
                Dis_V2V_V2V_1=Distan_a_b(V2Vcoord(1,ithV2V),V2Vcoord(2,ithV2V),...
                    V2Vcoord(3,ClusterMat(j,k)),V2Vcoord(4,ClusterMat(j,k)));
                Dis_V2V_V2V_2=Distan_a_b(V2Vcoord(1,ClusterMat(j,k)),V2Vcoord(2,ClusterMat(j,k)),...
                    V2Vcoord(3,ithV2V),V2Vcoord(4,ithV2V));
                Dis_V2V_V2V=Dis_V2V_V2V_1+Dis_V2V_V2V_2;
                Dis_V2V_V2V_sum=Dis_V2V_V2V_sum+Dis_V2V_V2V;
            end
            Average=(Dis_V2V_BS+ Dis_V2I_V2V+Dis_V2V_V2V_sum)/(2+2*kthClusterNum(1,j));
            InterI2K(1,j)=Average/1000;
        end
        if option==1 %�������
            [~,VLC_selected]=min(InterI2K);
        else %������Զ
            [~,VLC_selected]=max(InterI2K);
        end
        ClusterMat(VLC_selected,kthClusterNum(1,VLC_selected)+1)=ithV2V;%��iV2V�Ž�����
        kthClusterNum(1,VLC_selected)=kthClusterNum(1,VLC_selected)+1;
    end
end
