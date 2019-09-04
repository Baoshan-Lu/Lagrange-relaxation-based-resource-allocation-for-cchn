function [SumRate,t,ClusterMat_Fin,kthClusterNum_Fin]=IntraGraAlgoAvaible(SystemCoefficient,V2Inum,V2Vnum)
% [ClusterMat_Fin,kthClusterNum_Fin]
% clc
% clear
% V2Vnum=20;V2Inum=3;
str=['��ʼ����InGRA�㷨...']

tic

V2Ista=V2Vnum+1;
RBnum=V2Inum;Usernum=V2Inum+V2Vnum;

V2Ilink=(1:V2Inum)+V2Vnum;

ClusterMat_Fin=zeros(RBnum,Usernum);
kthClusterNum_Fin=ones(1,RBnum);

%% �Ƚ�V2I�������ʽ��зִ�
V2Irate=zeros(V2Inum,RBnum);
for i=1:RBnum
    for j=1: V2Inum
        V2Il=V2Ilink(1,j);
        V2Irate(i,j)=RateofSingleCluster(SystemCoefficient,V2Il,V2Ista,i);
    end
end
[MATCH,~]=MaxHungarian(V2Irate);
for i=1:RBnum
    ClusterMat_Fin(i,1)=V2Ilink(1,MATCH(1,i));
end

%%  ��ʼ��V2V���зִ�

UserVec=1:V2Vnum;

%����SNRѡ����ѵ�RB����������Link���б�
[IntentionTable]=CreatBestList(SystemCoefficient,UserVec,RBnum,V2Ista);
[ClusterMat, kthClusterNum]=EstablishingClustersBasedonIntentionTables(UserVec,IntentionTable);

%�Ƿ��������
Nonempty=sum(kthClusterNum);
Finish=0;
while Nonempty>0  && Finish==0 %�Ӽ��ǿ�
    %% �������1��ʼ������û���û�
    for i=1:RBnum
        if  kthClusterNum(1,i)~=0
            fthRB=i;Finish=0;
            break;
        else
            Finish=1;
        end
    end
    if  Finish==0
        %% ��ʼ�����㷨
        Conflict_Update=0;
        
        Rifk=zeros(1,kthClusterNum(1,fthRB));
        %% ѡ��k������õ���·
        if kthClusterNum_Fin(1,fthRB)==0 %���л�û�û�ռ��
            for i=1:kthClusterNum(1,fthRB)
                Rifk(1,i)=RateofSingleCluster(SystemCoefficient,ClusterMat(fthRB,:),V2Ista,fthRB);
            end
            [~,s]=max(Rifk);%ѡ�����������û�����
            LinkSelected=ClusterMat(fthRB,s);
            
        else
            %% �����Ѿ����û�,ѡ��ʹ������С��
            InterferList=zeros(1,kthClusterNum(1,fthRB));
            for i=1:kthClusterNum(1,fthRB)
                
                kthCluUserVec=zeros(1,kthClusterNum_Fin(1,fthRB));
                
                for k=1:kthClusterNum_Fin(1,fthRB)
                    kthCluUserVec(1,k)=ClusterMat_Fin(fthRB,k); %Ҫ��ԭ����λ��
                end
                
                %���Ž� �����ClusterMat(fthRB,i)���û�i�Ž�ȥ
                SelectedVirLink=ClusterMat(fthRB,i);
                kthCluUserVec=[kthCluUserVec SelectedVirLink];
                
                %����������
                InterferNew=LinkInterCluster(SystemCoefficient,kthCluUserVec,V2Ista,fthRB);
                InterferList(1,i)=InterferNew;
            end
            %% ѡ�����������û�����
            [MinInterfer,s]=min(InterferList);
            if MinInterfer==inf %�����С�Ķ���inf����V2I��·
                %����V2I��·��ͬһ���أ���ͻ
                Conflict_Update=1;
                %                 IntentionTable_new=AdjustIntenTablesBaseConditions(IntentionTable,UnableLink)
            else
                Conflict_Update=0;
            end
            LinkSelected=ClusterMat(fthRB,s);
        end
        
        %%  ����ѡ����û��������ʶԱ�
        % ԭ������
        kthCluUserVec2=zeros(1,kthClusterNum_Fin(1,fthRB));
        if kthClusterNum_Fin(1,fthRB)==0 %�������û�
            kthCluUserVec2=0;
        else  %�����û���������û�
            for k=1:kthClusterNum_Fin(1,fthRB)
                kthCluUserVec2(1,k)=ClusterMat_Fin(fthRB,k);
            end
        end
        
        %����������
        VLCrate_old=RateofSingleCluster(SystemCoefficient,kthCluUserVec2,V2Ista,fthRB);
        
        % ��ѡ�е���·�Ž��������������������
        if kthClusterNum_Fin(1,fthRB)==0
            kthCluUserVec2=LinkSelected;
        else
            kthCluUserVec2=[kthCluUserVec2 LinkSelected];
        end
        
        %�µ�����
        VLCrate_new=RateofSingleCluster(SystemCoefficient,kthCluUserVec2,V2Ista,fthRB);
        
        if VLCrate_new>VLCrate_old && Conflict_Update==0 % ����������,�Ҳ��ǳ�ͻ��V2I
            
            for i=1:Usernum
                if UserVec(1,i)==LinkSelected
                    DeletLink=i;
                    break;
                end
                
            end
            % ���û��Ž�����
            ClusterMat_Fin(fthRB,kthClusterNum_Fin(1,fthRB)+1)=LinkSelected;
            kthClusterNum_Fin(1,fthRB)=kthClusterNum_Fin(1,fthRB)+1;
            
            
            % ɾ�� LinkSelected,���������
            UserVec(:,DeletLink)=[];
            IntentionTable(DeletLink,:)=[];
            [ClusterMat, kthClusterNum]=EstablishingClustersBasedonIntentionTables(UserVec,IntentionTable);
            
        else %��������������ɾ�����Ӧ��Դ
            
            %����ϲ���б�
            for i=1:Usernum  %��������û����е�λ��
                if UserVec(1,i)==LinkSelected
                    UnableLink=i;
                    break;
                end
            end
            %����ֻʣ�����һ����Դ���ʱ�򣬾�ֱ�Ӹ�����
            
            EmptyRB=IntentionTable(UnableLink,2:RBnum);
            
            if any(EmptyRB)==0  || size(IntentionTable,1)==1 %�Ѿ��޿��õ���Դ�飬���������Դ����û�
                % ���û��Ž�����
                ClusterMat_Fin(fthRB,kthClusterNum_Fin(1,fthRB)+1)=LinkSelected;
                kthClusterNum_Fin(1,fthRB)=kthClusterNum_Fin(1,fthRB)+1;
                
                % ɾ�� LinkSelected,���������
                UserVec(:,UnableLink)=[];
                IntentionTable(UnableLink,:)=[];
                [ClusterMat, kthClusterNum]=EstablishingClustersBasedonIntentionTables(UserVec,IntentionTable);
            else
                % ���½����б�
                IntentionTable=AdjustIntenTablesBaseConditions(IntentionTable,UnableLink);
                [ClusterMat, kthClusterNum]=EstablishingClustersBasedonIntentionTables(UserVec,IntentionTable);
            end
        end
    end
    
end

%% ���ݷִؼ���������
% % ClusterMat_Fin
%ɾ��V2I��·

% ClusterMat_Fin(:,1)=[];
SumRate=0;
V2Ista1=V2Ista;
for i=1:RBnum
    V2Vcluster=ClusterMat_Fin(i,:);
    %����IntraGRA�㷨������;
    
    SumRate=SumRate+IntraGRAalgoRateCalcul(SystemCoefficient,V2Vcluster,V2Ista1,i);
    
end
ClusterMat_Fin(:,1)=[];
kthClusterNum_Fin=kthClusterNum_Fin-1;


t=toc;


