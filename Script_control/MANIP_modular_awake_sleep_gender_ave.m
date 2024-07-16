% Compare the development of modularity between male and female
% 
%
% Version 1.0
% 12-Oct-2023
% Copyright (c) 2023, Lingbin Bian

clear
clc
close all

scan=2; % 1: AP 2:PA
positive=1; % 1: positive connectivity, 0: full connectivity
N_roi=400; % number of ROIs
N_res=17;  % number of modularity resolutions
N_window=9;  % age window number
corre_female_ave=zeros(N_res,N_window-1);  % correlation of community memberships of the neighbouring age groups of female
corre_male_ave=zeros(N_res,N_window-1);  % correlation of community memberships of the neighbouring age groups of male
resolution=0.9:0.1:2.5;
figure
colorvector=[1,1,0;0.78,0.38,0.08;0,0,1;1,0,0;0,1,0;0,0.5,0;0.5,0.5,0;1,0.5,0.5];

for i=1:N_res  % modularity resolution
    if positive==1
  
        load(['../results_F/','roi_',num2str(N_roi),'_1_','AP','/',num2str(resolution(i)),'/labels_AP_ave.mat']);        
        load(['../results_F/','roi_',num2str(N_roi),'_1_','PA','/',num2str(resolution(i)),'/labels_PA_ave.mat']); 

        label_AP_F_ave=label_AP_ave;
        label_PA_F_ave=label_PA_ave;
  
        load(['../results_M/','roi_',num2str(N_roi),'_1_','AP','/',num2str(resolution(i)),'/labels_AP_ave.mat']); 
        load(['../results_M/','roi_',num2str(N_roi),'_1_','PA','/',num2str(resolution(i)),'/labels_PA_ave.mat']); 
   
        label_AP_M_ave=label_AP_ave;
        label_PA_M_ave=label_PA_ave;
    end
     
    if scan==1
        for n=1:N_window-1
        
            corre_female_ave(i,n)=jaccardsimi(label_AP_F_ave(:,n),label_AP_F_ave(:,N_window));
            corre_male_ave(i,n)=jaccardsimi(label_AP_M_ave(:,n),label_AP_M_ave(:,N_window));
        end
    elseif scan==2
        for n=1:N_window-1
         
            corre_female_ave(i,n)=jaccardsimi(label_PA_F_ave(:,n),label_PA_F_ave(:,N_window));
            corre_male_ave(i,n)=jaccardsimi(label_PA_M_ave(:,n),label_PA_M_ave(:,N_window));
        end
    end
    
    %plot(1:(N_window-1),corre_hier,'r')

    plot(1:(N_window-1),corre_female_ave(i,:),'color',[1,0.75,0.8],...
                 'LineWidth',1);
  
    plot(1:(N_window-1),corre_male_ave(i,:),'color',[0.53,0.81,0.92],...
                 'LineWidth',1);
   
    hold on
    
    %set(gca,'xtick',0:20:T)
    
    
    % corre_hier_mean=mean(corre_hier); 0-5,3-8,6-11,9-14,12-17,15-23,18-29,24-36,>36
    % corre_ave_mean=mean(corre_ave);
end

corre_female_ave_mean=mean(corre_female_ave);
plot(1:(N_window-1),corre_female_ave_mean(1,:),'color',[0.7,0.13,0.13],...
                 'LineWidth',2);

corre_male_ave_mean=mean(corre_male_ave);
plot(1:(N_window-1),corre_male_ave_mean(1,:),'color',[0.1,0.1,0.44],...
                 'LineWidth',2);



legend([plot(1:(N_window-1),corre_female_ave_mean(1,:),'color',[0.7,0.13,0.13],...
                 'LineWidth',2),plot(1:(N_window-1),corre_male_ave_mean(1,:),'color',[0.1,0.1,0.44],...
                 'LineWidth',2)],'Female','Male','Location','SouthEast')
%set(gca,'xticklabel',{'0-5 vs\newline 6-11', '3-8 vs\newline 9-14', '6-11 vs\newline 12-17','9-14 vs\newline 15-23','12-17 vs\newline 18-29','15-23 vs\newline 24-36','18-29 vs\newline >36'},'FontSize',12);    
set(gca,'xticklabel',{'0-5', '3-8', '6-11','9-14','12-17','15-23','18-29','24-36'},'FontSize',12);
ylim([0,1]); % range of y
set(gca,'box','on')
%set(gca,'fontsize',16)
set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
if scan==1
    title(['Modular similarity between sleeping and awake (','AP',', ROI=',num2str(N_roi),')'],'fontsize', 16)
else
    title(['Modular similarity between sleeping and awake (','PA',', ROI=',num2str(N_roi),')'],'fontsize', 16)
end
xlabel('Month','fontsize',16)
ylabel('Jaccard similarity coefficient','fontsize',16)
set(gcf,'unit','centimeters','position',[6 10 22 18])
set(gca,'Position',[.15 .15 .75 .75]);

data_path = fileparts(mfilename('fullpath'));


if scan==1
    results_path_F=fullfile(data_path,['../results_F/','roi_',num2str(N_roi),'_AP']);
    save(results_path_F,'corre_female_ave'); 
    results_path_M=fullfile(data_path,['../results_M/','roi_',num2str(N_roi),'_AP']);
    save(results_path_M,'corre_male_ave'); 

    saveas(gcf,['../figures/','roi_',num2str(N_roi),'_AP','_modularity_trend_gender_ave.fig'])
    saveas(gcf,['../figures_paper/','roi_',num2str(N_roi),'_AP','_modularity_trend_gender_ave.png'])
elseif scan==2
    results_path_F=fullfile(data_path,['../results_F/','roi_',num2str(N_roi),'_PA']);
    save(results_path_F,'corre_female_ave'); 
    results_path_M=fullfile(data_path,['../results_M/','roi_',num2str(N_roi),'_PA']);
    save(results_path_M,'corre_male_ave');
    saveas(gcf,['../figures/','roi_',num2str(N_roi),'_PA','_modularity_trend_gender_ave.fig'])
    saveas(gcf,['../figures_paper/','roi_',num2str(N_roi),'_PA','_modularity_trend_gender_ave.png'])
end

% -------------------------------------------------------------------------
% nested function

function [ratio_consis]=label_consis(a,b)
% evaluated the consistency between two categorical vectors
N=length(a);
consist=zeros(N,1);
for i=1:N
    if a(i)==b(i)
        consist(i)=1;
    else
        consist(i)=0;
    end
end

ratio_consis=sum(consist)/N;

end

function [jaccard_similarity]=jaccardsimi(a,b)
% Jaccard distance

% Calculate the intersection of the two sets
intersection = length(intersect(a,b));

% Calculate the union of the two sets
uni = length(union(a,b));

% Calculate Jaccard similarity
jaccard_similarity = intersection / uni;
end


























