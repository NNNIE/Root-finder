function [result] = getfxVals(equation, x)

equation = inline(equation);
len=length(x);
result= zeros(1,len);
for i=1:len

%   equation = str2func(equation);
result(i) = equation(x(i));
end

end