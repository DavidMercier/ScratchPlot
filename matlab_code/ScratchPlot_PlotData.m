%% Copyright 2016 MERCIER David
function ScratchPlot_PlotData(data)
%% Function to plot Excel data from scratch tests

gui = guidata(gcf);
h = gui.handles;

%% Plot options
% symbolPlot = ['o', '+', '-'];
% colorError = ['r', 'b', 'k'];
colorPlot(1,:) = [0,0,0];
colorPlot(2,:) = [0,0,1];
colorPlot(3,:) = [1,0,0];

lineWidthval = 1;
markerSize = 6;

set(gcf,'CurrentAxes', gui.handles.AxisPlot_GUI);
cla;

if get(h.cb_plot_preScratch, 'Value')
    val_1 = 1;
else
    val_1 = 0;
end
if get(h.cb_plot_scratch, 'Value')
    val_2 = 1;
else
    val_2 = 0;
end
if get(h.cb_plot_postScratch, 'Value')
    val_3 = 1;
else
    val_3 = 0;
end

if get(h.pm_set_plot, 'Value') == 1
    xData1 = data.dispHoriMean_1;
    xData2 = data.dispHoriMean_2;
    xData3 = data.dispHoriMean_3;
    xLeg = strcat('Horizontal displacement (', gui.config.lengthUnit, ')');
elseif get(h.pm_set_plot, 'Value') == 2
    xData1 = data.loadMean_1;
    xData2 = data.loadMean_2;
    xData3 = data.loadMean_3;
    xLeg = strcat('Applied normal load (', gui.config.loadUnit, ')');
end

if ~get(h.cb_plot_errorbar, 'Value')
    if val_1
        plot(xData1, ...
            data.dispVertMean_1, ...
            'o', ...
            'Color', colorPlot(1,:),...
            'LineWidth', lineWidthval, ...
            'markers', markerSize);
        hold on;
    end
    
    if val_2
        plot(xData2, ...
            data.dispVertMean_2, ...
            '+', ...
            'Color', colorPlot(2,:),...
            'LineWidth', lineWidthval, ...
            'markers', markerSize);
        hold on;
    end
    
    if val_3
        plot(xData3, ...
            data.dispVertMean_3, ...
            '*', ...
            'Color', colorPlot(3,:),...
            'LineWidth', lineWidthval, ...
            'markers', markerSize);
        hold on;
    end
    
else
    if val_1
        errorbar(xData1, ...
            data.dispVertMean_1, ...
            data.dispVertError_1, ...
            'o', ...
            'Color', colorPlot(1,:),...
            'LineWidth', lineWidthval, ...
            'markers', markerSize);
        hold on;
    end
    
    if val_2
        errorbar(xData2, ...
            data.dispVertMean_2, ...
            data.dispVertError_2, ...
            '+', ...
            'Color', colorPlot(2,:),...
            'LineWidth', lineWidthval, ...
            'markers', markerSize);
        hold on;
    end
    
    if val_3
        errorbar(xData3, ...
            data.dispVertMean_3, ...
            data.dispVertError_3, ...
            '*', ...
            'Color', colorPlot(3,:),...
            'LineWidth', lineWidthval, ...
            'markers', markerSize);
        hold on;
    end
end

if val_1 && ~val_2 && ~val_3
    legendStr = 'Pre-Scratch';
elseif ~val_1 && val_2 && ~val_3
    legendStr = 'Scratch';
elseif ~val_1 && ~val_2 && val_3
    legendStr = 'Post-Scratch';
elseif val_1 && val_2 && ~val_3
    legendStr = {'Pre-Scratch', 'Scratch'};
elseif ~val_1 && val_2 && val_3
    legendStr = {'Scratch', 'Post-Scratch'};
elseif val_1 && ~val_2 && val_3
    legendStr = {'Pre-Scratch', 'Post-Scratch'};
elseif val_1 && val_2 && val_3
    legendStr = {'Pre-Scratch', 'Scratch', 'Post-Scratch'};
end

xlabel(xLeg); %, 'Interpreter', 'Latex'
ylabel(strcat('Scratch depth (', gui.config.lengthUnit, ')')); %, 'Interpreter', 'Latex'
if val_1 || val_2 || val_3
    h_legend1 = legend(legendStr);
    set(h_legend1, 'Interpreter', 'Latex');
end

%% Axis
if get(h.cb_plot_xLim_auto, 'value')
    xlim('auto');
else
    xlim([str2double(get(h.value_Min_xLim_GUI, 'String')), ...
        str2double(get(h.value_Max_xLim_GUI, 'String'))]);
end
if get(h.cb_plot_yLim_auto, 'value')
    ylim('auto');
else
    ylim([str2double(get(h.value_Min_yLim_GUI, 'String')), ...
        str2double(get(h.value_Max_yLim_GUI, 'String'))]);
end
grid on;

end