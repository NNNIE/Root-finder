function [result] = bisection(Xl, Xu, Es, max_iter, equation,handles)


column = {'Xl' 'Xu' 'Xr' 'f(Xl)' 'f(Xu)' 'f(Xr)' 'Es' 'Er'};
error = 0.0;
limit = int32(log2(abs(Xu - Xl) / Es)) + 1;
Xr = ((Xl + Xu) / 2.0);

iterations = max_iter;


tic;
 fXa = double(getfx(equation, Xl));
 fXb = double(getfx(equation, Xu));
 if  ( fXa*fXb ) >0
     errordlg('f(a) and f(b) do not have opposite signs','Error');
 end
 relerror=0;
 xAxis=Xl:0.1:Xu;
 
for i = 1:max_iter 
    fXr = double(getfx(equation, Xr));
    fXl = double(getfx(equation, Xl));
    fXu = double(getfx(equation, Xu));
    oldVal = Xr;

   
    table(i,:) = [Xl Xu Xr fXl fXu fXr error relerror];
%     plot(Xl, x, 'r'); hold on;
%     plot(Xu, x, 'g'); hold on;
    
    if fXr == 0
        iterations = i;
        break
    elseif fXr * fXl > 0
    	Xl = Xr;
    else
        Xu = Xr;  
    end
            
    Xr = double((Xl + Xu) / 2.0);
    error = double(abs(Xr - oldVal));
    relerror = (error/Xr )*100 ;
    if error < Es || i > limit
        iterations = i;
        break
    end
end

table(iterations,:) = [Xl Xu Xr fXl fXu fXr error relerror];
exec_time = toc;

result = Xr;


y=getfxVals(equation,xAxis);
plot(xAxis,y);
grid on ;
% hold on;
% for i=1:iterations
%     plot(iterations(i,1),y)
% end
% hold off;

set(handles.table,'ColumnName' , column);
set(handles.extime, 'String', exec_time);
set(handles.itrtaken, 'String', iterations);
set(handles.table, 'Data', table);

end