function Change_V2I_min_Rate(SystemCoefficient,V2Inum,R0,Range)
%�ı�V2I����С����Ҫ��
RBnum=V2Inum;
V2I_min_Rate=zeros(V2Inum,RBnum);
for i=1:V2Inum
    for r=1:RBnum
        V2I_min_Rate(i,r)=R0+rand*Range;
    end
end
save([SystemCoefficient.VariablePath  'V2I_min_Rate'], 'V2I_min_Rate')
