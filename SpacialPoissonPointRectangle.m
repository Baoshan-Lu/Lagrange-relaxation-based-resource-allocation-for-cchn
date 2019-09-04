function [A,B,N]=SpacialPoissonPointRectangle(x1,x2,y1,y2,Lambda)
%��������������������ڷ�Χ�ڷ��Ӿ��ȷֲ���������֮��ľ������ָ���ֲ�
%%% Part1 %%
% Lambda-������һ����Χ�ڵĳ����ܶȣ�
%�ο����ף�Pasupathy R . Generating Homogeneous Poisson Processes[M]// Wiley 
%Encyclopedia of Operations Research and Management Science. John Wiley & Sons, Inc. 2014.
u = unifrnd(0,1);
M = 0;
while u >= exp(-Lambda)%�ж�����
    u = u*unifrnd(0,1);
    M=M+1;
end
N=M;
%ȡ�����
% R = poissrnd(Lambda,1,M)

%%% Part2 %%%
% x1 = 0; c = 0;
% b = 100; d =100;
% e = 0; f = 100;     %ȡ[0,100]*[0,100]�Ĳ�������
Nall = M;
A = [];
B = [];
while M > 0         %scatter in the [0,100]*[0,100]
    M = M-1;
    u1 = unifrnd(0,1);
    A(Nall-M) = (x2-x1)*u1+x1;
    u2 = unifrnd(0,1);
    B(Nall-M) = (y2-y1)*u2+y1;
    %     u3 = unifrnd(0,1);
    %     C(Nall-M) = (f-e)*u3;
    %     figure(2)    %base stations �ֲ�ͼ
    % plot3(A(Nall-M),B(Nall-M),C(Nall-M),'r^');
    %     hold on;
    %     plot(A(Nall-M),B(Nall-M),'b.')
    %     hold on
end
% grid on