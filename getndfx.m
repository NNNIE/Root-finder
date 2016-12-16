function [result] = getndfx(equation, n, x)

derivative = diff(sym(equation), n);

derivative = strcat('@(x)', char(derivative));
derivative = str2func(derivative);
result = derivative(x);

end