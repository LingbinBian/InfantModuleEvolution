% Compare the development of modularity using
% Bayesian modelling and group averaging methods
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
corre_hier=zeros(N_res,N_window-2);  % correlation of community memberships of the neighbouring age groups using Bayesian method
corre_ave=zeros(N_res,N_window-2);  % correlation of community memberships of the neighbouring age groups using group averaging
resolution=0.9:0.1:2.5;
figure
colorvector=[1,1,0;0.78,0.38,0.08;0,0,1;1,0,0;0,1,0;0,0.5,0;0.5,0.5,0;1,0.5,0.5];

for i=1:N_res  % modularity resolution
    if positive==1
        load(['../results/','roi_',num2str(N_roi),'_1_','AP','/',num2str(resolution(i)),'/labels_AP.mat']);   
        load(['../results/','roi_',num2str(N_roi),'_1_','AP','/',num2str(resolution(i)),'/labels_AP_ave.mat']); 
        load(['../results/','roi_',num2str(N_roi),'_1_','PA','/',num2str(resolution(i)),'/labels_PA.mat']);   
        load(['../results/','roi_',num2str(N_roi),'_1_','PA','/',num2str(resolution(i)),'/labels_PA_ave.mat']); 
    end
     
    if scan==1
        for n=1:N_window-2
            corre_hier(i,n)=jaccardsimi(label_AP(:,n),label_AP(:,n+2));
            corre_ave(i,n)=jaccardsimi(label_AP_ave(:,n),label_AP_ave(:,n+2));
        end
    elseif scan==2
        for n=1:N_window-2
            corre_hier(i,n)=jaccardsimi(label_PA(:,n),label_PA(:,n+2));
            corre_ave(i,n)=jaccardsimi(label_PA_ave(:,n),label_PA_ave(:,n+2));
        end
    end
    
    %plot(1:(N_window-1),corre_hier,'r')
    plot(1:(N_window-2),corre_hier(i,:),'color',[1,0.87,0.68],...
                 'LineWidth',1);
  
    plot(1:(N_window-2),corre_ave(i,:),'color',[0.75,0.75,0.75],...
                 'LineWidth',1);
   
    hold on
    
    %set(gca,'xtick',0:20:T)
    
    
    % corre_hier_mean=mean(corre_hier); 0-5,3-8,6-11,9-14,12-17,15-23,18-29,24-36,>36
    % corre_ave_mean=mean(corre_ave);
end

corre_ave_mean=mean(corre_ave);
plot(1:(N_window-2),corre_ave_mean(1,:),'color',[0,0,0.],...
                 'LineWidth',2);

corre_hier_mean=mean(corre_hier);
plot(1:(N_window-2),corre_hier_mean(1,:),'color',[0.82,0.41,0.12],...
                 'LineWidth',2);

legend([plot(1:(N_window-2),corre_hier_mean(1,:),'color',[0.82,0.41,0.12],...
                 'LineWidth',2),plot(1:(N_window-2),corre_ave_mean(1,:),'color',[0,0,0.],...
                 'LineWidth',2)],'Bayesian Modelling','Group Averaging','Location','SouthEast')
set(gca,'xticklabel',{'0-5/\newline6-11', '3-8/\newline9-14', '6-11/\newline12-17','9-14/\newline15-23','12-17/\newline18-29','15-23/\newline24-36','18-29/\newline>36'},'FontSize',12);    
%set(gca,'xticklabel',{'0-5/6-11', '3-8/9-14', '6-11/12-17','9-14/15-23','12-17/18-29','15-23/24-36','18-29/>36'},'FontSize',12);
%set(gca,'xticklabel',{'0-5/6-11', '3-8/9-14', '6-11/12-17','9-14/15-23','12-17/18-29','15-23/24-36','18-29/>36'},'FontSize',12);

ylim([0,1.1]); % range of y
set(gca,'box','on')
%set(gca,'fontsize',16)
set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
if scan==1
    title(['AP',', ROI=',num2str(N_roi)],'fontsize', 16)
else
    title(['PA',', ROI=',num2str(N_roi)],'fontsize', 16)
end
xlabel('Month','fontsize',16)
%xtickangle(45);
ylabel('Jaccard similarity coefficient','fontsize',16)
%set(gcf,'unit','centimeters','position',[6 10 30 18])
%set(gcf,'unit','centimeters','position',[6 10 20 14])
%set(gca,'Position',[.15 .25 .75 .65]);

%set(gcf,'unit','centimeters','position',[6 10 30 18])
set(gcf,'unit','centimeters','position',[6 10 18 14])
set(gca,'Position',[.15 .28 .75 .6]);

data_path = fileparts(mfilename('fullpath'));

if scan==1
    results_path=fullfile(data_path,['../results/','roi_',num2str(N_roi),'_AP']);
    save(results_path,'corre_hier','corre_ave'); 
    saveas(gcf,['../figures/','roi_',num2str(N_roi),'_AP','_modular_evolution.fig'])
    saveas(gcf,['../figures_paper/','roi_',num2str(N_roi),'_AP','_modular_evolution.png'])
elseif scan==2
    results_path=fullfile(data_path,['../results/','roi_',num2str(N_roi),'_PA']);
    save(results_path,'corre_hier','corre_ave'); 
    saveas(gcf,['../figures/','roi_',num2str(N_roi),'_PA','_modular_evolution.fig'])
    saveas(gcf,['../figures_paper/','roi_',num2str(N_roi),'_PA','_modular_evolution.png'])
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


























