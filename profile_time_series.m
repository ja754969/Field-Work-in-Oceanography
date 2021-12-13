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
ax1 = axes;
ax1.Position= [0.1 0.1 0.8 0.8];
contour(lon,lat,sst,'k');
title('Profile 1')
ax1.FontSize = 15;

















