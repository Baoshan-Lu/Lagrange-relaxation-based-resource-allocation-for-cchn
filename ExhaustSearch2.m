function [Action,num]=ExhaustSearch2(V2Inum,V2Vnum)
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
Action=eval(['[' S1{:} ']']);
num=size(Action,1);

save Action.mat Action