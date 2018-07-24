%% Copyright 2016 MERCIER David
function ScratchPlot_updateGUI
%% Function to update the GUI (units, buttons...)

gui = guidata(gcf);
h = gui.handles;
config = gui.config;

%% Unit settings
config.numExcelFiles = str2double(get(h.value_numExcelFile_GUI, 'String'));

config.lengthUnit = ...
    get_value_popupmenu(h.unitLength_GUI, listUnitLength);
config.loadUnit = ...
    get_value_popupmenu(h.unitLoad_GUI, listUnitLoad);

set(h.unit_Min_xLim_GUI, 'String', config.lengthUnit);
set(h.unit_Max_xLim_GUI, 'String', config.lengthUnit);
set(h.unit_Min_yLim_GUI, 'String', config.lengthUnit);
set(h.unit_Max_yLim_GUI, 'String', config.lengthUnit);

set(gui.handles.title_zVal_GUI, 'Visible', 'off');
set(gui.handles.value_zVal_GUI, 'Visible', 'off');
set(gui.handles.unit_zVal_GUI, 'Visible', 'off');
if get(h.pm_set_plot, 'Value') <= 4
    % Use of datacursor?
    datacursormode off;
    set(gui.handles.title_xVal_GUI, 'Visible', 'on');
    set(gui.handles.value_xVal_GUI, 'Visible', 'on');
    set(gui.handles.unit_xVal_GUI, 'Visible', 'on');
    set(gui.handles.title_yVal_GUI, 'Visible', 'on');
    set(gui.handles.value_yVal_GUI, 'Visible', 'on');
    set(gui.handles.unit_yVal_GUI, 'Visible', 'on');
else
    set(gui.handles.title_xVal_GUI, 'Visible', 'off');
    set(gui.handles.value_xVal_GUI, 'Visible', 'off');
    set(gui.handles.unit_xVal_GUI, 'Visible', 'off');
    set(gui.handles.title_yVal_GUI, 'Visible', 'off');
    set(gui.handles.value_yVal_GUI, 'Visible', 'off');
    set(gui.handles.unit_yVal_GUI, 'Visible', 'off');
end

if get(h.pm_set_plot, 'Value') == 1 || get(h.pm_set_plot, 'Value') >= 4
    set(h.unit_xVal_GUI, 'String', config.lengthUnit);
    set(h.unit_yVal_GUI, 'String', config.lengthUnit);
    set(h.unit_zVal_GUI, 'String', config.lengthUnit);
elseif get(h.pm_set_plot, 'Value') == 2
    set(h.unit_xVal_GUI, 'String', config.loadUnit);
    set(h.unit_yVal_GUI, 'String', config.lengthUnit);
elseif get(h.pm_set_plot, 'Value') == 3
    set(h.unit_xVal_GUI, 'String', config.lengthUnit);
    set(h.unit_yVal_GUI, 'String', config.loadUnit);
end

%% Plot number
config.plotNumb = get(h.pm_set_plotNumb, 'Value');
if config.plotNumb == 1
    set(gui.handles.cb_plot_errorbar, 'Visible', 'on');
else
    set(gui.handles.cb_plot_errorbar, 'Visible', 'off');
end

%% Cross profile settings
if get(h.pm_set_plot, 'Value') >= 4
    set(h.cb_plot_preScratch, 'Visible', 'off');
    set(h.cb_plot_scratch, 'Visible', 'off');
    set(h.cb_plot_postScratch, 'Visible', 'off');
    set(h.cb_offsetCorr, 'Visible', 'off');
else
    set(h.cb_plot_preScratch, 'Visible', 'on');
    set(h.cb_plot_scratch, 'Visible', 'on');
    set(h.cb_plot_postScratch, 'Visible', 'on');
    set(h.cb_offsetCorr, 'Visible', 'on');
end

%% Smooth settings
config.smoothFlag = get(h.cb_averageSmooth, 'value');
if config.smoothFlag
    config.smoothVal = round(get(h.slide_averageSmooth, 'value'));
    set(h.slide_averageSmooth, 'Visible', 'on');
else
    set(h.slide_averageSmooth, 'Visible', 'off');
end

if exist('bwdist')
    set(h.cb_splineSmooth, 'Visible', 'on');
    config.splineFlag = get(h.cb_splineSmooth, 'value');
    if config.splineFlag
        config.splineVal = round(get(h.slide_splineSmooth, 'value'));
        set(h.slide_splineSmooth, 'Visible', 'on');
    else
        set(h.slide_splineSmooth, 'Visible', 'off');
    end
else
    set(h.cb_splineSmooth, 'Visible', 'off');
    set(h.slide_splineSmooth, 'Visible', 'off');
end

config.offsetFlag = get(h.cb_offsetCorr, 'value');

%% Axis ettings
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

gui.config = config;
guidata(gcf, gui);
end