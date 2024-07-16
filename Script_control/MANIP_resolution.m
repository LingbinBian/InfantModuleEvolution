% MANIP Number of communities vs modularity resolution
% Age range 0-5,3-8,6-11,9-14,12-17,15-23,18-29,24-36
%
%
% Version 1.0
% 20-Sep-2023
% Copyright (c) 2023, Lingbin Bian

clear
clc
close all

positive=1; % 1: positive connectivity, 0: full connectivity
N_roi=100; % Modularity parameters : roi=100:1.5,roi=200:1.5,roi=300:1.5,roi=400:1.25
scan=1;
if scan==1
    scan_dir='AP';
    load('subj_info_ap.mat');
else
    scan_dir='PA';
    load('subj_info_pa.mat');
end

N_subj=length(subj_info);
adj_group=cell(N_subj,9);
age_group=cell(N_subj,9);
id_group=cell(N_subj,9);
label=cell(N_subj,9);

count=ones(1,9);

for i=1:N_subj
    if subj_info{i,2}==0.5
        month='0_5';
    else
        month=num2str(subj_info{i,2});
    end
    if positive==1
        load(['/home/lingbin/Documents/work/pythonProject/BCP_fMRI/data/',num2str(N_roi),'FC_1_',scan_dir,'/',subj_info{i,4},'BCP',subj_info{i,1},'_',month,'mo_',scan_dir,'.mat'])
    else
        load(['/home/lingbin/Documents/work/pythonProject/BCP_fMRI/data/',num2str(N_roi),'FC_',scan_dir,'/',subj_info{i,4},'BCP',subj_info{i,1},'_',month,'mo_',scan_dir,'.mat'])
    end
    if subj_info{i,2}<=5
        adj_group{count(1,1),1}=FC;
        age_group{count(1,1),1}=subj_info{i,2};
        id_group{count(1,1),1}=subj_info{i,1};
        count(1,1)=count(1,1)+1;
    end
       
    if 3<=subj_info{i,2}&&subj_info{i,2}<=8
        adj_group{count(1,2),2}=FC;
        age_group{count(1,2),2}=subj_info{i,2};
        id_group{count(1,2),2}=subj_info{i,1};
        count(1,2)=count(1,2)+1;
    end
      
    if 6<=subj_info{i,2}&&subj_info{i,2}<=11
        adj_group{count(1,3),3}=FC;
        age_group{count(1,3),3}=subj_info{i,2};
        id_group{count(1,3),3}=subj_info{i,1};
        count(1,3)=count(1,3)+1;
    end
   
    if 9<=subj_info{i,2}&&subj_info{i,2}<=14 
        adj_group{count(1,4),4}=FC;
        age_group{count(1,4),4}=subj_info{i,2};
        id_group{count(1,4),4}=subj_info{i,1};
        count(1,4)=count(1,4)+1;
    end
      
    if 12<=subj_info{i,2}&&subj_info{i,2}<=17       
        adj_group{count(1,5),5}=FC;
        age_group{count(1,5),5}=subj_info{i,2};
        id_group{count(1,5),5}=subj_info{i,1};
        count(1,5)=count(1,5)+1;
    end
     
    if 15<=subj_info{i,2}&&subj_info{i,2}<=23   
        adj_group{count(1,6),6}=FC;
        age_group{count(1,6),6}=subj_info{i,2};
        id_group{count(1,6),6}=subj_info{i,1};
        count(1,6)=count(1,6)+1;
    end
       
    if 18<=subj_info{i,2}&&subj_info{i,2}<=29     
        adj_group{count(1,7),7}=FC;
        age_group{count(1,7),7}=subj_info{i,2};
        id_group{count(1,7),7}=subj_info{i,1};
        count(1,7)=count(1,7)+1;
    end
      
    if 24<=subj_info{i,2}&&subj_info{i,2}<=36      
        adj_group{count(1,8),8}=FC;
        age_group{count(1,8),8}=subj_info{i,2};
        id_group{count(1,8),8}=subj_info{i,1};
        count(1,8)=count(1,8)+1;
    end
   
    if subj_info{i,2}>36
        adj_group{count(1,9),9}=FC;
        age_group{count(1,9),9}=subj_info{i,2};
        id_group{count(1,9),9}=subj_info{i,1};
        count(1,9)=count(1,9)+1;
    end
     
end

count_subj=count-ones(1,9);

% individual modularity
for j=1:9
    fprintf('State: %d\n',j)
    
    for i=1:count_subj(1,j)
        fprintf('Subject: %d\n',i)
        [label{i,j}] =modularity_und(adj_group{i,j},1.8);
    end
end

% Label switching
group_labels=zeros(N_roi,N_subj);
c=1;
for j=1:9    
    for i=1:count_subj(1,j)
       group_labels(:,c)=label{i,j};   
       c=c+1;
    end
end
fprintf('Label switching ...')
group_labels=labelswitch(group_labels);
fprintf('Label switching ends')
c=1;
for j=1:9
    for i=1:count_subj(1,j)
       label{i,j}=group_labels(:,c); 
       c=c+1;
    end
end


% -------------------------------------------------------------------------
% Group-level modelling
N_window=length(count_subj);   % number of ege window

R_esti=cell(1,N_window);   % label assignment probability
R_esti_max=cell(1,N_window); % maximum label assignment probability
label_group_esti=zeros(N_roi,N_window); % labels of max

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
group_labels=labelswitch(label_group_esti);
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






