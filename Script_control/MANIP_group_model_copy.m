% Hierarchical Bayesian modelling
% Group-level modelling
%
% Version 1.0
% 7-July-2023
% Copyright (c) 2023, Lingbin Bian

clear
clc
close all

positive=1;  % 1: positive connectivity, 0: full connectivity
N_roi=300;  % number of ROI
scan=2;   % 1: AP, 2: PA
if positive==1
    if scan==1
        scan_dir='AP';
        load(['../results/','roi_',num2str(N_roi),'_1_',scan_dir,'/grouplevel_data_AP.mat']);
    else
        scan_dir='PA';
        load(['../results/','roi_',num2str(N_roi),'_1_',scan_dir,'/grouplevel_data_PA.mat']);
    end
else
    if scan==1
        scan_dir='AP';
        load(['../results/','roi_',num2str(N_roi),'_',scan_dir,'/grouplevel_data_AP.mat']);
    else
        scan_dir='PA';
        load(['../results/','roi_',num2str(N_roi),'_',scan_dir,'/grouplevel_data_PA.mat']);
    end
end



N_window=length(count_subj);   % number of ege window

R_esti=cell(1,N_window);   % label assignment probability 
R_esti_max=cell(1,N_window); % maximum label assignment probability
%R_second_max=cell(1,N_window); % second maximum label assignment probability
label_group_esti=zeros(N_roi,N_window); % labels of max
%label_group_sec=zeros(N_roi,N_window); % labels of second max
%cluster_labels=zeros(N_roi,N_window); % labels using clustering

K=max(max(group_labels)); % maximum K across subjects
N_simu=1000; % number of samples drawn from posterior

% Estimate assignment probability
for s=1:N_window
   
   fprintf('State: %d\n',s)
   mat_labels=zeros(N_roi,count_subj(1,s));
   for n=1:count_subj(1,s)  
        mat_labels(:,n)=label{n,s};    
   end
   R_esti{1,s}=assign_esti(mat_labels,K,N_simu);
   mat_labels=zeros(N_roi,count_subj(1,s));
end

% clustering label assignment probability matrix
% K_cluster=6;  % predefine number of clusters
% for s=1:N_window
%    cluster_labels(:,s)=clusterdata(R_esti{s}(:,1:4),K_cluster);
% end

% Maximum label assignment probability matrix
for s=1:N_window
   R_esti_max{s}=mat_maxrow(R_esti{s});
end

for s=1:N_window
    [N_roi,K_assign]=size(R_esti_max{s});
    for i=1:N_roi
      for j=1:K_assign
          if R_esti_max{s}(i,j)~=0  
             label_group_esti(i,s)=j;
          end
      end
    end
end

K_esti=max(label_group_esti);

% Second maximum label assignment probability matrix
% for s=1:N_window
%    R_second_max{s}=mat_secondrow(R_esti{s});
% end

% for s=1:N_window
%     [N_roi_sec,K_assign_sec]=size(R_second_max{s});
%     for i=1:N_roi_sec
%       for j=1:K_assign_sec
%           if R_second_max{s}(i,j)~=0  
%              label_group_sec(i,s)=j;
%           end
%       end
%     end
% end
% 
% K_esti_sec=max(label_group_sec);

% Visualize assignment probability

for s=1:N_window
    figure
    imagesc(R_esti{s})
    colormap(pink);
    colorbar
    if s==1
        window='0-5';    % Age range 0-5,3-8,6-11,9-14,12-17,15-23,18-29,24-36
    end
    if s==2
        window='3-8';
    end
    if s==3
        window='6-11';
    end
    if s==4
        window='9-14';
    end
    if s==5
        window='12-17';
    end
    if s==6
        window='15-23';
    end
    if s==7
        window='18-29';
    end
    if s==8
        window='24-36';
    end
    if s==9
        window='>36';
    end
    title(['Age window ',' ',window],'fontsize',16) 
    xlabel('k','fontsize',16) 
    ylabel('Node','fontsize',16)      
    set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
    set(gcf,'unit','normalized','position',[0.3,0.2,0.15,0.3]); 
    if positive==1
        saveas(gcf,['../results/','roi_',num2str(N_roi),'_1_',scan_dir,'/R_esti_age_',window,'.fig'])
    else
        saveas(gcf,['../results/','roi_',num2str(N_roi),'_',scan_dir,'/R_esti_age_',window,'.fig'])
    end

end

% Visualize assignment probability (Max)

for s=1:N_window
   figure
   imagesc(R_esti_max{s})
   colormap(pink);
   colorbar
   clim([0 0.8])
    if s==1
        window='0-5';    % Age range 0-5,3-8,6-11,9-14,12-17,15-23,18-29,24-36
    end
    if s==2
        window='3-8';
    end
    if s==3
        window='6-11';
    end
    if s==4
        window='9-14';
    end
    if s==5
        window='12-17';
    end
    if s==6
        window='15-23';
    end
    if s==7
        window='18-29';
    end
    if s==8
        window='24-36';
    end
    if s==9
        window='>36';
    end
   title(['Age window',' ',window],'fontsize',16) 
   xlabel('k','fontsize',16) 
   ylabel('Node','fontsize',16)    
   set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
   set(gcf,'unit','normalized','position',[0.3,0.2,0.15,0.3]);
   if positive==1
       saveas(gcf,['../results/','roi_',num2str(N_roi),'_1_',scan_dir,'/R_estimax_age_',window,'.fig'])
   else
       saveas(gcf,['../results/','roi_',num2str(N_roi),'_',scan_dir,'/R_estimax_age_',window,'.fig'])
   end
end

% Visualize latent label vector

figure  
for t=1:N_window
    subplot(1,N_window,t)
    visual_labels(label_group_esti(:,t),K_esti)
    title('Estimation','fontsize',16)
end
set(gcf,'unit','normalized','position',[0.5,0.2,0.8,0.28]);
if positive==1
    saveas(gcf,['../results/','roi_',num2str(N_roi),'_1_',scan_dir,'/label_group_esti.fig'])
else
    saveas(gcf,['../results/','roi_',num2str(N_roi),'_',scan_dir,'/label_group_esti.fig'])
end


data_path = fileparts(mfilename('fullpath'));
if positive==1
    group_results_path=fullfile(data_path,['../results/','roi_',num2str(N_roi),'_1_',scan_dir,'/grouplevel_results_',scan_dir]);
    save(group_results_path,'R_esti','R_esti_max','label_group_esti'); 
else
    group_results_path=fullfile(data_path,['../results/','roi_',num2str(N_roi),'_',scan_dir,'/grouplevel_results_',scan_dir]);
    save(group_results_path,'R_esti','R_esti_max','label_group_esti'); 
end


% Visualize second latent label vector

% figure  
% for t=1:N_window
%     subplot(1,N_window,t)
%     visual_labels(label_group_sec(:,t),K_esti_sec)
%     title('Estimation','fontsize',16)
% end
% set(gcf,'unit','normalized','position',[0.5,0.2,0.8,0.28]);
% saveas(gcf,['../results/','roi_',num2str(N_roi),'_',scan_dir,'/label_group_sec.fig'])

  
% Visualize cluster labels

% figure  
% for t=1:N_window
%     subplot(1,N_window,t)
%     visual_labels(cluster_labels(:,t),K_cluster)
%     title('Estimation','fontsize',16)
% end
% set(gcf,'unit','normalized','position',[0.5,0.2,0.8,0.28]);
% saveas(gcf,['../results/','roi_',num2str(N_roi),'_',scan_dir,'/cluster_labels.fig'])

%data_path = fileparts(mfilename('fullpath'));
%group_results_path=fullfile(data_path,['../results/','roi_',num2str(N_roi),'_',scan_dir,'/grouplevel_results_',scan_dir]);
%save(group_results_path,'R_esti','R_esti_max','R_second_max','label_group_esti','label_group_sec','cluster_labels');   












