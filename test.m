%%tempֵ�Ǳ��������С�ͣ�ans���������㷨�������С��
clear;clc;
% M=4;
N=5;
A=1+round(10*rand(4,N));
%%�������M*Nά�����д���D2D���д�������û�
[z,ans]=Hungarian(A);
%%����
temp = Inf;
l=1;
for i1=1:1:N
    sum=0;
    sum=sum+A(1,i1);
    for i2=1:1:N
        if i2 ~= i1
            sum=sum+A(2,i2);
            for i3=1:1:N
                    if i3 ~= i1 && i3 ~=i2
                         sum=sum+A(3,i3);
                         for i4=1:1:N
                                  if i4 ~= i1 && i4 ~=i2 &&i4~=i3
                                          sum=sum+A(4,i4);
                                          if temp>sum
                                                 temp = sum;
                                          end
                                           sum=sum-A(4,i4);
                                  end         
                         end    
                          sum=sum-A(3,i3);
                  end
            end
               sum=sum-A(2,i2);
        end         
    end
end