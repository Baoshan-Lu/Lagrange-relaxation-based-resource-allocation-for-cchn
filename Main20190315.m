
clc
clear


MaxIter=50
V2Inum=5,V2Vnum=5

[SumRateMat]=CalculateSumRate(V2Inum,V2Vnum);
maxV = max(max(max(SumRateMat)));%ת��Ϊ��С�Ż�
RateOverNetSizeMat=maxV-SumRateMat;

%ʹ��Lagrangrian relaxation
[H_fina,L_fina,LRrate,iter,PariSolu,TIME2]=ThreeD_LagrangianRelaxation(RateOverNetSizeMat,MaxIter);
%     [OptSolu,TIME2]=IterHungarinAlgo(RateOverNetSizeMat,MaxIter);
LRrate=V2Inum*maxV-LRrate;

%������
[MATCHING1,ESrate,TIME1]=ThreeD_NumericalSearch(RateOverNetSizeMat);
ESrate=V2Inum*maxV-ESrate;

%%IntraGRA�㷨
[InGRASumRate,t]=IntraGraAlgoAvaible(V2Inum,V2Vnum);

%%CG
MaxFailNum=30
[LRrate_old,t]=CoorperativeGameforV2V(V2Inum,V2Vnum,MaxFailNum)

str=['LR������Ϊ: ' num2str(LRrate),', InGRA������Ϊ: ',num2str(InGRASumRate),', ES������Ϊ: ',num2str(ESrate)...
    ,', CG������Ϊ: ',num2str(LRrate_old)]
