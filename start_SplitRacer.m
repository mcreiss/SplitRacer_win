function start_gui

% GUI for SplitRacer

% Copyright 2016 M.Reiss and G.R�mpker

close all
clc
clear all
clear global

warning('off','all');

txt = strvcat({'SplitRacer - Copyright 2016 M.Reiss and G.R�mpker',...
    'This program is free software: you can redistribute it and/or ',...
    'modify it under the terms of the GNU General Public License as ',...
    'published by the Free Software Foundation, either version 3 of ',...
    'the License, or (at your option) any later version.', ' ',...
    'This program is distributed in the hope that it will be useful, ',...
    'but WITHOUT ANY WARRANTY; without even the implied warranty of ',...
    'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the ',...
    'GNU General Public License for more details. ', ' ',...
    'You should have received a copy of the GNU General Public License ',...
    'along with this program. ',...
    'If not, see <http://www.gnu.org/licenses/>.'});

disp(txt);

global sel_data

% get current folder name
cur_dir = pwd;
[upp_path, df, ~] = fileparts(cur_dir); 

% add all sub directories to search path
addpath(genpath(['../',df]));

% create main GUI
mainfig = figure('Name','SplitRacer 2.0','NumberTitle','off',...
    'units','normalized','position',[.3 .1 .5 .5]);
movegui(mainfig,'center')

hsp = uipanel('units','normalized','position',[.0 .0 .2 1]);

menu_bg = uibuttongroup('Parent',hsp,'Visible', 'on','Position', ...
    [.0 .0 1 1]);

txt = uicontrol(menu_bg,'Style','text','Visible','on','Units',...
    'normalized','position',[0.1,0.85,0.8,0.1],'String','Main Menu',...
    'fontunits','normalized',...
    'fontsize',0.45);

btn1 = uicontrol(menu_bg,'Style','pushbutton','Units', 'normalized',...
    'position',[.1 .7 .8 .1],'String','Download Data','fontunits',...
    'normalized','fontsize',0.28,'enable', 'off',...
        'Callback',@uiloaddata);
btn2 = uicontrol(menu_bg,'Style','pushbutton','Units', 'normalized',...
    'position',[.1 .55 .8 .1], 'String','Pre-Process Data','fontunits',...
    'normalized','fontsize',0.28,...
    'enable', 'off','Callback',{@uipreprodata});
btn3 = uicontrol(menu_bg,'Style','pushbutton','Units', 'normalized',...
    'position',[.1 .4 .8 .1],'String','Splitting Analysis','fontunits',...
    'normalized','fontsize',0.28,...
    'enable', 'off','Callback',{@uisplitting});



btn4 = uicontrol(menu_bg,'Style','pushbutton','Units', 'normalized',...
    'position',[.1 .1 .8 .1],'String','exit','fontunits',...
    'normalized','fontsize',0.28,'Callback','delete(gcf)');
    
ui_main(menu_bg,btn1,btn2,btn3)

end




