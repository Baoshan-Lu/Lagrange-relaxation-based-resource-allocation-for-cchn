function [Rifk]=CalculateWeightofV2I_RB_VLC(SystemCoefficient,ithV2I,fthRB,kthV2Vcluster,V2VCluster,kthClusterNum)
%calculate the V2I-RB-VLC weight
%system cooefficient
Bandwith=SystemCoefficient.Bandwith;
P_Noise=SystemCoefficient.P_Noise;
PtrV2V=SystemCoefficient.PtrV2V;
PtrV2I=SystemCoefficient.PtrV2I;

BS_x=SystemCoefficient.BS_x;
BS_y=SystemCoefficient.BS_y;


%minimum rate requiremnt
% R0=2.6e+03; %��С����Ҫ��
% R0=0;
%RB carrier
% fc=2.5+fthRB*0.1/2;


load([SystemCoefficient.VariablePath '\Fg_V2V_BS.mat'],'Fg_V2V_BS');
load([SystemCoefficient.VariablePath '\Fg_V2V_mat.mat'],'Fg_V2V_mat');

load([SystemCoefficient.VariablePath '\Fg_V2I_mat.mat'],'Fg_V2I_mat');
load([SystemCoefficient.VariablePath '\Fg_V2V_V2I_mat.mat'],'Fg_V2V_V2I_mat');

load([SystemCoefficient.VariablePath '\Fg_V2V_V2V_mat.mat'],'Fg_V2V_V2V_mat');
load([SystemCoefficient.VariablePath '\V2I_min_Rate.mat'],'V2I_min_Rate');
% load Fg_V2V_BS.mat Fg_V2V_BS
% load Fg_V2V_mat.mat Fg_V2V_mat
% 
% load Fg_V2I_mat.mat Fg_V2I_mat
% load Fg_V2V_V2I_mat.mat Fg_V2V_V2I_mat
% load Fg_V2V_V2V_mat.mat Fg_V2V_V2V_mat
% 
% load V2I_min_Rate.mat V2I_min_Rate

% load V2I_min_Rate_Vari.mat V2I_min_Rate_Vari

% load('V2Icoord.mat');
% load('V2Vcoord.mat');
load([SystemCoefficient.VariablePath '\V2Icoord.mat'],'V2Icoord');
load([SystemCoefficient.VariablePath '\V2Vcoord.mat'],'V2Vcoord');



%�������V2V���ʺͣ�V2I������
Rj=0;
Pj_BS_rec=0;
%��i��V2I��BS���Ĺ���
% Pi_rec=PtrV2I*ChannelGain(V2Icoord(1,ithV2I),V2Icoord(2,ithV2I),500,500,fc,1);
NonV2I=0;
if ithV2I~=0  %�ǿ�V2I
    Pi_rec=PtrV2I*Fg_V2I_mat(ithV2I,fthRB)*Pathloss(V2Icoord(1,ithV2I),V2Icoord(2,ithV2I), BS_x,BS_y);
    
else
    Pi_rec=0;
    NonV2I=1;
end

%�����kΪ��,����ֱ��Ϊ0
if kthClusterNum(1,kthV2Vcluster)==0
    Rifk=0;
    
else%��k��Ϊ��
    
    for j=1:kthClusterNum(1,kthV2Vcluster) %һ��V2V������
        kthVLC=V2VCluster(kthV2Vcluster,:);%ȡ����K�ص�V2V
        
        jthV2V=kthVLC(1,j);
        %j�����
        jthV2Vtransmitter_x=V2Vcoord(1,kthVLC(1,j));
        jthV2Vtransmitter_y=V2Vcoord(2,kthVLC(1,j));
        %j���ն�
        jthV2Vreceiver_x=V2Vcoord(3,kthVLC(1,j));
        jthV2Vreceiver_y=V2Vcoord(4,kthVLC(1,j));
        %��j��V2V���ն˵Ĺ���
        %         Pj_rec=PtrV2V*ChannelGain(jthV2Vtransmitter_x,jthV2Vtransmitter_y,...
        %             jthV2Vreceiver_x,jthV2Vreceiver_y,fc,2);
        
        Pj_rec=PtrV2V*Fg_V2V_mat(jthV2V,fthRB)*Pathloss(jthV2Vtransmitter_x,jthV2Vtransmitter_y,...
            jthV2Vreceiver_x,jthV2Vreceiver_y);
        
        %��j��V2V���ն��ܵ�V2I��·�ĸ��Ź���
        if NonV2I~=1
            PithV2I_jthV2V=PtrV2I*Fg_V2V_V2I_mat(ithV2I,jthV2V,fthRB)*Pathloss(V2Icoord(1,ithV2I),V2Icoord(2,ithV2I),...
                jthV2Vreceiver_x,jthV2Vreceiver_y);
        else
            PithV2I_jthV2V=0;
        end
        %         kthVLC
        
        kthVLC(kthVLC==kthVLC(1,j))=[];%ɾ������j��,ʣ��Ϊ����
        
        Pj1_rec=0;
        %��jth V2V�����еĴ���V2V����
        
        %         kthClusterNum(1,kthV2Vcluster)-1
        
        for L=1:kthClusterNum(1,kthV2Vcluster)-1
            %j1�����
            j1thV2Vtransmitter_x=V2Vcoord(1,kthVLC(1,L));
            j1thV2Vtransmitter_y=V2Vcoord(2,kthVLC(1,L));
            j1thVLC=kthVLC(1,L);
            
            %�������V2V�Է����j���ն˵ĸ��Ź���
            %             Pj1_rec=Pj1_rec+PtrV2V*ChannelGain(j1thV2Vtransmitter_x,j1thV2Vtransmitter_y,...
            %                 jthV2Vreceiver_x,jthV2Vreceiver_y,fc,2);
            
            Pj1_rec=Pj1_rec+PtrV2V*Fg_V2V_V2V_mat(j1thVLC,jthV2V,fthRB)*...
                Pathloss(j1thV2Vtransmitter_x,j1thV2Vtransmitter_y,...
                jthV2Vreceiver_x,jthV2Vreceiver_y);
            
            %             %�������V2V��ithV2I�ĸ��Ź���
            %             Pj1_BS=Pj1_BS+PtrV2V*Fg_V2V_BS(1,kthVLC(1,L))*...
            %                 Pathloss(j1thV2Vtransmitter_x,j1thV2Vtransmitter_y,...
            %                 BS_x,BS_y);
            
            
        end
        %��j��V2V������,�������ʵ�
        Rj=Rj+Bandwith*log(1+Pj_rec/(P_Noise+PithV2I_jthV2V+Pj1_rec)); %������V2I���ţ�V2V���ڸ���
        
        %V2V������V2V�Ի�վ��V2I���ĸ��Ź���
        Pj_BS_rec=Pj_BS_rec+PtrV2V*Fg_V2V_BS(jthV2V,fthRB)*...
            Pathloss(jthV2Vtransmitter_x,jthV2Vtransmitter_y,...
            BS_x,BS_y);
    end
    
    %V2I������
    RateV2I=Bandwith*log(1+Pi_rec/(P_Noise+Pj_BS_rec));%������V2V��BS�����и���
    
    if NonV2I~=1%�ǿ�V2I
          R0=V2I_min_Rate(ithV2I,1);%V2I����Ҫ��
%         R0=0;
        if RateV2I>=R0 %�������������,Ϊ0
            Rifk=Rj;
        else
            Rifk=0;
        end
    else
        
        Rifk=Rj;
    end
    
end