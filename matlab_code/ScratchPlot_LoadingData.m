%% Copyright 2016 MERCIER David
function ScratchPlot_LoadingData
%% Function to load Excel data from scratch tests
ScratchPlot_updateGUI;
gui = guidata(gcf);
config = gui.config;

data = struct();

%% Open window to select file
title_importdata_Window = 'File Selector from';

[data.filename_data, data.pathname_data] = ...
    uigetfile('*.xls;*.xlsx', ...
    char(title_importdata_Window), config.data.data_path);

if config.data.data_path ~= 0
    config.config.data_path = config.data.data_path;
    set(gui.handles.opendata_str_GUI, 'String', data.filename_data);
end

%% Handle canceled file selection
if data.filename_data == 0
    data.filename_data = '';
end
if data.pathname_data == 0
    data.pathname_data = '';
else
    config.data.data_path = data.pathname_data;
end

if isequal(data.filename_data,'')
    disp('User selected Cancel');
    data.pathname_data = 'no_data';
    data.filename_data = 'no_data';
    ext = '.nul';
    config.flag.flag_data = 0;
else
    disp(['User selected: ', ...
        fullfile(data.pathname_data, data.filename_data)]);
    [pathstr, name, ext] = fileparts(data.filename_data);
    config.flag.flag_data = 1;
end

data2import = [data.pathname_data, data.filename_data];
if config.flag.flag_data
    [status,sheets,format] = xlsfinfo(data2import);
    numTest = length(sheets)-4;
end

%% Get experimental parameters
if config.flag.flag_data
    sheetName_param = sheets(find(strcmp(sheets,'Required Inputs')==1));
    [paramAll, param_txtAll] = xlsread(data2import, char(sheetName_param));
    
    numTest2 = size(paramAll,1);
    
    if numTest == numTest2
        display(strcat('Number of scratch tests is:', num2str(numTest),'.'));
    else
        warning('Problem in scratch tests number definition !');
        numTest = numTest2;
    end
    
    % Scratch length
    config.ScratchLength = paramAll(1,2); % In micron
    display(...
        strcat('Maximum scratch length is:', num2str(config.ScratchLength), ...
        gui.config.lengthUnit));
    config.ScratchLengthOverRange = paramAll(1,12)/100;
    config.maxScratchLength = config.ScratchLength+...
        2*(config.ScratchLengthOverRange*config.ScratchLength);
    config.minScratchLengthVal = ...
        config.ScratchLengthOverRange*config.ScratchLength;
    
    % Scratch load
    config.scanLoad = paramAll(1,13)/1000; % In mN (initially in microN in the .xls file
    display(strcat('Profiling scratch load is:', num2str(config.scanLoad), ...
        'mN'));
    config.maxLoad = paramAll(1,5); % In mN
    display(strcat('Maximum scratch load is:', num2str(config.maxLoad), ...
        'mN'));
    
    %% Preallocation of variables
    data.expValues.dispVert(:,:) = zeros(config.numRowMax, 1);
    data.expValues.dispHori(:,:) = zeros(config.numRowMax, 1);
    data.expValues.load(:,:) = zeros(config.numRowMax, 1);
    
    %% Loading of data
    h = waitbar(0,'Please wait, loading of Excel data...');
    numTestMaxCorrected = 0;
    if strcmp (ext, '.xls') == 1 || strcmp (ext, '.xlsx') == 1
        for ii = 1:numTest
            waitbar(ii / numTest)
            clear dataAll; clear txtAll;
            if ii < 10
                sheetName = strcat('test 00', num2str(ii));
            elseif ii < 100 && ii >= 10
                sheetName = strcat('test 0', num2str(ii));
            elseif ii < 1000 && ii >= 100
                sheetName = strcat('test ', num2str(ii));
            end
            try
                [dataAll, txtAll] = xlsread(data2import, sheetName);
            catch err
                dataAll = NaN;
                txtAll = NaN;
                display(err.message);
                numTestMaxCorrected = numTestMaxCorrected + 1;
            end
            
            if config.scratchProg == 1 & ~isnan(dataAll)
                % Scratch program with constant load
                data.expValues(ii).dispVert = dataAll(:,5);
                data.expValues(ii).dispHori = dataAll(:,8);
                data.expValues(ii).load = dataAll(:,10);
            elseif config.scratchProg == 2 & ~isnan(dataAll)
                % Scratch program with non constant load (ramp)
                
                % Remove 1e+308 values
                for jj = 1:size(dataAll, 1)
                    if dataAll(jj,1) > 1e10
                        dataAll(jj,1) = NaN;
                    end
                    if dataAll(jj,5) > 1e10
                        dataAll(jj,5) = NaN;
                    end
                    if dataAll(jj,6) > 1e10
                        dataAll(jj,6) = NaN;
                    end
                end
                data.expValues(ii).dispVert = dataAll(:,1);
                data.expValues(ii).dispHori = dataAll(:,5);
                data.expValues(ii).load = dataAll(:,6);
            end
        end
    end
    close(h);
end
%% Correcting slope
% for ii = 1:length(data.expValues)
%     [data.expValues(ii).dispVert,data.expValues(ii).dispVert_fit] = ...
%         bf(data.expValues(ii).dispVert);
% end

%% Data encapsulation
gui.config = config;
gui.data = data;
guidata(gcf, gui);

%% Run plot
ScratchPlot_runPlot;

end