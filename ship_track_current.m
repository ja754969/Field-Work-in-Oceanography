clear;clc;close all;
%%
load('./C1267/ADCP_Nan_Bay.mat')
%%
LAT_lim = [21+50/60:5/60:22];
LON_lim = [120+40/60:5/60:120+55/60];
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
u([filter_ind_1;filter_ind_2])=[];
v([filter_ind_1;filter_ind_2])=[];
AnLLatDeg([filter_ind_1;filter_ind_2]) = [];
AnLLonDeg([filter_ind_1;filter_ind_2]) = [];
%%
SerYear([filter_ind_1;filter_ind_2]) = [];
SerMon([filter_ind_1;filter_ind_2]) = [];
SerDay([filter_ind_1;filter_ind_2]) = [];
SerHour([filter_ind_1;filter_ind_2]) = [];
SerMin([filter_ind_1;filter_ind_2]) = [];
SerSec([filter_ind_1;filter_ind_2]) = [];
%%
fig = figure;
fig.PaperUnits = 'centimeters';
fig.PaperSize = [29.7 21]; % A4 papersize (horizontal,21-by-29.7 cm,[width height])
fig.PaperType = '<custom>';
fig.WindowState = 'maximized';
fig
%%
ax8 = axes;
ax8.Position= [0.05 0.05 0.9 0.9];
ax8.XColor = 'none';ax8.YColor = 'none';
[ELEV,LONG,LAT] = m_etopo2([118 123 20 30]); % [ELEV,LONG,LAT]=m_etopo2([LONG_MIN LONG_MAX LAT_MIN LAT_MAX])
% m_pcolor(LONG,LAT,ELEV);shading interp
c1 = colorbar;
[X1,cmap1] = imread('sst.png');
RGB1 = ind2rgb(X1,cmap1);
colormap(ax8,reshape(RGB1(10,:,:),size(RGB1,2),3));
% ---imread colormap---%
c1.Label.String = 'depth (m)';
c1.Label.FontSize = 20;
c1.FontSize = 20;
c1.FontWeight = 'bold';
caxis([-800 0])
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
ax1.Position= [0.05 0.6 0.3 0.3];
trajectory_ind_1 = find((SerMin>= 6 & SerHour<=21 & SerDay==26) | ...
    (SerMin>= 0 & SerHour==22 & SerDay==26) | ...
    (SerMin>= 0 & SerHour==23 & SerDay==26) | ...
    (SerMin<= 37 & SerHour==0 & SerDay==27));
m_proj('miller','lon',[LON_lim(1) LON_lim(end)],'lat',[LAT_lim(1) LAT_lim(end)]);
[ELEV,LONG,LAT] = m_etopo2([118 123 20 30]); % [ELEV,LONG,LAT]=m_etopo2([LONG_MIN LONG_MAX LAT_MIN LAT_MAX])
m_pcolor(LONG,LAT,ELEV);shading interp
c1 = colorbar;
[X1,cmap1] = imread('sst.png');
RGB1 = ind2rgb(X1,cmap1);
colormap(ax1,reshape(RGB1(10,:,:),size(RGB1,2),3));
% ---imread colormap---%
c1.Label.String = 'depth (m)';
caxis([-800 0])
hold on;
m_plot(AnLLonDeg(trajectory_ind_1),AnLLatDeg(trajectory_ind_1),'k')
hold on;
mqr = m_quiver(AnLLonDeg(trajectory_ind_1),AnLLatDeg(trajectory_ind_1),...
    u(trajectory_ind_1),v(trajectory_ind_1),0);

scale = 0.00001;
mqr.Color = 'b';
hU1 = get(mqr,'UData');
hV1 = get(mqr,'VData');
set(mqr,'UData',scale*hU1,'VData',scale*hV1)
hold on;
% m_quiver(AnLLonDeg,AnLLatDeg,SerEmmpersec(:,1),SerNmmpersec(:,1),'m');
% hold on;
m_gshhs_f('patch',[0 0 0],'linewidth',0.5);
m_grid('tickdir','in','xtick',LON_lim,'ytick',LAT_lim,'fontsize',15)
title({'Ship Trajectory #1';...
    ['2007/12/' num2str(SerDay(trajectory_ind_1(1))) ' ' ...
    num2str(SerHour(trajectory_ind_1(1))) ':' num2str(SerMin(trajectory_ind_1(1))) ...
    ':' num2str(SerSec(trajectory_ind_1(1))) ' ~ ' '2007/12/' num2str(SerDay(trajectory_ind_1(end))) ' ' ...
    num2str(SerHour(trajectory_ind_1(end))) ':' num2str(SerMin(trajectory_ind_1(end))) ...
    ':' num2str(SerSec(trajectory_ind_1(end)))]},'FontSize',20) ;
ax1.FontSize = 15;
%%
% fig = figure;
% fig.PaperUnits = 'centimeters';
% fig.PaperSize = [29.7 21]; % A4 papersize (horizontal,21-by-29.7 cm,[width height])
% fig.PaperType = '<custom>';
% fig.WindowState = 'maximized';
% fig
%%
ax2 = axes;
ax2.Position= [0.35 0.6 0.3 0.3];
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
















