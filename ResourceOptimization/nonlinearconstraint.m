function [c,ceq] = nonlinearconstraint(x)
%NONLINEARCONSTRAINT �Ż�����ķ�����Լ��
%   �Ż���Ŀ��λ�ù��ƾ��ȵķ�����Լ��
global Ptotal
c = [];
ceq = sum(x) -Ptotal;
end

