function [c,ceq] = nonlinearconstraint(x)
%NONLINEARCONSTRAINT 优化问题的非线性约束
%   优化多目标位置估计精度的非线性约束
global Ptotal
c = [];
ceq = sum(x) -Ptotal;
end

