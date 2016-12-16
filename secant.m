function [result] = secant(X0, X1, Es, max_iter, equation, handles)
    
column = {'Xi-1' 'Xi' 'f(Xi-1)' 'f(Xi)' 'Xi+1' 'Es' 'Er'};
set(handles.table,'ColumnName' , column);

Xnew = 0;
Xprev = X0;
Xnow = X1;
iterations = max_iter;
relerror=0;

tic;
for i = 1:max_iter
    fx = double(getfx(equation, Xnow));
    fxp = double(getfx(equation, Xprev));
    
    if fxp - fx == 0 % division by zero
        iterations = i;
        break
    end
    
    Xnew = double(Xnow - ((fx * (Xprev - Xnow)) / (fxp - fx)));
    
    error = double(abs(Xnew - Xnow));
    relerror = (error/Xnew )*100 ; 
    if error < Es
        iterations = i;
        break
    end
    
    table(i,:) = [Xprev Xnow fxp fx Xnew error relerror];
    Xprev = Xnow;
    Xnow = Xnew;
end

exec_time = toc;
set(handles.extime, 'String', exec_time);
set(handles.table, 'Data', table);
set(handles.itrtaken, 'String', iterations);
result = Xnew;

hold off;
end