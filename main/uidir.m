function uidir(hObject,handles)

% set new working directory

% Copyright 2016 M.Reiss and G.Rümpker

global sel_data

sel_data.work_dir = uigetdir('','please select folder');


end