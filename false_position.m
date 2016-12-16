function [result] = false_position(Xl, Xu, Es, max_iter, equation, handles)

column = {'Xl' 'Xu' 'f(Xl)' 'f(Xu)' 'Xr' 'f(Xr)' 'Es' 'Er'};
set(handles.table,'ColumnName' , column);

oldVal = 0;
relerror=0;
xAxis=Xl:0.1:Xu;
error =0.0;
iterations = max_iter;
% cla;
tic;
fXa = double(getfx(equation, Xl));
 fXb = double(getfx(equation, Xu));
if  ( fXa*fXb ) >0
     errordlg('f(a) and f(b) do not have opposite signs','Error');
 end

for i = 1:max_iter
    fxu = double(getfx(equation, Xu));
    fxl = double(getfx(equation, Xl));
    
    Xr = double(((Xl * fxu - Xu * fxl) / (fxu - fxl)));
    fxr = double(getfx(equation, Xr));

    error = double(abs(Xr - oldVal));
    relerror = (error/Xr )*100 ;
    table(i,:) = [Xl Xu fxl fxu Xr fxr error relerror];
%     plot(Xl, x, 'r'); hold on;
%     plot(Xu, x, 'g'); hold on;
    
    if error <= Es
        iterations = i;
        break
    end

    if fxr == 0
        iterations = i;
        break
    elseif fxl * fxr < 0
        Xu = Xr;
    else
        Xl = Xr;
    end
    
    oldVal = Xr;
end
table(iterations,:) = [Xl Xu fxl fxu Xr fxr error relerror];
exec_time = toc;
y=getfxVals(equation,xAxis);
plot(xAxis,y);
grid on ;

set(handles.extime, 'String', exec_time);
set(handles.table, 'Data', table);
set(handles.itrtaken, 'String', iterations);
result = Xr;

hold off;

end