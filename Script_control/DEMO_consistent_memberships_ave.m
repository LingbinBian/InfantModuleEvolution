% DEMO consistent community memberships of both AP and PA
%
% Version 1.0
% 13-Sep-2023
% Copyright (c) 2023, Lingbin Bian

clear
clc
close all

positive=1;
% N_roi=400;
% resolution=2.5;
% gender=0;
for gender=1:2
    for N_roi=100:100:400
        for resolution=0.9:0.1:2.5
             label_consist(positive,N_roi,resolution,gender);
             close all
        end
    end
end

% -------------------------------------------------------------------------
% nested function

function label_consist(positive,N_roi,resolution,gender)
    switch gender
        case 0
            results_dir='results';
        case 1
            results_dir='results_F';
        otherwise
            results_dir='results_M';
    end
    
    labels=zeros(N_roi,18);
    
    if positive==1
        load(['../',results_dir,'/','roi_',num2str(N_roi),'_1_','AP','/',num2str(resolution),'/labels_ave_results_AP.mat']);  
    else
        load(['../',results_dir,'/','roi_',num2str(N_roi),'_','AP','/',num2str(resolution),'/labels_ave_results_AP.mat']);   
    end
    
    labels(:,1:9)=labels_ave;
    
    if positive==1
        load(['../',results_dir,'/','roi_',num2str(N_roi),'_1_','PA','/',num2str(resolution),'/labels_ave_results_PA.mat']);  
    else
        load(['../',results_dir,'/','roi_',num2str(N_roi),'_','PA','/',num2str(resolution),'/labels_ave_results_PA.mat']);   
    end
    
    labels(:,10:18)=labels_ave;
    group_labels=labelswitch(labels);
    label_AP_ave=group_labels(:,1:9);
    label_PA_ave=group_labels(:,10:18);
    
    % Visualize latent label vector
    K_esti_AP=max(group_labels);
    N_window=9;
    figure  
    for t=1:N_window
        subplot(1,N_window,t)
        visual_labels(label_AP_ave(:,t),K_esti_AP)
        title('Estimation','fontsize',16)
    end
    set(gcf,'unit','normalized','position',[0.5,0.2,0.8,0.28]);
    % Visualize latent label vector
    K_esti_PA=max(group_labels);
    N_window=9;
    hold on
    figure  
    for t=1:N_window
        subplot(1,N_window,t)
        visual_labels(label_PA_ave(:,t),K_esti_PA)
        title('Estimation','fontsize',16)
    end
    set(gcf,'unit','normalized','position',[0.5,0.2,0.8,0.28]);
    data_path = fileparts(mfilename('fullpath'));
    
    if positive==1
        group_results_path=fullfile(data_path,['../',results_dir,'/','roi_',num2str(N_roi),'_1_','AP','/',num2str(resolution),'/labels_AP_ave']);
        save(group_results_path,'label_AP_ave'); 
        group_results_path=fullfile(data_path,['../',results_dir,'/','roi_',num2str(N_roi),'_1_','PA','/',num2str(resolution),'/labels_PA_ave']);
        save(group_results_path,'label_PA_ave'); 
    else
        group_results_path=fullfile(data_path,['../',results_dir,'/','roi_',num2str(N_roi),'_','AP','/',num2str(resolution),'/labels_AP_ave']);
        save(group_results_path,'label_AP_ave'); 
        group_results_path=fullfile(data_path,['../',results_dir,'/','roi_',num2str(N_roi),'_','PA','/',num2str(resolution),'/labels_PA_ave']);
        save(group_results_path,'label_PA_ave'); 
    end
end







