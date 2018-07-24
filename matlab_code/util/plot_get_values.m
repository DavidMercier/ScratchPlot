%% Copyright 2016 MERCIER David
function plot_get_values
%% Function used to get values
gui = guidata(gcf);
h = gui.handles;

if gui.config.flag.flag_data == 0
    helpdlg('Import data first !', '!!!');
else
    if get(h.pm_set_plot, 'Value') <= 4

        [x_value, y_value] = ginput(1);
        
        set(h.value_xVal_GUI, 'String', ...
            num2str((x_value)));
        set(h.value_yVal_GUI, 'String', ...
            num2str((y_value)));
    else
%         pos = get(gca,'Position');
%         output_txt = {['X: ',num2str(pos(1),4)],...
%             ['Y: ',num2str(pos(2),4)],...
%             ['Z: ',num2str(pos(3),4)]};
%         
%         set(h.value_xVal_GUI, 'String', ...
%             output_txt(1));
%         set(h.value_yVal_GUI, 'String', ...
%             output_txt(2));
%         set(h.value_zVal_GUI, 'String', ...
%             output_txt(3));
        datacursormode on;
    end
end

end