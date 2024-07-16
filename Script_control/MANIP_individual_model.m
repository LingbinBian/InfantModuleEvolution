% MANIP Individual modularity
% Age range 0-5,3-8,6-11,9-14,12-17,15-23,18-29,24-36,>36
% Parameters:  scan, positive, N_roi, resolution
%
% Version 1.0
% 6-July-2023
% Copyright (c) 2023, Lingbin Bian

clear
clc
close all
% -------------------------------------------------------------------------
% scan=1; % 1: AP, 2: PA
positive=1; % 1: positive connectivity, 0: full connectivity
%N_roi=400; % number of ROIs
gender=0;
% -------------------------------------------------------------------------

for N_roi=100:100:400
    %for gender=1:2
        for scan=1:2
            for resolution=0.9:0.1:2.5  % modularity parameters
               % resolution=1.5; % modularity parameters
                fprintf('Resolution: %d\n',resolution)
                individual(scan,positive,N_roi,resolution,gender);
            end
        end
    %end
end

% -------------------------------------------------------------------------
% nested function
function individual(scan,positive,N_roi,resolution,gender)
    switch gender
        case 0
            if scan==1
                scan_dir='AP';
                load('subj_info_ap.mat');
            else
                scan_dir='PA';
                load('subj_info_pa.mat');
            end
        case 1
            if scan==1
                scan_dir='AP';
                load('subj_info_ap_F.mat');
                subj_info=subj_info_ap_F;
            else
                scan_dir='PA';
                load('subj_info_pa_F.mat');
                subj_info=subj_info_pa_F;
            end
        otherwise
            if scan==1
                scan_dir='AP';
                load('subj_info_ap_M.mat');
                subj_info=subj_info_ap_M;
            else
                scan_dir='PA';
                load('subj_info_pa_M.mat');
                subj_info=subj_info_pa_M;
            end
    end
    
    N_subj=length(subj_info); % number of all scans
    adj_group=cell(N_subj,9);
    age_group=cell(N_subj,9);
    id_group=cell(N_subj,9);
    label=cell(N_subj,9);
    modularity_Q=cell(N_subj,9);
    
    count=ones(1,9);
    
    for i=1:N_subj
        if subj_info{i,2}==0.5
            month='0_5';
        else
            month=num2str(subj_info{i,2});
        end
        switch gender
            case 0
                if positive==1
                    load(['/home/lingbin/Documents/work/pythonProject/BCP_fMRI/data/',num2str(N_roi),'FC_1_',scan_dir,'/',subj_info{i,4},'BCP',subj_info{i,1},'_',month,'mo_',scan_dir,'.mat'])
                else
                    load(['/home/lingbin/Documents/work/pythonProject/BCP_fMRI/data/',num2str(N_roi),'FC_',scan_dir,'/',subj_info{i,4},'BCP',subj_info{i,1},'_',month,'mo_',scan_dir,'.mat'])
                end
            case 1
                if positive==1
                    load(['/home/lingbin/Documents/work/pythonProject/BCP_fMRI/data_F/',num2str(N_roi),'FC_1_',scan_dir,'/',subj_info{i,4},'BCP',subj_info{i,1},'_',month,'mo_',scan_dir,'.mat'])
                else
                    load(['/home/lingbin/Documents/work/pythonProject/BCP_fMRI/data_F/',num2str(N_roi),'FC_',scan_dir,'/',subj_info{i,4},'BCP',subj_info{i,1},'_',month,'mo_',scan_dir,'.mat'])
                end
            otherwise
                if positive==1
                    load(['/home/lingbin/Documents/work/pythonProject/BCP_fMRI/data_M/',num2str(N_roi),'FC_1_',scan_dir,'/',subj_info{i,4},'BCP',subj_info{i,1},'_',month,'mo_',scan_dir,'.mat'])
                else
                    load(['/home/lingbin/Documents/work/pythonProject/BCP_fMRI/data_M/',num2str(N_roi),'FC_',scan_dir,'/',subj_info{i,4},'BCP',subj_info{i,1},'_',month,'mo_',scan_dir,'.mat'])
                end
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
            
            [label{i,j},modularity_Q{i,j}] =modularity_und(adj_group{i,j},resolution);
        end
    end
    
    % label switching
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
    fprintf('Label switching ends\n')
    c=1;
    for j=1:9
        for i=1:count_subj(1,j)
           label{i,j}=group_labels(:,c); 
           c=c+1;
        end
    end
    
    % Save the results of individual-level modelling
    
    data_path = fileparts(mfilename('fullpath'));
    switch gender
        case 0
            if positive==1
                group_path=fullfile(data_path,['../results/','roi_',num2str(N_roi),'_1_',scan_dir,'/',num2str(resolution),'/grouplevel_data_',scan_dir]);
            else
                group_path=fullfile(data_path,['../results/','roi_',num2str(N_roi),'_',scan_dir,'/',num2str(resolution),'/grouplevel_data_',scan_dir]);
            end
        case 1
            if positive==1
                group_path=fullfile(data_path,['../results_F/','roi_',num2str(N_roi),'_1_',scan_dir,'/',num2str(resolution),'/grouplevel_data_',scan_dir]);
            else
                group_path=fullfile(data_path,['../results_F/','roi_',num2str(N_roi),'_',scan_dir,'/',num2str(resolution),'/grouplevel_data_',scan_dir]);
            end
        otherwise
            if positive==1
                group_path=fullfile(data_path,['../results_M/','roi_',num2str(N_roi),'_1_',scan_dir,'/',num2str(resolution),'/grouplevel_data_',scan_dir]);
            else
                group_path=fullfile(data_path,['../results_M/','roi_',num2str(N_roi),'_',scan_dir,'/',num2str(resolution),'/grouplevel_data_',scan_dir]);
            end
    end
    
    save(group_path);


end





