function IntraGraAlgo()

clc
clear

V2Vnum=10;V2Inum=5;V2Ista=V2Vnum+1;

RBnum=V2Inum;Usernum=V2Inum+V2Vnum;

UserVec=1:Usernum;

%����SNRѡ����ѵ�RB����������Link���б�
[IntentionTable]=CreatBestList(UserVec,RBnum,V2Ista)
[ClusterMat, kthClusterNum]=EstablishingClustersBasedonIntentionTables(UserVec,IntentionTable)

ClusterMat_Fin=zeros(RBnum,Usernum);
kthClusterNum_Fin=zeros(1,RBnum);

Nonempty=sum(kthClusterNum);
%
% fthRB=1;
Finish=0;

while Nonempty>0  && Finish==0 %�Ӽ��ǿ�
    %% �������1��ʼ������û���û�
    for i=1:RBnum
        if  kthClusterNum(1,i)~=0
            fthRB=i
            Finish=0;
            break;
        else
            Finish=1;
        end
    end
    Finish
    
    
    %     if kthClusterNum(1,fthRB)==0 %�������������û�
    %         fthRB=fthRB+1
    % else
    
    if  Finish==0
        %% ��ʼ�����㷨
        Conflict_Update=0;
        
        Rifk=zeros(1,kthClusterNum(1,fthRB));
        %% ѡ��k������õ���·
        if kthClusterNum_Fin(1,fthRB)==0 %���л�û�û�ռ��
            for i=1:kthClusterNum(1,fthRB)
                Rifk(1,i)=RateofSingleCluster(ClusterMat(fthRB,:),V2Ista,fthRB);
            end
            [~,s]=max(Rifk);%ѡ�����������û�����
            LinkSelected=ClusterMat(fthRB,s)
            
        else
            %% �����Ѿ����û�,ѡ��ʹ������С��
            InterferList=zeros(1,kthClusterNum(1,fthRB));
            for i=1:kthClusterNum(1,fthRB)
                
                fthRB
                kthClusterNum_Fin
                kthCluUserVec=zeros(1,kthClusterNum_Fin(1,fthRB))
                
                for k=1:kthClusterNum_Fin(1,fthRB)
                    kthCluUserVec(1,k)=ClusterMat_Fin(fthRB,k) %Ҫ��ԭ����λ��
                end
                
                %���Ž� �����ClusterMat(fthRB,i)���û�i�Ž�ȥ
                SelectedVirLink=ClusterMat(fthRB,i)
                kthCluUserVec=[kthCluUserVec SelectedVirLink]
                
                %����������
                InterferNew=LinkInterCluster(kthCluUserVec,V2Ista,fthRB);
                InterferList(1,i)=InterferNew
            end
            %% ѡ�����������û�����
            [MinInterfer,s]=min(InterferList);
            if MinInterfer==inf %�����С�Ķ���inf����V2I��·
                %����V2I��·��ͬһ���أ���ͻ
                Conflict_Update=1
                %                 IntentionTable_new=AdjustIntenTablesBaseConditions(IntentionTable,UnableLink)
            else
                Conflict_Update=0
            end
            LinkSelected=ClusterMat(fthRB,s)
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
        VLCrate_old=RateofSingleCluster(kthCluUserVec2,V2Ista,fthRB)
        
        % ��ѡ�е���·�Ž��������������������
        if kthClusterNum_Fin(1,fthRB)==0
            kthCluUserVec2=LinkSelected
        else
            kthCluUserVec2=[kthCluUserVec2 LinkSelected]
        end
        
        %�µ�����
        VLCrate_new=RateofSingleCluster(kthCluUserVec2,V2Ista,fthRB)
        
        if VLCrate_new>VLCrate_old && Conflict_Update==0 % ����������,�Ҳ��ǳ�ͻ��V2I
            
            for i=1:Usernum
                if UserVec(1,i)==LinkSelected
                    DeletLink=i
                    break;
                end
                
            end
            % ���û��Ž�����
            ClusterMat_Fin(fthRB,kthClusterNum_Fin(1,fthRB)+1)=LinkSelected
            kthClusterNum_Fin(1,fthRB)=kthClusterNum_Fin(1,fthRB)+1
            
            
            % ɾ�� LinkSelected,���������
            UserVec(:,DeletLink)=[]
            IntentionTable(DeletLink,:)=[]
            [ClusterMat, kthClusterNum]=EstablishingClustersBasedonIntentionTables(UserVec,IntentionTable)
            
            
            
        else %��������������ɾ�����Ӧ��Դ
            
            %����ϲ���б�
            for i=1:Usernum  %��������û����е�λ��
                if UserVec(1,i)==LinkSelected
                    UnableLink=i
                    break;
                end
            end
            
            %����ֻʣ�����һ����Դ���ʱ�򣬾�ֱ�Ӹ�����
            
            
            
            EmptyRB=IntentionTable(UnableLink,2:RBnum)
            
            %
            
            
            if (any(EmptyRB)==0  || size(IntentionTable,1)==1)    %�Ѿ��޿��õ���Դ�飬���������Դ����û�
                
                % ���û��Ž�����
                ClusterMat_Fin(fthRB,kthClusterNum_Fin(1,fthRB)+1)=LinkSelected
                kthClusterNum_Fin(1,fthRB)=kthClusterNum_Fin(1,fthRB)+1
                
                % ɾ�� LinkSelected,���������
                UserVec(:,UnableLink)=[]
                IntentionTable(UnableLink,:)=[]
                [ClusterMat, kthClusterNum]=EstablishingClustersBasedonIntentionTables(UserVec,IntentionTable)
            else
                
                % ���½����б�
                IntentionTable=AdjustIntenTablesBaseConditions(IntentionTable,UnableLink)
                [ClusterMat, kthClusterNum]=EstablishingClustersBasedonIntentionTables(UserVec,IntentionTable)
                
            end
            
        end
    end
    
end
ClusterMat_Fin
kthClusterNum_Fin