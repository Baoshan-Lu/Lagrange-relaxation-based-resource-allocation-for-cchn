function [CGrate,InGraRate,FFrate,RandomSumrate]=CompareToStateofartPollicies(V2Inum,V2Vnum)

max=0;
MaxFailNum=30;
%%IntraGRA�㷨
[InGraRate,~,ClusterMat_Fin1,kthClusterNum_Fin1]=IntraGraAlgoAvaible(V2Inum,V2Vnum);

if InGraRate>max
    ClusterMat_Fin=ClusterMat_Fin1;
    kthClusterNum_Fin=kthClusterNum_Fin1;
    max=InGraRate;
end
% %     %��Զ����
[FFrate,ClusterMat_Fin2,kthClusterNum_Fin2]=DistaceVLCbasedHGrate(V2Inum,V2Vnum,2);%������Զ
if FFrate>max
    ClusterMat_Fin=ClusterMat_Fin2;
    kthClusterNum_Fin=kthClusterNum_Fin2;
    max=FFrate;
end
% %     %�������
[RandomSumrate,ClusterMat_Fin3,kthClusterNum_Fin3]=RandomV2V_V2I_RB_allocate(V2Inum,V2Vnum);
if RandomSumrate>max
    ClusterMat_Fin=ClusterMat_Fin3;
    kthClusterNum_Fin=kthClusterNum_Fin3;
     max=RandomSumrate;
end


%LR+CG  ʹ��IntraGRA�㷨�ķɴ�
[CGrate,~]=CoorperativeGameforV2V(V2Inum,V2Vnum,MaxFailNum,ClusterMat_Fin,kthClusterNum_Fin);









% % %InGra
% % [InGraRate,t,ClusterMat_Fin,kthClusterNum_Fin]=IntraGraAlgoAvaible(V2Inum,V2Vnum);
% % 
% % %LR+CG
% % MaxFailNum=30;
% % [CGrate,~]=CoorperativeGameforV2V(V2Inum,V2Vnum,MaxFailNum,ClusterMat_Fin,kthClusterNum_Fin);
% % 
% % %��Զ����
% % FFrate=DistaceVLCbasedHGrate(V2Inum,V2Vnum,2);%������Զ
% % 
% % %�������
% % RandomSumrate=RandomV2V_V2I_RB_allocate(V2Inum,V2Vnum);
% % 
% % %�������
% % NFrate=DistaceVLCbasedHGrate(V2Inum,V2Vnum,1);


