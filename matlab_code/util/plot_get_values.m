%% Copyright 2016 MERCIER David
function plot_get_values
%% Function used to get values
gui = guidata(gcf);

if gui.config.flag.flag_data == 0
    helpdlg('Import data first !', '!!!');
    
else
    [x_value, y_value] = ginput(1);
    
    set(gui.handles.value_xVal_GUI, 'String', ...
        num2str((x_value)));
    
    set(gui.handles.value_yVal_GUI, 'String', ...
        num2str((y_value)));
    
end

end