function [FinalSumrate,t]=IterHungarinAlgo(CoeMat1)
%����ʽ�������㷨----��ά��������
%˼�룺����m,r����k��-->����m,k��,r��-->����r,k��,m����ѭ�����ϵ���m,r��
tic
maxV = max(max(max(CoeMat1)));%ת��Ϊ��С�Ż�
RateMat=maxV-CoeMat1;


[M,R,K]=size(RateMat);
MaxFailnum=20;

MaxIter=30;
%��ʼ��
count=0;
BreakCount=0;
converg=0;

mVec=1:min(M,R);
rVec=1:min(M,R);
kVec=1:min(M,R);

% rVec=randperm(numel(1:min(M,R)));
% kVec=randperm(numel(1:min(M,R)));

mVec_new=zeros(1,min(M,R));
rVec_new=zeros(1,min(M,R));
kVec_new=zeros(1,min(M,R));

IniMatxching=[mVec;rVec;kVec];
%�����ʼЧ��
InitSumRate=0;
for i=1:min(M,R)
    InitSumRate=InitSumRate+RateMat(mVec(1,i),rVec(1,i),kVec(1,i));
end
%     InitSumRate
while converg==0 && count<MaxIter
    
    %% ����1 ����m,r��,k��
    T0=zeros(min(M,R),K);
    for d=1:min(M,R) %CU-D2D��
        for n=1:K %���ŵ�
            T0(d,n)=min(RateMat(mVec(1,d),rVec(1,d),kVec(1,n)));
        end
    end
    
    [m_r_Matching,X0]=Hungarian(T0);
    for i=1:min(M,R)
        kVec_new(1,i)=find(m_r_Matching(i,:)==1);%
    end
    %     kVec
    %     X0
    %% ����2 ����r��k����
    T1=zeros(M,min(R,K));
    
    for i=1:min(R,K) %CU-D2D��
        for m=1:K %���ŵ�
            T1(i,m)=min(RateMat(mVec(1,m),rVec(1,i),kVec(1,i)));
        end
    end
    [r_k_Matching,X1]=Hungarian(T1);
    for i=1:min(R,K)
        mVec_new(1,i)=find(r_k_Matching(i,:)==1);%
    end
    %     mVec
    %     X1
    %% ����3 ����m,k����
    T2=zeros(min(M,K),R);
    for q=1:min(M,K) %CU-D2D��
        for r=1:K %���ŵ�
            T2(q,r)=min(RateMat(mVec(1,q),rVec(1,r),kVec(1,q)));
        end
    end
    
    [m_r_Matching,X2]=Hungarian(T2);
    
    for i=1:min(M,K)
        %         mVec(1,i)=i;%m-r
        rVec_new(1,i)=find(m_r_Matching(i,:)==1);%
    end
    %     rVec
    %     X2
    
    %     UpdatedMatxching=[mVec;rVec;kVec]
    %
    %     %���º�����
    %     UpdatedSumRate=0;
    %     for i=1:min(M,R)
    %         UpdatedSumRate=UpdatedSumRate+RateMat(mVec(1,i),rVec(1,i),kVec(1,i));
    %     endmin([X0,X1,X2])
    
    UpdatedSumRate=X2;
    
    %     UpdatedSumRate
    mVec= mVec_new;
    rVec= rVec_new;
    kVec= kVec_new;
    
    count=count+1;
    
    if UpdatedSumRate<InitSumRate
        InitSumRate=UpdatedSumRate;
        BreakCount=0;
    else
        BreakCount=BreakCount+1;
        if BreakCount>MaxFailnum
            converg=1;
        end
        
    end
end
FinalSumrate=InitSumRate;
% FinalSumrate=InitSumRate;
FinalSumrate=maxV*M-FinalSumrate;
t=toc;