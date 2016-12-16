function [result] = getfx(equation, x)

equation = inline(equation);
%   equation = str2func(equation);
result = equation(x);

end