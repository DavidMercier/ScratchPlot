%% Copyright 2016 MERCIER David
function scratch_root = get_scratch_root
%% Get environment variable for Scratch toolbox

scratch_root = getenv('SCRATCH_TBX_ROOT');

if isempty(scratch_root)
    msg = 'Run the path_management.m script !';
    commandwindow;
    display(msg);
    %errordlg(msg, 'File Error');
    error(msg);
end

end