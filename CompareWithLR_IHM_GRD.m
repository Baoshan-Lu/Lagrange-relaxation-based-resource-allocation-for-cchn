function [LRrate,IHMrate,GRDrate]=CompareWithLR_IHM_GRD(SystemCoefficient,V2Inum,V2Vnum)
SumRateMat=CalculateSumRate(SystemCoefficient,V2Inum,V2Vnum);
%LRM�㷨
[~,LRrate,LRTIME]=ThreeD_LagrangianRelaxation(SumRateMat);
%IHM�㷨
[IHMrate,TIME1]=IterHungarinAlgo(SumRateMat);
%GRD�㷨
GRDrate=GreedyResourceAllocation(SumRateMat);