%% Copyright 2016 MERCIER David
function demo
%% Function to read, to analyze and to plot Excel data from scratch tests
clear all
clear classes % not included in clear all
close all
commandwindow
clc
delete(findobj(allchild(0), '-regexp', 'Tag', '^Msgbox_'))

%% Define gui structure variable
gui = struct();
gui.config = struct();
gui.config.data = struct();
gui.config.numerics = struct();

config = gui.config;

%% Check Licenses
license_msg_1 = ['Sorry, no license found for the Matlab ', ...
    'Image Toolbox!'];
if license('checkout', 'image_toolbox') == 0
    warning(license_msg_1);
    config.licenceImProc_Flag = 0;
else
    config.licenceImProc_Flag = 1;
end

%% Paths Management
try
    config.Scratchroot = get_scratch_root; % ensure that environment is set
catch
    [startdir, dummy1, dummy2] = fileparts(mfilename('fullpath'));
    cd(startdir);
    commandwindow;
    path_management;
    config.Scratchroot = get_scratch_root; % ensure that environment is set
end

%% Set Toolbox version and help paths
config.name_toolbox = 'ScratchPlot';
config.version_toolbox = '1.0';
% config.url_help = 'http://tridimapScratchPlot.readthedocs.org/en/latest/';
% config.pdf_help = 'https://media.readthedocs.org/pdf/ScratchPlottridimap/latest/ScratchPlot.pdf';
config.data.data_path = '.\data_scratch\';
config.data.data_pathNew = '.\data_scratch\';
config.image.image_path = '.\data_image\';
config.image.image_pathNew = '.\data_image\';

%% Parameters definition
% Scratch program with constant load = 1
% Scratch program with non constant load = 2 (ramp)
config.scratchProg = 2;            
config.numRowMax = 10000; % Initial number of rows to preallocate variables...

gui.config = config;
ScratchPlot_GUI(gui);

%% Set logo of the GUI
java_icon_scratchPlot;

end