clear;clc;close all;
%%
file_dir = dir(['./CTD/CNV/' 'C*.CNV']);
%% Read CTD folder
% # name 0 = pr: pressure [db]
% # name 1 = t090: temperature, ITS-90 [deg C]
% # name 2 = c0S/m: conductivity [S/m]
% # name 3 = sal00: salinity, PSS-78 [PSU]
% # name 4 = sigma-�00: density, sigma-theta [kg/m^3]
% # name 5 = flag:  0.000e+00
% # name 6 = nbin: number of scans per bin
depth_modify = NaN(3,1);
depth_upper = [];
depth_lower = [];
for i = 1:length(file_dir) 
    filename = ['./CTD/CNV/' file_dir(i).name];
    fid = fopen(filename,'r')
    ctd{i} = textscan(fid, '%f %f %f %f %f %f %f',...
        'headerLines', 80,'Delimiter','\t');
    depth{i} = ctd{i}{1};
    if length(depth{i}) > length(depth_modify)
        depth_modify = depth{i};
    end
    depth_upper = [depth_upper;depth{i}(1)];
    depth_lower = [depth_lower;depth{i}(end)];
    fclose(fid);
end
depth_intersect = (max(depth_upper):min(depth_lower))';
depth_concat = [];
temperature_concat = [];
salinity_concat = [];
for j = 1:length(depth)
%    cut_upper{j} = 1:find(depth{j}==depth_intersect(1))-1;
%    cut_lower{j} = 1+find(depth{j}==depth_intersect(end)):length(depth{j});
   temperature = ctd{j}{2}; 
   salinity = ctd{j}{4};
   if (depth{j}(1) ~= min(depth_upper)) && (depth{j}(end) == max(depth_lower))
       depth_temp = [(min(depth_upper):depth{j}(1)-1)';depth{j}];
       temperature_temp = [NaN(depth{j}(1)-min(depth_upper),1);temperature];
       salinity_temp = [NaN(depth{j}(1)-min(depth_upper),1);salinity];
   elseif (depth{j}(1) == min(depth_upper)) && (depth{j}(end) ~= max(depth_lower))
       depth_temp = [depth{j};(depth{j}(end)+1:max(depth_lower))'];
       temperature_temp = [temperature;NaN(max(depth_lower)-depth{j}(end),1)];
       salinity_temp = [salinity;NaN(max(depth_lower)-depth{j}(end),1)];
   else
       depth_temp = [(min(depth_upper):depth{j}(1)-1)';depth{j};(depth{j}(end)+1:max(depth_lower))'];
       temperature_temp = [NaN(depth{j}(1)-min(depth_upper),1);...
           temperature;...
           NaN(max(depth_lower)-depth{j}(end),1)];
       salinity_temp = [NaN(depth{j}(1)-min(depth_upper),1);...
           salinity;...
           NaN(max(depth_lower)-depth{j}(end),1)];
   end
   depth_concat(:,j) = depth_temp;
   temperature_concat(:,j) = temperature_temp;
   salinity_concat(:,j) = salinity_temp;
   temperature(1:find(depth{j}==depth_intersect(1))-1)=NaN;
   temperature(1+find(depth{j}==depth_intersect(end)):...
       length(depth{j}))=NaN;
   temperature(isnan(temperature)==1)=[];
   temperature_intersect(:,j) = temperature;
   
       %    cut_lower{j} = 1+find(depth{j}==depth_intersect(end)):length(depth{j});
end
%     temperature = ctd{2};
%     conductivity(:,i) = ctd{3};
%     salinity(:,i) = ctd{4};
%     density(:,i) = ctd{5};
%     flag = ctd{6};
%     nbin = ctd{7};
%%
fig = figure;
fig.PaperUnits = 'centimeters';
fig.PaperSize = [29.7 21]; % A4 papersize (horizontal,21-by-29.7 cm,[width height])
fig.PaperType = '<custom>';
fig.WindowState = 'maximized';
fig
%%
ax1 = axes;
ax1.Position= [0.05 0.55 0.9 0.35];
% contour(lon,lat,sst,'k');
contourf((1:length(depth))',depth_concat(:,1),temperature_concat)
c1 = colorbar;
% caxis([-0.5 0.5]);
% ---imread colormap---%
[X1,cmap1] = imread('rainbow.png');
RGB1 = ind2rgb(X1,cmap1);
colormap(gca,reshape(RGB1(10,:,:),size(RGB1,2),3));
% ---imread colormap---%
c1.Label.String = '^{o}C';
xlabel('Temperature Profile Time Series')
ylabel('depth [m]')
view(0,-90)
ax1.FontSize = 15;
ax1.XTick = 2:2:28;
ax1.XAxisLocation = 'top';
ax1.TickDir = 'both';
% ax1.XLabel = 'Hours (From Dec-25-2007 07:44:08 to Dec 26 2007 12:43:49';

ax2 = axes;
ax2.Position= [0.05 0.1 0.9 0.35];
% contour(lon,lat,sst,'k');
contourf((1:length(depth))',depth_concat(:,1),salinity_concat)
c2 = colorbar;
% caxis([-0.5 0.5]);
% ---imread colormap---%
[X2,cmap2] = imread('haline.png');
RGB2 = ind2rgb(X2,cmap2);
colormap(gca,flipud(reshape(RGB2(10,:,:),size(RGB2,2),3)));
% ---imread colormap---%
c2.Label.String = 'psu';
title({'Timestamp (From Dec-25-2007 07:44:08 to Dec-6-2007 12:43:49)',...
    ' '})
ylabel('depth [m]')
xlabel('Salinity Profile Time Series')
view(0,-90)
ax2.FontSize = 15;
ax2.XTick = 2:2:28;
ax2.TickDir = 'both';

%%
mkdir('./results');
saveas(gcf,'./results/profile_time_series.jpg')













