%% Copyright 2016 MERCIER David
function handles = ScratchPlot_setGUI
%% Definition of the GUI and buttons
g = guidata(gcf);
handles = g.handles;

%% Title of the GUI
handles.title_GUI_1 = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.31 0.96 0.6 0.04],...
    'String', 'Plot of scratch from (nano)scratch experiments.',...
    'FontWeight', 'bold',...
    'FontSize', 12,...
    'HorizontalAlignment', 'center',...
    'ForegroundColor', 'red');

handles.title_GUI_2 = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.31 0.93 0.6 0.03],...
    'String', strcat('Version_', ...
    g.config.version_toolbox, ' - Copyright 2016 MERCIER David'),...
    'FontSize', 10);

set([handles.title_GUI_1, handles.title_GUI_2], ...
    'FontWeight', 'bold',...
    'HorizontalAlignment', 'center',...
    'ForegroundColor', 'red')

%% Date / Time
handles.date_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'String', datestr(datenum(clock),'mmm.dd,yyyy HH:MM'),...
    'Position', [0.92 0.975 0.075 0.02]);

%% Buttons to set type of files
handles.pm_set_file = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'popupmenu',...
    'Position', [0.02 0.95 0.08 0.04],...
    'String', {'Agilent MTS';'Hysitron';'ASMEC'},...
    'Value', 1,...
    'Callback', '');

%% Units
% Unit definition for the X and Y size
handles.title_unitLength_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.11 0.97 0.04 0.02],...
    'String', 'Length:',...
    'HorizontalAlignment', 'left');

handles.unitLength_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'popupmenu',...
    'Position', [0.15 0.97 0.05 0.02],...
    'String', listUnitLength,...
    'Value', 2, ...
    'Callback', 'ScratchPlot_runPlot');

% Unit definition for the property
handles.title_unitLoad_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.21 0.97 0.04 0.02],...
    'String', 'Load:',...
    'HorizontalAlignment', 'left');

handles.unitLoad_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'popupmenu',...
    'Position', [0.25 0.97 0.05 0.02],...
    'String', listUnitLoad,...
    'Value', 2, ...
    'Callback', 'ScratchPlot_runPlot');

%% Number of Excel files
handles.title_numExcelFile_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.02 0.92 0.10 0.02],...
    'String', 'Number of Excel files:',...
    'HorizontalAlignment', 'left');

handles.value_numExcelFile_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'edit',...
    'Position', [0.12 0.92 0.02 0.02],...
    'String', '1', ...
    'Callback', '');

%% Buttons to browse file
handles.opendata_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'pushbutton',...
    'Position', [0.02 0.84 0.05 0.06],...
    'String', 'Select file',...
    'FontSize', 10,...
    'FontWeight','bold',...
    'BackgroundColor', [0.745 0.745 0.745],...
    'Callback', 'ScratchPlot_LoadingData');

handles.opendata_str_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'edit',...
    'Position', [0.075 0.84 0.122 0.06],...
    'String', g.config.data.data_path,...
    'FontSize', 8,...
    'BackgroundColor', [0.9 0.9 0.9],...
    'HorizontalAlignment', 'left');

%% Type of plot
handles.title_plotType = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.02 0.81 0.08 0.02],...
    'String', 'Type of plot',...
    'HorizontalAlignment', 'left');

handles.pm_set_plot = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'popupmenu',...
    'Position', [0.02 0.765 0.08 0.04],...
    'String', {'Depth profile';'Depth vs Load';'Load vs Depth';...
    'Cross profile'; '3D plot'},...
    'Value', 1,...
    'Callback', 'ScratchPlot_runPlot');

handles.cb_plot_preScratch = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'checkbox',...
    'Position', [0.02 0.74 0.08 0.03],...
    'String', 'Pre-profile',...
    'Value', 0,...
    'Callback', 'ScratchPlot_runPlot');

handles.cb_plot_scratch = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'checkbox',...
    'Position', [0.02 0.71 0.08 0.03],...
    'String', 'Scratch',...
    'Value', 1,...
    'Callback', 'ScratchPlot_runPlot');

handles.cb_plot_postScratch = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'checkbox',...
    'Position', [0.02 0.68 0.08 0.03],...
    'String', 'Post-profile',...
    'Value', 0,...
    'Callback', 'ScratchPlot_runPlot');

%% Plot number
handles.title_plotNumb = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.14 0.81 0.08 0.02],...
    'String', 'Plot number',...
    'HorizontalAlignment', 'left');

handles.pm_set_plotNumb = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'popupmenu',...
    'Position', [0.14 0.765 0.08 0.04],...
    'String', {'Mean values';'1'},...
    'Value', 1,...
    'Callback', 'ScratchPlot_runPlot');

%% Smooth of data
handles.cb_averageSmooth = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'checkbox',...
    'Position', [0.02 0.62 0.10 0.03],...
    'String', 'Moving-average filter',...
    'Value', 0,...
    'Callback', 'ScratchPlot_runPlot');

handles.slide_averageSmooth = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'slider',...
    'Position', [0.02 0.59 0.10 0.03],...
    'Value', 5,...
    'min',2, 'max',100, ...
    'Callback', 'ScratchPlot_runPlot',...
    'Visible', 'off');

handles.cb_splineSmooth = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'checkbox',...
    'Position', [0.02 0.56 0.10 0.03],...
    'String', 'Spline smoothing',...
    'Value', 0,...
    'Callback', 'ScratchPlot_runPlot');

handles.slide_splineSmooth = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'slider',...
    'Position', [0.02 0.53 0.10 0.03],...
    'Value', 5,...
    'min',1, 'max',100, ...
    'Callback', 'ScratchPlot_runPlot',...
    'Visible', 'off');

%% Offset correction
handles.cb_offsetCorr = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'checkbox',...
    'Position', [0.02 0.50 0.10 0.03],...
    'String', 'Offset correction',...
    'Value', 0,...
    'Callback', 'ScratchPlot_runPlot');

%% Plot options
handles.cb_plot_errorbar = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'checkbox',...
    'Position', [0.02 0.45 0.08 0.03],...
    'String', 'Error bar',...
    'Value', 0,...
    'Callback', 'ScratchPlot_runPlot');

handles.cb_plot_xLim_auto = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'checkbox',...
    'Position', [0.02 0.41 0.08 0.03],...
    'String', 'xlim auto',...
    'Value', 1,...
    'Callback', 'ScratchPlot_runPlot');

handles.title_Min_xLim_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.02 0.38 0.05 0.02],...
    'String', 'Min x value:',...
    'Visible', 'off', ...
    'HorizontalAlignment', 'left');

handles.value_Min_xLim_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'edit',...
    'Position', [0.07 0.38 0.02 0.02],...
    'String', '0', ...
    'Visible', 'off', ...
    'Callback', 'ScratchPlot_runPlot');

handles.unit_Min_xLim_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.09 0.38 0.02 0.02],...
    'String', '�m',...    
    'Visible', 'off', ...
    'HorizontalAlignment', 'center');

handles.title_Max_xLim_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.02 0.35 0.05 0.02],...
    'String', 'Max x value:',...
    'Visible', 'off', ...
    'HorizontalAlignment', 'left');

handles.value_Max_xLim_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'edit',...
    'Position', [0.07 0.35 0.02 0.02],...
    'String', '500', ...
    'Visible', 'off', ...
    'Callback', 'ScratchPlot_runPlot');

handles.unit_Max_xLim_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.09 0.35 0.02 0.02],...
    'String', '�m',...
    'Visible', 'off', ...
    'HorizontalAlignment', 'center');

handles.cb_plot_yLim_auto = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'checkbox',...
    'Position', [0.02 0.30 0.08 0.03],...
    'String', 'ylim auto',...
    'Value', 1,...
    'Callback', 'ScratchPlot_runPlot');

handles.title_Min_yLim_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.02 0.27 0.05 0.02],...
    'String', 'Min y value:',...
    'Visible', 'off', ...
    'HorizontalAlignment', 'left');

handles.value_Min_yLim_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'edit',...
    'Position', [0.07 0.27 0.02 0.02],...
    'String', '-10', ...
    'Visible', 'off', ...
    'Callback', 'ScratchPlot_runPlot');

handles.unit_Min_yLim_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.09 0.27 0.02 0.02],...
    'String', '�m',...
    'Visible', 'off', ...
    'HorizontalAlignment', 'center');

handles.title_Max_yLim_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.02 0.24 0.05 0.02],...
    'String', 'Max y value:',...
    'Visible', 'off', ...
    'HorizontalAlignment', 'left');

handles.value_Max_yLim_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'edit',...
    'Position', [0.07 0.24 0.02 0.02],...
    'String', '10', ...
    'Visible', 'off', ...
    'Callback', 'ScratchPlot_runPlot');

handles.unit_Max_yLim_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.09 0.24 0.02 0.02],...
    'String', '�m',...
    'Visible', 'off', ...
    'HorizontalAlignment', 'center');

%% Get values from plot
handles.save_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'pushbutton',...
    'Position', [0.02 0.18 0.10 0.05],...
    'String', 'Get x/y values',...
    'Callback', 'plot_get_values', ...
    'FontSize', 12,...
    'BackgroundColor', [0.745 0.745 0.745]);

handles.title_xVal_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.02 0.15 0.05 0.02],...
    'String', 'X value:',...
    'HorizontalAlignment', 'left');

handles.value_xVal_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'edit',...
    'Position', [0.06 0.15 0.03 0.02],...
    'String', '100', ...
    'Callback', 'ScratchPlot_runPlot');

handles.unit_xVal_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.09 0.15 0.02 0.02],...
    'String', '�m',...
    'HorizontalAlignment', 'center');

handles.title_yVal_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.02 0.12 0.05 0.02],...
    'String', 'Y value:',...
    'HorizontalAlignment', 'left');

handles.value_yVal_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'edit',...
    'Position', [0.06 0.12 0.03 0.02],...
    'String', '100');

handles.unit_yVal_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.09 0.12 0.02 0.02],...
    'String', '�m', ...
    'HorizontalAlignment', 'center');

handles.title_zVal_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.02 0.09 0.05 0.02],...
    'String', 'Z value:',...
    'HorizontalAlignment', 'left');

handles.value_zVal_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'edit',...
    'Position', [0.06 0.09 0.03 0.02],...
    'String', '100');

handles.unit_zVal_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'text',...
    'Position', [0.09 0.09 0.02 0.02],...
    'String', '�m', ...
    'HorizontalAlignment', 'center');

%% Plot configuration
handles.AxisPlot_GUI = axes('Parent', gcf,...
    'Position', [0.33 0.10 0.60 0.75]);

set(gcf,'CurrentAxes', handles.AxisPlot_GUI);

%% Others buttons
% Save
handles.save_GUI = uicontrol('Parent', gcf,...
    'Units', 'normalized',...
    'Style', 'pushbutton',...
    'Position', [0.02 0.02 0.05 0.05],...
    'String', 'SAVE',...
    'Callback', 'save_figure', ...
    'FontSize', 12,...
    'BackgroundColor', [0.745 0.745 0.745]);

%% Guidata
g.handles = handles;
guidata(gcf, g);

%% Update units
%TriDiMap_updateUnit_and_GUI;

end