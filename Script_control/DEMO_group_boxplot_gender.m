% DEMO Statistical analysis for modular evolution between male and female

% Version 1.0
% 20-Oct-2023
% Copyright (c) 2023, Lingbin Bian

clear
clc
close all

N_roi=400;
scan=2;

if scan==1
    load(['/home/lingbin/Documents/work/pythonProject/BCP_fMRI/results_F/roi_',num2str(N_roi),'_simi_F_AP.mat']);
    load(['/home/lingbin/Documents/work/pythonProject/BCP_fMRI/results_M/roi_',num2str(N_roi),'_simi_M_AP.mat']);
else 
    load(['/home/lingbin/Documents/work/pythonProject/BCP_fMRI/results_F/roi_',num2str(N_roi),'_simi_F_PA.mat']);
    load(['/home/lingbin/Documents/work/pythonProject/BCP_fMRI/results_M/roi_',num2str(N_roi),'_simi_M_PA.mat']);
end

age_range={'0-5 vs 6-11 Month', '3-8 vs 9-14 Month', '6-11 vs 12-17 Month','9-14 vs 15-23 Month','12-17 vs 18-29 Month','15-23 vs 24-36 Month','18-29 vs >36 Month'};

data1=simi_female;
data2=simi_male;
% edge color
figure

edgecolor1=[0,0,0]; % black color
edgecolor2=[0,0,0]; % black color
%fillcolor1=[206, 85, 30]/255; % fillcolors = rand(24, 3);
%fillcolor2=[46, 114, 188]/255;
%fillcolor1=[0.1 0.7 0.7]; % fillcolors = rand(24, 3);
%fillcolor2=[1 0.4 0.6];

fillcolor2=[1,0.75,0.8];
fillcolor1=[0.53,0.81,0.92]; % fillcolors = rand(24, 3);

fillcolors=[repmat(fillcolor1,7,1);repmat(fillcolor2,7,1)];
position_1 = 0.8:1:6.8;  % define position for first group boxplot
position_2 = 1.2:1:7.2;  % define position for second group boxplot 
box_1 = boxplot(data1,'positions',position_1,'colors',edgecolor1,'width',0.2,'symbol','r+','outliersize',5);
hold on;
box_2 = boxplot(data2,'positions',position_2,'colors',edgecolor2,'width',0.2,'symbol','r+','outliersize',5);
boxobj = findobj(gca,'Tag','Box');
for j=1:length(boxobj)
    patch(get(boxobj(j),'XData'),get(boxobj(j),'YData'),fillcolors(j,:),'FaceAlpha',0.5,'LineWidth', 1);
end

 
%set(gca,'xticklabel',{'0-5 vs\newline 6-11', '3-8 vs\newline 9-14', '6-11 vs\newline 12-17','9-14 vs\newline 15-23','12-17 vs\newline 18-29','15-23 vs\newline 24-36','18-29 vs\newline >36'},'FontSize',12);    

set(gca,'XTick', [1 2 3 4 5 6 7 ],'Xlim',[0 8]);
boxchi = get(gca, 'Children');


%box_var=findall(gca,'Tag','Box')
%legend(box_var([7,14]), {'Hierarchical Bayesian', 'Group Averaging'});
hLegend=legend([boxchi(1),boxchi(8)], ["Female", "Male"],'location','southeast');

%legend([corre_hier(1,1),corre_ave(1,1)],"Hierarchical Bayesian", "Group Averaging");
ylim([-0.2,1.5]); % range of y
set(gca,'xticklabel',{'0-5/6-11', '3-8/9-14', '6-11/12-17','9-14/15-23','12-17/18-29','15-23/24-36','18-29/>36'},'FontSize',12);

set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')   
xlabel('Month','fontsize',16)
ylabel('Jaccard similarity coefficient','fontsize',16)
% set(gcf,'unit','centimeters','position',[6 10 30 15])
% set(gca,'Position',[.15 .18 .75 .75]);


set(gcf,'unit','centimeters','position',[6 10 18 14])
%set(gcf,'unit','centimeters','position',[6 10 30 18])
set(gca,'Position',[.15 .28 .75 .6]);
% save figure
%savefig(gcf,'boxplot_position_fillcolor.fig');
%print(gcf, '-dpdf', 'boxplot_position_fillcolor.pdf')  % save as pdf


sig_x=zeros(7,2);
sig_y=zeros(7,1);

p_v=zeros(7,1);
h=zeros(7,1);
ci=cell(7,1);
stats=cell(7,1);

p=zeros(7,1);
h1=zeros(7,1);
ci1=cell(7,1);

x=[0.8,1.2];

for i=1:7
    [h(i),p_v(i),ci{i},stats{i}] = vartest2(data1(:,i),data2(:,i));
    if p_v < 0.05
        [h1(i),p(i),ci1{i}] = ttest2(data1(:,i),data2(:,i),'Vartype','unequal');
    else
        [h1(i),p(i),ci1{i}] = ttest2(data1(:,i),data2(:,i));
    end
    sigline(x,max(max([data1(:,i),data2(:,i)])), p(i),p_v(i)); %
    x=x+1;
end
if scan==1
    title(['AP',', ROI=',num2str(N_roi)],'fontsize', 16)
else
    title(['PA',', ROI=',num2str(N_roi)],'fontsize', 16)
end

currentLabels = hLegend.String; % Get current labels (cell array)
Labels_remove={currentLabels{1},currentLabels{2}};
hLegend.String=Labels_remove;
 
data_path = fileparts(mfilename('fullpath'));
if scan==1
    results_path=fullfile(data_path,['../results/','roi_',num2str(N_roi),'_AP','_statistical_analysis_gender']);
    save(results_path); 
    saveas(gcf,['../figures/','roi_',num2str(N_roi),'_AP','_statistical_analysis_gender.fig'])
elseif scan==2
    results_path=fullfile(data_path,['../results/','roi_',num2str(N_roi),'_PA','_statistical_analysis_gender']);
    save(results_path); 
    saveas(gcf,['../figures/','roi_',num2str(N_roi),'_PA','_statistical_analysis_gender.fig'])
end

% -------------------------------------------------------------------------
% sigline
function sigline(x, y, p, p_v)
hold on
x = x';

if p<0.001
    plot(mean(x),       y*1.15, '*k')          % the sig star sign
    plot(mean(x)- 0.16, y*1.15, '*k')          % the sig star sign
    plot(mean(x)+ 0.16, y*1.15, '*k')          % the sig star sign

elseif (0.001<=p)&&(p<0.01)
    plot(mean(x)- 0.08, y*1.15, '*k')         % the sig star sign
    plot(mean(x)+ 0.08, y*1.15, '*k')         % the sig star sign

elseif (0.01<=p)&&(p<0.05)
    plot(mean(x), y*1.15, '*k')               % the sig star sign
else
    %print('not significance');
end

if p_v<0.001
    plot(mean(x),       y*1.2, 'pentagram','color',[0 0 0])          % the sig star sign
    plot(mean(x)- 0.16, y*1.2, 'pentagram','color',[0 0 0])          % the sig star sign
    plot(mean(x)+ 0.16, y*1.2, 'pentagram','color',[0 0 0])          % the sig star sign

elseif (0.001<=p_v)&&(p_v<0.01)
    plot(mean(x)- 0.08, y*1.2, 'pentagram','color',[0 0 0])         % the sig star sign
    plot(mean(x)+ 0.08, y*1.2, 'pentagram','color',[0 0 0])         % the sig star sign

elseif (0.01<=p_v)&&(p_v<0.05)
    plot(mean(x), y*1.2, 'pentagram','color',[0 0 0])               % the sig star sign
else
    fprintf('no significance ');
end


plot(x, [1;1]*y*1.1, '-k', 'LineWidth',1); % significance horizontal line
plot([1;1]*x(1), [y*1.05, y*1.1], '-k', 'LineWidth', 1); % significance vertical line
plot([1;1]*x(2), [y*1.05, y*1.1], '-k', 'LineWidth', 1); % significance vertical line

hold off
end



