function PlotGD_NF_FF_RD()

%LRCG��ES�����ܶԱ�

% V2Inum,V2Vsta,loop

V2Inum=10,V2Vsta=20,loop=8

% loop=3;
% V2Vnum=6;
% V2Inum=4;

MaxFailNum=200;

CGrateMat=zeros(1,loop);
NFrateMat=zeros(1,loop);
FFrateMat=zeros(1,loop);
RDrateMat=zeros(1,loop);


a=V2Vsta;

h=waitbar(0,'LR+CG��FF�ԶԱȼ����У����Ժ�');

for i=1:loop
    i
    %     V2Inum=i+a;
    V2Vnum=i+a-1;
    
    %LR+CG
    GDsumrate= GreedyAllocateRate(V2Inum,V2Vnum)
%     [LRrate,t1]=CoorperativeGameforV2V(V2Inum,V2Vnum,MaxFailNum);
    CGrateMat(1,i)=GDsumrate;
    
    
    %�������
    DHrate1=DistaceVLCbasedHGrate(V2Inum,V2Vnum,1);
    NFrateMat(1,i)=DHrate1;
    
    %��Զ����
    DHrate2=DistaceVLCbasedHGrate(V2Inum,V2Vnum,2);%������Զ
    FFrateMat(1,i)=DHrate2;
    
    %�������
    RandomSumrate=RandomV2V_V2I_RB_allocate(V2Inum,V2Vnum);
    RDrateMat(1,i)=RandomSumrate;
    
    str=['LR+CG��FF,NF,RD�ԶԱȼ�����...',num2str(100*i/(loop)),'%'];
    waitbar(i/(loop),h,str);
end

% save CGrateMat.mat CGrateMat
% save NFrateMat.mat NFrateMat
% save FFrateMat.mat FFrateMat
% save RDrateMat.mat RDrateMat
% 
% load RDrateMat.mat RDrateMat
% load FFrateMat.mat FFrateMat
% load CGrateMat.mat CGrateMat
% load NFrateMat.mat NFrateMat


figure
plot((1:loop)+a,CGrateMat,'-or','linewidth',1.5,'MarkerSize',10);
hold on
plot((1:loop)+a,NFrateMat,'->','linewidth',1.5,'MarkerSize',10);
hold on
plot((1:loop)+a,FFrateMat,'-sg','linewidth',1.5,'MarkerSize',10);
hold on
plot((1:loop)+a,RDrateMat,'-<k','linewidth',1.5,'MarkerSize',10);

xlabel({'The number of V2V links'},'FontName','Times New Roman','FontSize',13);
ylabel({'Sum-rate (nat/s)'},'FontName','Times New Roman','FontSize',13);
s1=legend('GD','NF','FF','RD',2);
set(s1, 'FontName','Times New Roman','FontSize',13);
grid on

