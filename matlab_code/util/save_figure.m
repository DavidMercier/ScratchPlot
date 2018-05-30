%% Copyright 2014 MERCIER David
function save_figure
%% Function to save figure from the GUI
gui = guidata(gcf);

%% Definition of path and filenames
if gui.config.data.data_path
    pathname_sav_fig = gui.config.data.data_path;
    filename_sav_fig1 = [gui.data.filename_data, '_GUI'];
    filename_sav_fig2 = [gui.data.filename_data, '_plot'];
    isolated_figure_title1 = fullfile(pathname_sav_fig, filename_sav_fig1);
    isolated_figure_title2 = fullfile(pathname_sav_fig, filename_sav_fig2);
    export_fig(isolated_figure_title1, gcf);
    display(strcat('Figure saved as: ', filename_sav_fig1));
    export_fig(isolated_figure_title2, isolate_axes(gca));
    display(strcat('Figure saved as: ', filename_sav_fig2));
else
    errordlg(['First set indentation grid parameters and load an Excel file '...
        'to plot a property map !']);
end

end