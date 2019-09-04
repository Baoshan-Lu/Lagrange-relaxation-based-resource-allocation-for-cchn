function [DHrate,ClusterMat,kthClusterNum]=DistaceVLCbasedHGrate(SystemCoefficient,V2Inum,V2Vnum,option)
% V2Inum,V2Vnum

%V2I-V2V���
% [ClusterMat,kthClusterNum]=LargeScaleModelClustering(V2Inum,V2Vnum);
[ClusterMat,kthClusterNum]=DistanceBasedSelection(SystemCoefficient,V2Inum,V2Vnum,option);
A=zeros(V2Inum,V2Inum);
for i=1:V2Inum
    ithV2I=i;jthVLC=i;
    for f=1:V2Inum
        rate=CalculateWeightofV2I_RB_VLC(SystemCoefficient,ithV2I,f,jthVLC,ClusterMat,kthClusterNum);
        A(i,f)=rate;
    end
end

maxV = max(max(max(A)));%ת��Ϊ��С�Ż�
RateOverNetSizeMat=maxV-A;

[Matching,~] = Hungarian(RateOverNetSizeMat);

DHrate=sum(sum(Matching.*A));
