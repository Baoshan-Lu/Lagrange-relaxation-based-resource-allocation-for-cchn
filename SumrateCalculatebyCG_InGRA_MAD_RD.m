function [CGrate,InGRArate,MADratr,RDrate]=SumrateCalculatebyCG_InGRA_MAD_RD(SystemCoefficient,V2Inum,V2Vnum)
%%IntraGRA�㷨
[InGRArate,~,ClusterMat_Fin,kthClusterNum_Fin]=IntraGraAlgoAvaible(SystemCoefficient,V2Inum,V2Vnum);
[CGrate,~]=CoorperativeGameforV2V(SystemCoefficient,ClusterMat_Fin,kthClusterNum_Fin);
%     % %     �������
%     DHrate1=DistaceVLCbasedHGrate(V2Inum,V2Vnum,1);

% %     %��Զ����
MADratr=DistaceVLCbasedHGrate(SystemCoefficient,V2Inum,V2Vnum,2);%������Զ


% %     %�������
RDrate=RandomV2V_V2I_RB_allocate(SystemCoefficient,V2Inum,V2Vnum);



