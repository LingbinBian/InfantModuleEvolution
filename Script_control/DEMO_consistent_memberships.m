% DEMO Visualize the consistent community memberships for both AP and PA
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
% gender=1;
for gender=1:2
    for N_roi=100:100:400
        for resolution=0.9:0.1:2.5
            label_consist(positive,N_roi,resolution,gender);
            close all
        end
    end
end

function label_consist(positive,N_roi,resolution,gender)
    labels=zeros(N_roi,18);
    switch gender
        case 0
            result_dir='results';
        case 1
            result_dir='results_F';
        otherwise
            result_dir='results_M';
    end
    
    
    if positive==1
        load(['../',result_dir,'/','roi_',num2str(N_roi),'_1_','AP','/',num2str(resolution),'/grouplevel_results_AP.mat']);  
    else
        load(['../',result_dir,'/','roi_',num2str(N_roi),'_','AP','/',num2str(resolution),'/grouplevel_results_AP.mat']);   
    end
    
    labels(:,1:9)=label_group_esti;
    
    if positive==1
        load(['../',result_dir,'/','roi_',num2str(N_roi),'_1_','PA','/',num2str(resolution),'/grouplevel_results_PA.mat']);  
    else
        load(['../',result_dir,'/','roi_',num2str(N_roi),'_','PA','/',num2str(resolution),'/grouplevel_results_PA.mat']);   
    end
    
    labels(:,10:18)=label_group_esti;
    group_labels=labelswitch(labels);
    label_AP=group_labels(:,1:9);
    label_PA=group_labels(:,10:18);
    
    % Visualize latent label vector
    K_esti_AP=max(group_labels);
    N_window=9;
    figure  
    for t=1:N_window
        subplot(1,N_window,t)
        visual_labels(label_AP(:,t),K_esti_AP)
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
        visual_labels(label_PA(:,t),K_esti_PA)
        title('Estimation','fontsize',16)
    end
    set(gcf,'unit','normalized','position',[0.5,0.2,0.8,0.28]);
    data_path = fileparts(mfilename('fullpath'));
    
    
    if positive==1
        group_results_path=fullfile(data_path,['../',result_dir,'/','roi_',num2str(N_roi),'_1_','AP','/',num2str(resolution),'/labels_AP']);
        save(group_results_path,'label_AP'); 
        group_results_path=fullfile(data_path,['../',result_dir,'/','roi_',num2str(N_roi),'_1_','PA','/',num2str(resolution),'/labels_PA']);
        save(group_results_path,'label_PA'); 
    else
        group_results_path=fullfile(data_path,['../',result_dir,'/','roi_',num2str(N_roi),'_','AP','/',num2str(resolution),'/labels_AP']);
        save(group_results_path,'label_AP'); 
        group_results_path=fullfile(data_path,['../',result_dir,'/','roi_',num2str(N_roi),'_','PA','/',num2str(resolution),'/labels_PA']);
        save(group_results_path,'label_PA'); 
    end

end






