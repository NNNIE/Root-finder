function [result] = newton_raphson(X0, Es, max_iter, equation, handles)

column = {'Xi' 'Xi+1' 'f(Xi)' 'f(Xi+1)' 'Es' 'Er'};
set(handles.table,'ColumnName' , column);

Xnow = X0;
Xprev = X0;
iterations = max_iter;
relerror=0;

tic;
for i = 1:max_iter
    fx_1 = double(getfx(equation, Xprev));
    dfx = double(getndfx(equation, 1, Xprev));
    
    if dfx == 0  %to avoid division by zero
        iterations = i;
        break
    end
    
    Xnow = double(Xprev - (fx_1 * 1.0 / dfx)); % xi+1
    fx = double(getfx(equation, Xnow));
    
    error = double(abs(Xnow - Xprev));
    relerror = (error/Xnow )*100 ; 
    if error < Es
        iterations = i;
        break
    end
    
    table(i,:) = [Xprev Xnow fx_1 fx error relerror];
    Xprev = Xnow;
end

exec_time = toc;

set(handles.extime, 'String', exec_time);
set(handles.itrtaken, 'String', iterations);
set(handles.table, 'Data', table);

result = Xnow;

hold off;

end