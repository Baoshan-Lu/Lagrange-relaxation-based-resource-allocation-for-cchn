function [RateV2I]=CalculateRateV2I_RB(SystemCoefficient,ithV2I,fthRB)
%calculate the V2I-RB-VLC weight
%system cooefficient
% PtrV2I= 0.1995;%����
% PtrV2V= 0.1995;
% P_Noise=3.9811e-15;%�������� -174dbm/Hz
% Bandwith=10*10^6; %���� 10M
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
% load Fg_V2V_BS.mat Fg_V2V_BS
% load Fg_V2V_mat.mat Fg_V2V_mat
% load Fg_V2I_mat.mat Fg_V2I_mat
% load Fg_V2V_V2I_mat.mat Fg_V2V_V2I_mat
% load Fg_V2V_V2V_mat.mat Fg_V2V_V2V_mat
% 
% load V2I_min_Rate.mat V2I_min_Rate
% 
% load('V2Icoord.mat');
% load('V2Vcoord.mat');

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


% BS_x=547;
% BS_y=547;

%�������V2V���ʺͣ�V2I������
Pj_BS_rec=0;
%��i��V2I��BS���Ĺ���
% Pi_rec=PtrV2I*ChannelGain(V2Icoord(1,ithV2I),V2Icoord(2,ithV2I),500,500,fc,1);
Pi_rec=PtrV2I*Fg_V2I_mat(ithV2I,fthRB)*Pathloss(V2Icoord(1,ithV2I),V2Icoord(2,ithV2I), BS_x,BS_y);
%�����kΪ��,����ֱ��Ϊ0

    %V2I������
RateV2I=Bandwith*log(1+Pi_rec/(P_Noise+Pj_BS_rec));%������V2V��BS�����и���
    
