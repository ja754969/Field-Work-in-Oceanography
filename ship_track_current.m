clear;clc;close all;
%%

%%
%%
fig = figure;
fig.PaperUnits = 'centimeters';
fig.PaperSize = [29.7 21]; % A4 papersize (horizontal,21-by-29.7 cm,[width height])
fig.PaperType = '<custom>';
fig.WindowState = 'maximized';
fig
%%
LAT_lim = [21.75 22];
LON_lim = [120.5 120.8];
%%
ax1 = axes;
ax1.Position= [0.1 0.1 0.8 0.8];
m_proj('miller','lon',[LON_lim(1) LON_lim(end)],'lat',[LAT_lim(1) LAT_lim(end)]);
% m_quiver(AVISO_20050418_lon,AVISO_20050418_lat,AVISO_20050418_u,AVISO_20050418_v,'k');
% hold on;
m_gshhs_f('patch',[.7 .7 .7],'linewidth',0.5);
m_grid('tickdir','in','xtick',LON_lim,'ytick',LAT_lim,'fontsize',15)
title('Ship Trajectory #1')
ax1.FontSize = 15;

















