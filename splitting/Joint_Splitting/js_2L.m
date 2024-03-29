function js_2L(sel_data)

% loop for two layers joint splitting analysis around selected station

% Copyright 2016 M.Reiss and G.R�mpker, altered May 2019

% get station(s)
[selected_stations,stations]=read_stationfile(sel_data);

sel_data.cat_phases = warning_2buttons(...
    ['Would you like to do the analysis for all saved phases',...
    'or only for phases previously categrozied as "good" or "null" '],...
    'all phases','<html>good and<br>nulls','network');
if sel_data.cat_phases == 1
    cat = 'all';
else
    cat = 'nog';
end

% loop around stations
for i=1:length(selected_stations)
    
    st_ind = strcmp(char(selected_stations(i)),stations.name);
    
    % define directories
    dir_get = sel_data.results_folder;
    dir_save =  char(strcat(dir_get,...
        char(selected_stations(i)),'_',...
        char(stations.nc(st_ind))));
    
    %% check if event list exists
    st_read = char(strcat(dir_get,...
        char(selected_stations(i)),'_',...
        char(stations.nc(st_ind)),'/phases_js.mat'));
    
    if ~exist(st_read,'file')
        w = warndlg('No pre-processed data file for this station exists',...
            ['Warning for station ',char(selected_stations(i))]);
        drawnow
        waitfor(w);
        continue
    end
    
    fname = ['/results_js_2L_',cat, '.mat'];
    
    %% check if analysis has been done before
    if exist([dir_save,fname],'file')
        
        outf = warning_2buttons(...
            'A joint-splitting analysis for two layers already exists. ',...
            'overwrite','cancel',char(selected_stations(i)));
        if outf == 2
            continue
        else
            delete([dir_save,'/results_2L_js.mat']);
        end

    end
    
    
    
    %% analysis
    
    % wait bar
    d = wait_icon(char(selected_stations(i)),2);
    
    pause(0.1) 
    [results] =  jointsplit_2L(...
        char(selected_stations(i)),char(stations.nc(st_ind)),sel_data);
    
    delete(d)
    save([dir_save,fname],'results')
    
end

end
