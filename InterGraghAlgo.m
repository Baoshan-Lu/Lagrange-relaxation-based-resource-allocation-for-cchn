function InterGraghAlgo()
%�������ʺ͸���

V2Inum=3;V2Vnum=5;V2Ista=5;

RBnum=V2Inum;
Usernum=V2Inum+V2Vnum;

%����SNRѡ����ѵ�RB����������Link���б�

UserVec=1:Usernum;

[IntentionTable]=CreatBestList(UserVec,RBnum,V2Ista)
[ClusterMat, kthClusterNum]=EstablishingClustersBasedonIntentionTables(UserVec,IntentionTable)


ClusterMat_Fin=zeros(RBnum,Usernum);
kthClusterNum_Fin=zeros(1,RBnum);



Nonempty=sum(kthClusterNum)

fthRB=1;

UnableLinkVec=zeros(1,Usernum);

while Nonempty>0  &&  fthRB<RBnum+1 %�Ӽ��ǿգ�������randint(1,1,[1,RBnum])
    
    if kthClusterNum(1,fthRB)==0 %�������������û�
        fthRB=fthRB+1
        
    else
        
        
        Rifk=zeros(1,kthClusterNum(1,fthRB));
        
        %% ѡ��k������õ���·
        if kthClusterNum_Fin(1,fthRB)==0 %���л�û�û�ռ��
            for i=1:kthClusterNum(1,fthRB)
                Rifk(1,i)=RateofSingleCluster(ClusterMat(fthRB,:),V2Ista,fthRB);
            end
            Rifk
            [~,s]=max(Rifk);%ѡ�����������û�����
            LinkSelected=ClusterMat(fthRB,s);
            
            EmptyFlag=1;
            
        else
            EmptyFlag=0;
            
            %% ������ǣ��Ǿ�Ҫѡ����ڸ���С��Link
            InterferList=zeros(1,kthClusterNum(1,fthRB));
            
            %ȡ��ԭ���еĳ�Ա
            
            %��̽����³�Ա
            for i=1:kthClusterNum(1,fthRB)
                
                kthCluUserVec=zeros(1,kthClusterNum_Fin(1,fthRB));
                for k=1:kthClusterNum_Fin(1,fthRB)
                    kthCluUserVec(1,i)=ClusterMat_Fin(fthRB,k);
                end
                kthCluUserVec
                
                %InterferOld=LinkInterCluster(kthCluUserVec,V2Ista,fthRB)
                
                %���Ž� �����ClusterMat(fthRB,i)���û�i�Ž�ȥ
                SelectedVirLink=ClusterMat(fthRB,i)
                kthCluUserVec=[kthCluUserVec SelectedVirLink]
                
                %����������
                InterferNew=LinkInterCluster(kthCluUserVec,V2Ista,fthRB)
                
                %             if InterferNew<InterferOld %�������ű�С
                %                 LinkSelected=SelectedVirLink
                %             end
                InterferList(1,i)=InterferNew
            end
            [MinInterfer,s]=min(InterferList);%ѡ�����������û�����
            
            if MinInterfer==inf %�����С�Ķ���inf
                UnableLink=ClusterMat(fthRB,s)
                %����ϲ���б�
                
                UnableLinkVec(UnableLink)
                
                UnableLink
                fthRB
                [ClusterMat, kthClusterNum]=ChangeBestList(UserVec,RBnum,V2Ista, UnableLink, fthRB)
                
            else %���򣬽���С���ŵ��û�ѡ��
                LinkSelected=ClusterMat(fthRB,s)
            end
        end
        
        
        LinkSelected
        
        ClusterMat_Fin
        
        % ԭ������
        kthCluUserVec2=zeros(1,kthClusterNum_Fin(1,fthRB));
        
        if kthClusterNum_Fin(1,fthRB)==0 %�������û�
            kthCluUserVec2=0;
        else
            for k=1:kthClusterNum_Fin(1,fthRB)
                kthCluUserVec2(1,i)=ClusterMat_Fin(fthRB,k);
            end
        end
        
        
        VLCrate_old=RateofSingleCluster(kthCluUserVec2,V2Ista,fthRB)
        
        % ��ѡ�е���·�Ž��������������������
        if kthClusterNum_Fin(1,fthRB)==0
            kthCluUserVec2=LinkSelected
        else
            kthCluUserVec2=[kthCluUserVec2 LinkSelected]
            
        end
        VLCrate_new=RateofSingleCluster(kthCluUserVec2,V2Ista,fthRB)
        
        if VLCrate_new>VLCrate_old%����������
            
            % ���û��Ž�����
            ClusterMat_Fin(fthRB,kthClusterNum_Fin(1,fthRB)+1)=LinkSelected
            kthClusterNum_Fin(1,fthRB)=kthClusterNum_Fin(1,fthRB)+1
            
            % ɾ�� LinkSelected,
            
            for i=1:Usernum
                if UserVec(1,i)==LinkSelected
                    DeletLink=i
                    break;
                end
                
            end
            
            UserVec(:,DeletLink)=[]
            
            % ���������
            [ClusterMat, kthClusterNum]=CreatBestList(UserVec,RBnum,V2Vnum)
            
        else %�����������������¸���
            UnableLink=LinkSelected
            [ClusterMat, kthClusterNum]=ChangeBestList(UserVec,RBnum,V2Ista, UnableLink, fthRB)
            
        end
        
    end
end

