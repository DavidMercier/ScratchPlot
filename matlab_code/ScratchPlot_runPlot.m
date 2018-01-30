%% Copyright 2016 MERCIER David
function ScratchPlot_runPlot
%% Function to analyze and plot scratches
ScratchPlot_updateGUI;
gui = guidata(gcf);
config = gui.config;

%% Excel data analyzing
if isfield(config, 'flag')
    if config.flag.flag_data
        for numFile = 1:1:config.numExcelFiles
            [gui.dataExcelAnalyzed(numFile)] = ...
                ScratchPlot_Analysis(config, gui.data(numFile));
        end
    end
    
    %% Excel data plotting
    if config.flag.flag_data
        ScratchPlot_PlotData(gui.dataExcelAnalyzed);
    end
    
    %% Get minimum scratch depth
    if config.flag.flag_data
        ScratchPlot_GetMinMax(gui.dataExcelAnalyzed);
    end
else
    warning('No data loaded!');
end
end