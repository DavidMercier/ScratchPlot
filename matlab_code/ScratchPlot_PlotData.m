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
    if ~gui.config.offsetFlag
        yData1 = data.dispVertMean_1;
        yData2 = data.dispVertMean_2;
        yData3 = data.dispVertMean_3;
        yDataError1 = data.dispVertError_1;
        yDataError2 = data.dispVertError_2;
        yDataError3 = data.dispVertError_3;
    else
        yData1 = data.dispVertCorrMean_1;
        yData2 = data.dispVertCorrMean_2;
        yData3 = data.dispVertCorrMean_3;
        yDataError1 = data.dispVertCorrError_1;
        yDataError2 = data.dispVertCorrError_2;
        yDataError3 = data.dispVertCorrError_3;
    end
    xLeg = strcat('Horizontal displacement (', gui.config.lengthUnit, ')');
    yLeg = strcat('Scratch depth (', gui.config.lengthUnit, ')');
elseif get(h.pm_set_plot, 'Value') == 2
    xData1 = data.loadMean_1;
    xData2 = data.loadMean_2;
    xData3 = data.loadMean_3;
    if ~gui.config.offsetFlag
        yData1 = data.dispVertMean_1;
        yData2 = data.dispVertMean_2;
        yData3 = data.dispVertMean_3;
        yDataError1 = data.dispVertError_1;
        yDataError2 = data.dispVertError_2;
        yDataError3 = data.dispVertError_3;
    else
        yData1 = data.dispVertCorrMean_1;
        yData2 = data.dispVertCorrMean_2;
        yData3 = data.dispVertCorrMean_3;
        yDataError1 = data.dispVertCorrError_1;
        yDataError2 = data.dispVertCorrError_2;
        yDataError3 = data.dispVertCorrError_3;
    end
    xLeg = strcat('Applied normal load (', gui.config.loadUnit, ')');
    yLeg = strcat('Scratch depth (', gui.config.lengthUnit, ')');
elseif get(h.pm_set_plot, 'Value') == 3
    if ~gui.config.offsetFlag
        xData1 = -1*data.dispVertMean_1;
        xData2 = -1*data.dispVertMean_2;
        xData3 = -1*data.dispVertMean_3;
    else
        xData1 = -1*data.dispVertCorrMean_1;
        xData2 = -1*data.dispVertCorrMean_2;
        xData3 = -1*data.dispVertCorrMean_3;
    end
    yData1 = data.loadMean_1;
    yData2 = data.loadMean_2;
    yData3 = data.loadMean_3;
    yDataError1 = data.loadError_1;
    yDataError2 = data.loadError_2;
    yDataError3 = data.loadError_3;
    xLeg = strcat('Scratch depth (', gui.config.lengthUnit, ')');
    yLeg = strcat('Applied normal load (', gui.config.loadUnit, ')');
elseif get(h.pm_set_plot, 'Value') == 4
    xDataCross = data.dispHoriCrossMean;
    yDataCross = data.dispVertCrossMean;
    yDataErrorCross = data.dispVertCrossError;
    xLeg = strcat('Residual cross profile (', gui.config.lengthUnit, ')');
    yLeg = strcat('Residual cross profile depth (', gui.config.lengthUnit, ')');
elseif get(h.pm_set_plot, 'Value') == 5
    xDataCross = data.dispHoriCrossMean;
    yDataCross = data.dispVertCrossMean;
    xLeg = strcat('Residual scratch profile (', gui.config.lengthUnit, ')');
    yLeg = strcat('Residual cross profile (', gui.config.lengthUnit, ')');
    zLeg = strcat('Profile depth (', gui.config.lengthUnit, ')');
end

if ~get(h.cb_plot_errorbar, 'Value')
    if (get(h.pm_set_plot, 'Value') < 4)
        if val_1
            plot(xData1, yData1, ...
                'o', ...
                'Color', colorPlot(1,:),...
                'LineWidth', lineWidthval, ...
                'markers', markerSize);
            hold on; view(0,90);
        end
        
        if val_2
            plot(xData2, yData2, ...
                '+', ...
                'Color', colorPlot(2,:),...
                'LineWidth', lineWidthval, ...
                'markers', markerSize);
            hold on; view(0,90);
        end
        
        if val_3
            plot(xData3, yData3, ...
                '*', ...
                'Color', colorPlot(3,:),...
                'LineWidth', lineWidthval, ...
                'markers', markerSize);
            hold on; view(0,90);
        end
    elseif (get(h.pm_set_plot, 'Value') == 4)
        plot(xDataCross, yDataCross, ...
            '*', ...
            'Color', colorPlot(3,:),...
            'LineWidth', lineWidthval, ...
            'markers', markerSize);
        hold on; view(0,90);
    else
        datax_cross = data.CP_loc*ones(1,length(yDataCross));
        plot3(datax_cross, xDataCross, yDataCross, ...
            '*', ...
            'Color', colorPlot(3,:),...
            'LineWidth', lineWidthval, ...
            'markers', markerSize);
        hold on;
        datay_2 = zeros(1, length(data.dispHoriMean_3));
        plot3(data.dispHoriMean_3, datay_2,data.dispVertMean_3, ...
            '+', ...
            'Color', colorPlot(2,:),...
            'LineWidth', lineWidthval, ...
            'markers', markerSize);
        hold on; view(-20,30);
    end
else
    if get(h.pm_set_plot, 'Value') < 4
        if val_1
            errorbar(xData1, yData1, yDataError1, ...
                'o', ...
                'Color', colorPlot(1,:),...
                'LineWidth', lineWidthval, ...
                'markers', markerSize);
            hold on; view(0,90);
        end
        
        if val_2
            errorbar(xData2, yData2, yDataError2, ...
                '+', ...
                'Color', colorPlot(2,:),...
                'LineWidth', lineWidthval, ...
                'markers', markerSize);
            hold on; view(0,90);
        end
        
        if val_3
            errorbar(xData3, yData3, yDataError3, ...
                '*', ...
                'Color', colorPlot(3,:),...
                'LineWidth', lineWidthval, ...
                'markers', markerSize);
            hold on; view(0,90);
        end
    elseif (get(h.pm_set_plot, 'Value') == 4)
        errorbar(xDataCross, yDataCross, yDataErrorCross,...
            '*', ...
            'Color', colorPlot(3,:),...
            'LineWidth', lineWidthval, ...
            'markers', markerSize);
        hold on; view(0,90);
    else
        
    end
end

if (get(h.pm_set_plot, 'Value') == 4)
    legendStr = 'Cross profile';
    title(strcat('Cross profile @', num2str(gui.config.crossProfileLoc), gui.config.loadUnit));
elseif (get(h.pm_set_plot, 'Value') == 5)
    legendStr = {'Residual cross profile', 'Residual scratch profile'};
    title('3D plot of the residual groove');
else
    if val_1 && ~val_2 && ~val_3
        legendStr = 'Pre-profile';
    elseif ~val_1 && val_2 && ~val_3
        legendStr = 'Scratch';
    elseif ~val_1 && ~val_2 && val_3
        legendStr = 'Post-profile';
    elseif val_1 && val_2 && ~val_3
        legendStr = {'Pre-profile', 'Scratch'};
    elseif ~val_1 && val_2 && val_3
        legendStr = {'Scratch', 'Post-profile'};
    elseif val_1 && ~val_2 && val_3
        legendStr = {'Pre-profile', 'Post-profile'};
    elseif val_1 && val_2 && val_3
        legendStr = {'Pre-profile', 'Scratch', 'Post-profile'};
    end
    title('Scratch profiles');
end

xlabel(xLeg); %, 'Interpreter', 'Latex'
ylabel(yLeg); %, 'Interpreter', 'Latex'
if (get(h.pm_set_plot, 'Value') == 5)
    zlabel(zLeg); %, 'Interpreter', 'Latex'
end
if val_1 || val_2 || val_3
    h_legend1 = legend(legendStr);
    %set(h_legend1, 'Interpreter', 'Latex');
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