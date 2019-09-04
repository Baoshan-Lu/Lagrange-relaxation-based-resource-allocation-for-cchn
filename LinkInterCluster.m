function TotalInterfer=LinkInterCluster(SystemCoefficient,UserVec,V2Ista,fthRB)
% ������ڸ���
% UserVec,RBnum,V2Ista,fthRB

% UserVec=[2,1,5,6],RBnum=1,V2Ista=6,fthRB=1

% load V2Icoord.mat V2Icoord;
% load V2Vcoord.mat V2Vcoord;
% load Fg_V2V_BS.mat Fg_V2V_BS
% load Fg_V2V_mat.mat Fg_V2V_mat
% load Fg_V2I_mat.mat Fg_V2I_mat
% load Fg_V2V_V2I_mat.mat Fg_V2V_V2I_mat
% load Fg_V2V_V2V_mat.mat Fg_V2V_V2V_mat

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


BS_x=547;
BS_y=547;

% RBnum=V2Inum;
%����SNRѡ����ѵ�RB����������Link���б�

b=(UserVec~=0);
Usernum=sum(b(:));
% V2Ivec=0;
% V2Vvec=0;
% V2Vnum=0;
% for i=1:Usernum
%     if UserVec(1,i)>=V2Ista %��V2I
%         if V2Ivec==0
%             V2Ivec=UserVec(1,i);
%         else
%             V2Ivec=[V2Ivec UserVec(1,i)];%��V2I�������
%         end
%     else
%         if V2Vvec==0
%             V2Vvec=UserVec(1,i);
%         else
%             V2Vvec=[V2Vvec UserVec(1,i)];%��V2V�������
%         end
%         V2Vnum=V2Vnum+1;
%     end
% end

%���������������
PtrV2I= 0.1995;%����
PtrV2V= 0.1995;

TotalInterfer=0;%�ܸ���

for i=1:Usernum
    ithLink=UserVec(1,i);
    if ithLink>=V2Ista %V2I��·
        ithLinkTransX=V2Icoord(1,ithLink-V2Ista+1);
        ithLinkTransY=V2Icoord(2,ithLink-V2Ista+1);
        ithLinkRecX=BS_x;
        ithLinkRecXY=BS_y;
        
        Link1V2I=1;
        
    else %V2V��·
        ithLinkTransX=V2Vcoord(1,ithLink);
        ithLinkTransY=V2Vcoord(2,ithLink);
        ithLinkRecX=V2Vcoord(3,ithLink);
        ithLinkRecXY=V2Vcoord(4,ithLink);
        Link1V2I=0;
    end
    
    UserVecTemp=UserVec;
    UserVecTemp(:,i)=[];
    
    TotalInterfer1=0;
    
    for j=1:Usernum-1
        jthLink=UserVecTemp(1,j);
        if jthLink>=V2Ista %V2I��·
            jthLinkTransX=V2Icoord(1,jthLink-V2Ista+1);
            jthLinkTransY=V2Icoord(2,jthLink-V2Ista+1);
            jthLinkRecX=BS_x;
            jthLinkRecXY=BS_y;
            Link2V2I=1;
        else %V2V��·
            jthLinkTransX=V2Vcoord(1,jthLink);
            jthLinkTransY=V2Vcoord(2,jthLink);
            jthLinkRecX=V2Vcoord(3,jthLink);
            jthLinkRecXY=V2Vcoord(4,jthLink);
            Link2V2I=0;
        end
        
        % �������
        if Link1V2I==1 && Link2V2I==1 %����V2I����,����
            Interfer=inf;
            
        elseif Link1V2I==1 && Link2V2I==0 %��һ����·ΪV2I
            
            Interfer1=PtrV2I*Fg_V2V_V2I_mat(ithLink-V2Ista+1,jthLink,fthRB)*...
                (Distan_a_b(ithLinkTransX,ithLinkTransY,jthLinkRecX,jthLinkRecXY))^(-4);
            
            Interfer2=PtrV2I*Fg_V2V_V2I_mat(jthLink,ithLink-V2Ista+1,fthRB)*...
                (Distan_a_b(jthLinkTransX,jthLinkTransY,ithLinkRecX,ithLinkRecXY))^(-4);
            
            Interfer=Interfer1+Interfer2;
            
            
        elseif Link1V2I==0 && Link2V2I==1 %��er����·ΪV2I
            Interfer1=PtrV2I*Fg_V2V_V2I_mat(ithLink,jthLink-V2Ista+1,fthRB)*...
                (Distan_a_b(ithLinkTransX,ithLinkTransY,jthLinkRecX,jthLinkRecXY))^(-4);
            
            Interfer2=PtrV2V*Fg_V2V_V2I_mat(jthLink-V2Ista+1,ithLink,fthRB)*...
                (Distan_a_b(jthLinkTransX,jthLinkTransY,ithLinkRecX,ithLinkRecXY))^(-4);
            
            Interfer=Interfer1+Interfer2;
            
            
        elseif Link1V2I==0 && Link2V2I==0 %��һ����·ΪV2V
            Interfer1=PtrV2V*Fg_V2V_V2V_mat(ithLink,jthLink,fthRB)*...
                (Distan_a_b(ithLinkTransX,ithLinkTransY,jthLinkRecX,jthLinkRecXY))^(-4);
            
            Interfer2=PtrV2V*Fg_V2V_V2V_mat(jthLink,ithLink,fthRB)*...
                (Distan_a_b(jthLinkTransX,jthLinkTransY,ithLinkRecX,ithLinkRecXY))^(-4);
            
            Interfer=Interfer1+Interfer2;

        end
        
        TotalInterfer1=TotalInterfer1+Interfer;
    end
    
    TotalInterfer=TotalInterfer+TotalInterfer1;
    
    
end
