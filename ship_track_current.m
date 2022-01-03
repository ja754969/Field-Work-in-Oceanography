clear;clc;close all;
%%
load('./C1267/ADCP_Nan_Bay.mat')
%%
LAT_lim = [21+50/60:5/60:22];
LON_lim = [120+40/60:5/60:120+55/60];
%%
layer = 3;
current_depth = 12 + 8*(layer-1); % meter;
u = SerEmmpersec(:,layer);
v = SerNmmpersec(:,layer);
%%
filter_ind_head = find(u<-30000 | (SerHour<=23 & SerDay==25) | ...
    (SerHour<=20 & SerDay==26) | ...
    (SerMin<= 6 & SerHour<=21 & SerDay==26));
filter_ind_tail = find(v<-30000 | (SerMin>=53 & SerHour>=21 & SerDay==27) | ...
    (SerHour>=22 & SerDay==27));
u([filter_ind_head;filter_ind_tail])=[];
v([filter_ind_head;filter_ind_tail])=[];
AnLLatDeg([filter_ind_head;filter_ind_tail]) = [];
AnLLonDeg([filter_ind_head;filter_ind_tail]) = [];
%%
SerYear([filter_ind_head;filter_ind_tail]) = [];
SerMon([filter_ind_head;filter_ind_tail]) = [];
SerDay([filter_ind_head;filter_ind_tail]) = [];
SerHour([filter_ind_head;filter_ind_tail]) = [];
SerMin([filter_ind_head;filter_ind_tail]) = [];
SerSec([filter_ind_head;filter_ind_tail]) = [];
time_series = datetime(SerYear+2000,SerMon,SerDay,SerHour,SerMin,SerSec);
%%
fig = figure;
fig.PaperUnits = 'centimeters';
fig.PaperSize = [21 29.7]; % A4 papersize (horizontal,21-by-29.7 cm,[width height])
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
text(0.8,0.2,['Current depth : ' num2str(current_depth) ' m'],'FontSize',15);
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
ax1.Position = [0.01 0.69 0.28 0.28];
trajectory_ind_1 = find((SerMin>= 6 & SerHour<=21 & SerDay==26) | ...
    (SerMin>= 0 & SerHour==22 & SerDay==26) | ...
    (SerMin>= 0 & SerHour==23 & SerDay==26) | ...
    (SerMin<= 37 & SerHour==0 & SerDay==27));
ship_track_current_function(AnLLonDeg,AnLLatDeg,u,v,trajectory_ind_1,...
    LON_lim,LAT_lim,time_series)
ax1.FontSize = 15;
% c1 = colorbar;
[X1,cmap1] = imread('sst.png');
RGB1 = ind2rgb(X1,cmap1);
colormap(ax1,reshape(RGB1(10,:,:),size(RGB1,2),3));
% ---imread colormap---%
c1.Label.String = 'depth (m)';
caxis([-800 0])
m_text(120+43/60,21+59/60,'#1','Color','w','FontSize',20,'FontWeight','bold');
%%
% fig = figure;
% fig.PaperUnits = 'centimeters';
% fig.PaperSize = [29.7 21]; % A4 papersize (horizontal,21-by-29.7 cm,[width height])
% fig.PaperType = '<custom>';
% fig.WindowState = 'maximized';
% fig
%%
ax2 = axes;
ax2.Position= [0.31 0.69 0.28 0.28];
trajectory_ind_2 = find((SerMin> 37 & SerHour==0 & SerDay==27) | ...
    (SerHour==1 & SerDay==27) | (SerHour==2 & SerDay==27) | ...
    (SerHour==3 & SerDay==27) | (SerMin<=7 & SerHour==4 & SerDay==27));
ship_track_current_function(AnLLonDeg,AnLLatDeg,u,v,trajectory_ind_2,...
    LON_lim,LAT_lim,time_series)
ax2.FontSize = 15;
colormap(ax2,reshape(RGB1(10,:,:),size(RGB1,2),3));
caxis([-800 0])
m_text(120+43/60,21+59/60,'#2','Color','w','FontSize',20,'FontWeight','bold');
%%
ax3 = axes;
ax3.Position= [0.61 0.69 0.28 0.28];
trajectory_ind_3 = find((SerMin > 7 & SerHour==4 & SerDay==27) | ...
    (SerHour==5 & SerDay==27) | (SerHour==6 & SerDay==27) | ...
    (SerMin<=53 & SerHour==7 & SerDay==27));
ship_track_current_function(AnLLonDeg,AnLLatDeg,u,v,trajectory_ind_3,...
    LON_lim,LAT_lim,time_series)
ax3.FontSize = 15;
colormap(ax3,reshape(RGB1(10,:,:),size(RGB1,2),3));
caxis([-800 0])
m_text(120+43/60,21+59/60,'#3','Color','w','FontSize',20,'FontWeight','bold');


%%
ax4 = axes;
ax4.Position= [0.01 0.34 0.28 0.28];
trajectory_ind_4 = find((SerMin > 53 & SerHour==7 & SerDay==27) | ...
    (SerHour==8 & SerDay==27) | (SerHour==9 & SerDay==27) | ...
    (SerHour==10 & SerDay==27) | (SerMin<=12 & SerHour==11 & SerDay==27));
ship_track_current_function(AnLLonDeg,AnLLatDeg,u,v,trajectory_ind_4,...
    LON_lim,LAT_lim,time_series)
ax4.FontSize = 15;
colormap(ax4,reshape(RGB1(10,:,:),size(RGB1,2),3));
caxis([-800 0])
m_text(120+43/60,21+59/60,'#4','Color','w','FontSize',20,'FontWeight','bold');


%%
ax5 = axes;
ax5.Position= [0.31 0.34 0.28 0.28];
trajectory_ind_5 = find((SerMin > 12 & SerHour==11 & SerDay==27) | ...
    (SerHour==12 & SerDay==27) | (SerHour==13 & SerDay==27) | ...
    (SerMin<=38 & SerHour==14 & SerDay==27));
ship_track_current_function(AnLLonDeg,AnLLatDeg,u,v,trajectory_ind_5,...
    LON_lim,LAT_lim,time_series)
ax5.FontSize = 15;
colormap(ax5,reshape(RGB1(10,:,:),size(RGB1,2),3));
caxis([-800 0])
m_text(120+43/60,21+59/60,'#5','Color','w','FontSize',20,'FontWeight','bold');
%%
ax6 = axes;
ax6.Position= [0.61 0.34 0.28 0.28];
trajectory_ind_6 = find((SerMin > 38 & SerHour==14 & SerDay==27) | ...
    (SerHour==15 & SerDay==27) | (SerHour==16 & SerDay==27) | ...
    (SerHour==17 & SerDay==27) | (SerMin<=22 & SerHour==18 & SerDay==27));
ship_track_current_function(AnLLonDeg,AnLLatDeg,u,v,trajectory_ind_6,...
    LON_lim,LAT_lim,time_series)
ax6.FontSize = 15;
colormap(ax6,reshape(RGB1(10,:,:),size(RGB1,2),3));
caxis([-800 0])
m_text(120+43/60,21+59/60,'#6','Color','w','FontSize',20,'FontWeight','bold');

%%
ax7 = axes;
ax7.Position= [0.01 0.009 0.28 0.28];
trajectory_ind_7 = find((SerMin > 22 & SerHour==18 & SerDay==27) | ...
    (SerHour==19 & SerDay==27) | (SerHour==20 & SerDay==27) | ...
    (SerMin<=54 & SerHour==21 & SerDay==27) | (SerHour==22 & SerDay==27));
ship_track_current_function(AnLLonDeg,AnLLatDeg,u,v,trajectory_ind_7,...
    LON_lim,LAT_lim,time_series)
ax7.FontSize = 15;
colormap(ax7,reshape(RGB1(10,:,:),size(RGB1,2),3));
caxis([-800 0])
m_text(120+43/60,21+59/60,'#7','Color','w','FontSize',20,'FontWeight','bold');

%%
mkdir('./results');
saveas(gcf,'./results/ship_track_current.jpg')



