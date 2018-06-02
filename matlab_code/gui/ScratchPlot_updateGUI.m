%% Copyright 2016 MERCIER David
function ScratchPlot_updateGUI
%% Function to update the GUI (units, buttons...)

gui = guidata(gcf);
h = gui.handles;
config = gui.config;

config.numExcelFiles = str2double(get(h.value_numExcelFile_GUI, 'String'));

config.lengthUnit = ...
    get_value_popupmenu(h.unitLength_GUI, listUnitLength);
config.loadUnit = ...
    get_value_popupmenu(h.unitLoad_GUI, listUnitLoad);

set(h.unit_Min_xLim_GUI, 'String', config.lengthUnit);
set(h.unit_Max_xLim_GUI, 'String', config.lengthUnit);
set(h.unit_Min_yLim_GUI, 'String', config.lengthUnit);
set(h.unit_Max_yLim_GUI, 'String', config.lengthUnit);
set(h.unit_xVal_GUI, 'String', config.lengthUnit);
set(h.unit_yVal_GUI, 'String', config.lengthUnit);

if ~get(h.cb_plot_xLim_auto, 'Value')
    set([h.title_Min_xLim_GUI, h.value_Min_xLim_GUI, h.unit_Min_xLim_GUI, ...
        h.title_Max_xLim_GUI, h.value_Max_xLim_GUI, h.unit_Max_xLim_GUI], ...
        'Visible', 'on');
else
    set([h.title_Min_xLim_GUI, h.value_Min_xLim_GUI, h.unit_Min_xLim_GUI, ...
        h.title_Max_xLim_GUI, h.value_Max_xLim_GUI, h.unit_Max_xLim_GUI], ...
        'Visible', 'off');
end

if ~get(h.cb_plot_yLim_auto, 'Value')
    set([h.title_Min_yLim_GUI, h.value_Min_yLim_GUI, h.unit_Min_yLim_GUI, ...
        h.title_Max_yLim_GUI, h.value_Max_yLim_GUI, h.unit_Max_yLim_GUI], ...
        'Visible', 'on');
else
    set([h.title_Min_yLim_GUI, h.value_Min_yLim_GUI, h.unit_Min_yLim_GUI, ...
        h.title_Max_yLim_GUI, h.value_Max_yLim_GUI, h.unit_Max_yLim_GUI], ...
        'Visible', 'off');
end

config.smoothFlag = get(h.cb_averageSmooth, 'value');
if config.smoothFlag 
    config.smoothVal = round(get(h.slide_averageSmooth, 'value'));
    set(h.slide_averageSmooth, 'Visible', 'on');
else
    set(h.slide_averageSmooth, 'Visible', 'off');
end

config.splineFlag = get(h.cb_splineSmooth, 'value');
if config.splineFlag 
    config.splineVal = round(get(h.slide_splineSmooth, 'value'));
    set(h.slide_splineSmooth, 'Visible', 'on');
else
    set(h.slide_splineSmooth, 'Visible', 'off');
end

config.offsetFlag = get(h.cb_offsetCorr, 'value');

gui.config = config;
guidata(gcf, gui);
end