% MANIP Group-level modelling
% Hierarchical Bayesian modelling
%
% Version 1.0
% 7-July-2023
% Copyright (c) 2023, Lingbin Bian

clear
clc
close all
% -------------------------------------------------------------------------

positive=1;  % 1: positive connectivity, 0: full connectivity
% N_roi=100;  % number of ROI
% gender=2 ;
for N_roi=100:100:400
    for gender=1:2
        for scan=1:2   % 1: AP, 2: PA
            fprintf('Scan: %d\n',scan)
            for resolution=0.9:0.1:2.5   % modularity resolution
                fprintf('Resolution: %d\n',resolution)
                group_modual(scan,positive,N_roi,resolution,gender);
                close all
            end
        end
    end
end
% -------------------------------------------------------------------------
% nested function
function group_modual(scan,positive,N_roi,resolution,gender)
    switch gender
        case 0
            result_dir='results';
        case 1
            result_dir='results_F';
        otherwise
            result_dir='results_M';
    end

    if positive==1
        if scan==1
            scan_dir='AP';
            load(['../',result_dir,'/','roi_',num2str(N_roi),'_1_',scan_dir,'/',num2str(resolution),'/grouplevel_data_AP.mat']);
        else
            scan_dir='PA';
            load(['../',result_dir,'/','roi_',num2str(N_roi),'_1_',scan_dir,'/',num2str(resolution),'/grouplevel_data_PA.mat']);
        end
    else
        if scan==1
            scan_dir='AP';
            load(['../',result_dir,'/','roi_',num2str(N_roi),'_',scan_dir,'/',num2str(resolution),'/grouplevel_data_AP.mat']);
        else
            scan_dir='PA';
            load(['../',result_dir,'/','roi_',num2str(N_roi),'_',scan_dir,'/',num2str(resolution),'/grouplevel_data_PA.mat']);
        end
    end
    
    
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
       R_esti_max{s}(:,all(R_esti_max{s}==0,1))=[];
    end
    
    
    
    for s=1:N_window
        [N_roi,K_assign]=size(R_esti_max{s});
        for j=1:K_assign   
          for i=1:N_roi
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
            saveas(gcf,['../',result_dir,'/','roi_',num2str(N_roi),'_1_',scan_dir,'/',num2str(resolution),'/R_esti_age_',window,'.fig'])
        else
            saveas(gcf,['../',result_dir,'/','roi_',num2str(N_roi),'_',scan_dir,'/',num2str(resolution),'/R_esti_age_',window,'.fig'])
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
           saveas(gcf,['../',result_dir,'/','roi_',num2str(N_roi),'_1_',scan_dir,'/',num2str(resolution),'/R_estimax_age_',window,'.fig'])
       else
           saveas(gcf,['../',result_dir,'/','roi_',num2str(N_roi),'_',scan_dir,'/',num2str(resolution),'/R_estimax_age_',window,'.fig'])
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
        saveas(gcf,['../',result_dir,'/','roi_',num2str(N_roi),'_1_',scan_dir,'/',num2str(resolution),'/label_group_esti.fig'])
    else
        saveas(gcf,['../',result_dir,'/','roi_',num2str(N_roi),'_',scan_dir,'/',num2str(resolution),'/label_group_esti.fig'])
    end
    
    
    data_path = fileparts(mfilename('fullpath'));
    if positive==1
        group_results_path=fullfile(data_path,['../',result_dir,'/','roi_',num2str(N_roi),'_1_',scan_dir,'/',num2str(resolution),'/grouplevel_results_',scan_dir]);
        save(group_results_path,'R_esti','R_esti_max','label_group_esti'); 
    else
        group_results_path=fullfile(data_path,['../',result_dir,'/','roi_',num2str(N_roi),'_',scan_dir,'/',num2str(resolution),'/grouplevel_results_',scan_dir]);
        save(group_results_path,'R_esti','R_esti_max','label_group_esti'); 
    end
end
   














