clc;
clear;
PtrV2I= 0.1995;%����
PtrV2V= 0.1995;
P_Noise=3.9811e-15;%�������� -174dbm/Hz
Bandwith=10*10^6; %���� 10M
R0=2.6e+03;     %��С����Ҫ��
BS_x=0;BS_y=0;   %��վλ��
Radius=1000;    %��վ���Ƿ�Χ
SingleLaneWidth=4*3;    %���߳�����
IntermediateBand=4;    %���Ĵ�

V2Inum=30;V2Vnum=100;
minV2Vdistan=10; %V2V֮��ľ���
maxV2Vdistan=60;
MRQ=power(10,3);Range=0;%MRQ�����Լ��������
%����·��
formatOut = 'yy_mm_dd';
SimuTimeHistory=datestr(now,formatOut);
FigurePath=['����ͼƬ\Experiment_20' SimuTimeHistory '\'];
VariablePath=['��������\Experiment_20' SimuTimeHistory '\'];
if  ~exist(FigurePath)
    mkdir(FigurePath);%%%��ⲻ��·�������½�
end
if  ~exist(VariablePath)
    mkdir(VariablePath);%%%��ⲻ��·�������½�
end

FigFormat='.fig';%����ͼƬ��ʽ

%% =================================================================
%% ---------------------------������ʽ-------------------------------
%% =================================================================
SimMode='Calculate';
% SimMode='Plot';'Calculate';
NewModel=0; %ʹ�þ�ģ��
%���ò���
SystemCoefficient=struct('FigurePath',FigurePath,'FigFormat',FigFormat,...
    'VariablePath',VariablePath,'SimMode',SimMode,'NewModel',NewModel,...
    'PtrV2I',PtrV2I,'PtrV2V',PtrV2V,'P_Noise',P_Noise,'Bandwith',Bandwith...
    ,'V2Inum',V2Inum,'V2Vnum',V2Vnum,'Radius',Radius,'BS_x',BS_x,'BS_y',BS_y,...
    'minV2Vdistan',minV2Vdistan,'maxV2Vdistan',maxV2Vdistan,'MRQ',MRQ,'Range',Range)


%% ģ��
if NewModel==1
    VehicularNetworksModel(SystemCoefficient) 
    %% ��������
    FrequencyGain(SystemCoefficient)
end
%% =================================================================
%% --------------���������㷨(LR)������---------------------
%% =================================================================

%% LR�㷨��֤

V2Inum=5,V2Vnum=20,loop=20,LearingRate=0.1
VariLR(SystemCoefficient,V2Inum,V2Vnum,loop,LearingRate)

%% LR��ES�����ܶԱ�

% V2Ista=2;V2VnumRange=[20,30];loop=8;
% PlotLRversusES(SystemCoefficient,V2Ista,V2VnumRange,loop)


%% LR,IHM,GRD�㷨�Ա�

%%������V2I����
% V2InumSta=2,V2VnumRange=[20,20],loop=8
% PlotCompareLR_IHM_GRD_V2Inum(SystemCoefficient,V2InumSta,V2VnumRange,loop)

%%������V2V����
% V2InumRange=[9,9]; V2VnumSta=20; loop=8;
% PlotCompareLR_IHM_GRD(SystemCoefficient,V2InumRange,V2VnumSta,loop)

%% =================================================================
%% --------------�����㷨(CG)������---------------------
%% =================================================================

%% CG��ES���ܶԱ�

% % % %����V2V�����仯
% V2Inum=4,V2Vsta=2,loop=8
% PlotCGversusES(SystemCoefficient,V2Inum,V2Vsta,loop)


%% CG��InGRA,MAD,RD���ܶԱ�

% % %%����V2I�仯
% V2Vnum=15;V2Ista=2;loop=8;
% PlotCGversusDHG_V2Ivari(SystemCoefficient,V2Ista,V2Vnum,loop)
% % 
% % % %%����V2V�仯
% V2Inum=6;V2Vsta=20; loop=8;
% PlotCGversusDHG(SystemCoefficient,V2Inum,V2Vsta,loop)

%%% ������С����Ҫ��仯
% V2Inum=7;V2Vnum=20;RminSta=power(10,5);loop=8;
% PlotV2ImimRateVari(SystemCoefficient,V2Inum,V2Vnum,RminSta,loop)


%%% ���ų����ܶȱ仯
% loop=8;SpeedSta=15;
% PlotVehicleSpeedVariCompare(SystemCoefficient,SpeedSta,loop)
