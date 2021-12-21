clear;clc;close all;
%%
load('./C1267/ADCP_Nan_Bay.mat')
%%
layer = 2;
u = SerEmmpersec(:,layer);
v = SerNmmpersec(:,layer);
%%
filter_ind_1 = find(u<-30000 | (SerHour<=23 & SerDay==25) | ...
    (SerHour<=20 & SerDay==26) | ...
    (SerMin<= 6 & SerHour<=21 & SerDay==26));
filter_ind_2 = find(v<-30000 | (SerMin>=53 & SerHour>=21 & SerDay==27) | ...
    (SerHour>=22 & SerDay==27));
u([filter_ind_1;filter_ind_2])=NaN;
v([filter_ind_1;filter_ind_2])=NaN;
AnLLatDeg([filter_ind_1;filter_ind_2]) = NaN;
AnLLonDeg([filter_ind_1;filter_ind_2]) = NaN;

%%
fig = figure;
fig.PaperUnits = 'centimeters';
fig.PaperSize = [29.7 21]; % A4 papersize (horizontal,21-by-29.7 cm,[width height])
fig.PaperType = '<custom>';
fig.WindowState = 'maximized';
fig
%%
LAT_lim = [21.75 22];
LON_lim = [120.6 120.9];
%%
% ax = axes;
% ax.Position= [0.1 0.1 0.8 0.8];
% m_proj('miller','lon',[LON_lim(1) LON_lim(end)],'lat',[LAT_lim(1) LAT_lim(end)]);
% m_plot(AnLLonDeg,AnLLatDeg,'k')
% hold on;
% m_quiver(AnLLonDeg,AnLLatDeg,u,v,'b');
% hold on;
% % m_quiver(AnLLonDeg,AnLLatDeg,SerEmmpersec(:,1),SerNmmpersec(:,1),'m');
% % hold on;
% m_gshhs_f('patch',[.7 .7 .7],'linewidth',0.5);
% m_grid('tickdir','in','xtick',LON_lim,'ytick',LAT_lim,'fontsize',15)
% title('Ship Trajectory All')
% ax.FontSize = 15;
%%
ax1 = axes;
ax1.Position= [0.1 0.1 0.8 0.8];
trajectory_ind_1 = find((SerMin>= 6 & SerHour<=21 & SerDay==26) | ...
    (SerMin>= 0 & SerHour==22 & SerDay==26) | ...
    (SerMin>= 0 & SerHour==23 & SerDay==26) | ...
    (SerMin<= 37 & SerHour==0 & SerDay==27));
m_proj('miller','lon',[LON_lim(1) LON_lim(end)],'lat',[LAT_lim(1) LAT_lim(end)]);
m_plot(AnLLonDeg(trajectory_ind_1),AnLLatDeg(trajectory_ind_1),'k')
hold on;
m_quiver(AnLLonDeg(trajectory_ind_1),AnLLatDeg(trajectory_ind_1),...
    u(trajectory_ind_1),v(trajectory_ind_1),'b');
hold on;
% m_quiver(AnLLonDeg,AnLLatDeg,SerEmmpersec(:,1),SerNmmpersec(:,1),'m');
% hold on;
m_gshhs_f('patch',[.7 .7 .7],'linewidth',0.5);
m_grid('tickdir','in','xtick',LON_lim,'ytick',LAT_lim,'fontsize',15)
title('Ship Trajectory #1')
ax1.FontSize = 15;
%%
fig = figure;
fig.PaperUnits = 'centimeters';
fig.PaperSize = [29.7 21]; % A4 papersize (horizontal,21-by-29.7 cm,[width height])
fig.PaperType = '<custom>';
fig.WindowState = 'maximized';
fig
%%
ax2 = axes;
ax2.Position= [0.1 0.1 0.8 0.8];
trajectory_ind_2 = find((SerMin> 37 & SerHour==0 & SerDay==27) | ...
    (SerHour==1 & SerDay==27) | (SerHour==2 & SerDay==27) | ...
    (SerHour==3 & SerDay==27) | (SerMin<=7 & SerHour==4 & SerDay==27));
m_proj('miller','lon',[LON_lim(1) LON_lim(end)],'lat',[LAT_lim(1) LAT_lim(end)]);
m_plot(AnLLonDeg(trajectory_ind_2),AnLLatDeg(trajectory_ind_2),'k')
hold on;
m_quiver(AnLLonDeg(trajectory_ind_2),AnLLatDeg(trajectory_ind_2),...
    u(trajectory_ind_2),v(trajectory_ind_2),'b');
hold on;
% m_quiver(AnLLonDeg,AnLLatDeg,SerEmmpersec(:,1),SerNmmpersec(:,1),'m');
% hold on;
m_gshhs_f('patch',[.7 .7 .7],'linewidth',0.5);
m_grid('tickdir','in','xtick',LON_lim,'ytick',LAT_lim,'fontsize',15)
title('Ship Trajectory #2')
ax2.FontSize = 15;

















