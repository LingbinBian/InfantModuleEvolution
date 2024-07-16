%% clear data
clc;
clear;
close all;
%% edge color
data1=randn(1000,12);
data2=randn(1000,12)+1;
edgecolor1=[0,0,0]; % black color
edgecolor2=[0,0,0]; % black color
fillcolor1=[206, 85, 30]/255; % fillcolors = rand(24, 3);
fillcolor2=[46, 114, 188]/255;
fillcolors=[repmat(fillcolor1,12,1);repmat(fillcolor2,12,1)];
position_1 = [0.8:1:11.8];  % define position for first group boxplot
position_2 = [1.2:1:12.2];  % define position for second group boxplot 
box_1 = boxplot(data1,'positions',position_1,'colors',edgecolor1,'width',0.2,'notch','on','symbol','r+','outliersize',5);
hold on;
box_2 = boxplot(data2,'positions',position_2,'colors',edgecolor2,'width',0.2,'notch','on','symbol','r+','outliersize',5);
boxobj = findobj(gca,'Tag','Box');
for j=1:length(boxobj)
    patch(get(boxobj(j),'XData'),get(boxobj(j),'YData'),fillcolors(j,:),'FaceAlpha',0.5);
end
set(gca,'XTick', [1 2 3 4 5 6 7 8 9 10 11 12],'Xlim',[0 13]);
boxchi = get(gca, 'Children');
legend([boxchi(1),boxchi(13)], ["Feature1", "Feature2"] );
%% save figure
savefig(gcf,'boxplot_position_fillcolor.fig');
print(gcf, '-dpdf', 'boxplot_position_fillcolor.pdf')  % 保存为pdf文件