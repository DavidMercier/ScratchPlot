%% Copyright 2016 MERCIER David
function ScratchPlot_GetMinMax(data)
%% Function to get minimum and maximum scratch depth

gui = guidata(gcf);
h = gui.handles;
config = gui.config;

clc;
display(strcat('Excel number file:', num2str(config.numExcelFiles)));

for numFile = 1:1:config.numExcelFiles
    if get(h.cb_plot_preScratch, 'Value')
        [Zmax(numFile), Ind(numFile)] = max(data(numFile).dispVertMean_1);
        Zmax_error(numFile) = data(numFile).dispVertError_1(Ind(numFile));
        display(strcat('Maximum depth of pre-scratch=(',...
            num2str(Zmax(numFile)),'+/-',num2str(Zmax_error(numFile)), ...
            ')',gui.config.lengthUnit));
        [Zmin(numFile), Ind(numFile)] = min(data(numFile).dispVertMean_1);
        Zmin_error(numFile) = data(numFile).dispVertError_1(Ind(numFile));
        display(strcat('Minimum depth of pre-scratch=(',...
            num2str(Zmin(numFile)),'+/-',num2str(Zmin_error(numFile)), ...
            ')',gui.config.lengthUnit));
    end
    if get(h.cb_plot_scratch, 'Value')
        [Zmax(numFile), Ind(numFile)] = max(data(numFile).dispVertMean_2);
        Zmax_error(numFile) = data(numFile).dispVertError_2(Ind(numFile));
        display(strcat('Maximum depth of scratch=(',...
            num2str(Zmax(numFile)),'+/-',num2str(Zmax_error(numFile)), ...
            ')',gui.config.lengthUnit));
        [Zmin(numFile), Ind(numFile)] = min(data(numFile).dispVertMean_2);
        Zmin_error(numFile) = data(numFile).dispVertError_2(Ind(numFile));
        display(strcat('Minimum depth of scratch=(',...
            num2str(Zmin(numFile)),'+/-',num2str(Zmin_error(numFile)), ...
            ')',gui.config.lengthUnit));
    end
    if get(h.cb_plot_postScratch, 'Value')
        [Zmax(numFile), Ind(numFile)] = max(data(numFile).dispVertMean_3);
        Zmax_error(numFile) = data(numFile).dispVertError_3(Ind(numFile));
        display(strcat('Maximum depth of post-scratch=(',...
            num2str(Zmax(numFile)),'+/-',num2str(Zmax_error(numFile)), ...
            ')',gui.config.lengthUnit));
        [Zmin(numFile), Ind(numFile)] = min(data(numFile).dispVertMean_3);
        Zmin_error(numFile) = data(numFile).dispVertError_3(Ind(numFile));
        display(strcat('Minimum depth of post-scratch=(',...
            num2str(Zmin(numFile)),'+/-',num2str(Zmin_error(numFile)), ...
            ')',gui.config.lengthUnit));
    end
    
end

end