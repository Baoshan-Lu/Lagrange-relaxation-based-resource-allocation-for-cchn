function [MaxSumrate,t]=ExhaustSearch(SystemCoefficient,V2Inum,V2Vnum)
% function ExhaustSearch()
% V2Inum=2
% V2Vnum=5


%V2V�ִغ�������V2V�����V2I
tic
%% �������п��ܵĴ�
C=cell(1,V2Vnum);%����V2V����
for i=1:V2Vnum
    C{1,i}=1:V2Inum;%V2I����,ÿ��cell�������V2I������
end


% ��ÿά������д��������Ȼ�����һ��cell������
% ���ﰴ�����������ʾ�����������꣩
% C = { 1:3 1:3 1:3 };
% ʹ��ndgrid����Nά��������

n = length(C);
S=arrayfun(@(i)sprintf('x%i ',i),1:n,'UniformOutput',false);
eval(['[' S{:} ']=ndgrid(C{:});'])
S1=arrayfun(@(i)sprintf('x%i(:) ',i),1:n,'UniformOutput',false);

% ����������ת��Ϊ�������
X=eval(['[' S1{:} ']']);
num=size(X,1);

%% �����������е�RB
V2Ivec=1:V2Inum;
RBvec=1:V2Inum;

MaxSumrate=0;%���������

RBallpossi=perms(RBvec);%Full arrangement
for r1=1:size(RBallpossi,1) %ÿһ��RB����
    for V2V_k=1:size(X,1)%ÿһ��V2V�ִ�
        
        [ClusterMat,kthClusterNum]=EsCluster(V2Inum,V2Vnum,X(V2V_k,:));
        %% ����������
        Sumrate=0;
        for i=1:V2Inum %V2I
            [Rifk]=CalculateWeightofV2I_RB_VLC(SystemCoefficient,V2Ivec(1,i),RBallpossi(r1,i),i,ClusterMat,kthClusterNum);
            Sumrate=Sumrate+Rifk;
        end
        if Sumrate>MaxSumrate
            MaxSumrate=Sumrate;
        end
    end
end
t=toc;
% MaxSumrate
