function [result] = fixed_point(X0, Es, max_iter, equation, handles)

column = {'Xi' 'Xi+1' 'Es' 'Er'};
set(handles.table,'ColumnName' , column);

% g = strcat(equation, ' + x');
g = equation;
iterations = max_iter;
Xnow = X0;
relerror=0;

tic;
for i = 1:max_iter
    Xnew = double(getfx(g, Xnow));
    if isnan(Xnew)
        break;
    end
    error = double(abs(Xnew - Xnow));
    relerror = (error/Xnew )*100 ;
    table(i,:) = [Xnow Xnew error relerror];
    
    if error <= Es
        iterations = i;
        break
    end
    
    Xnow = Xnew;
end

exec_time = toc;
set(handles.extime, 'String', exec_time);
set(handles.table, 'Data', table);
set(handles.itrtaken, 'String', iterations);
result = Xnew;

hold off;

end
