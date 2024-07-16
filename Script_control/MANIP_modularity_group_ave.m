% MANIP Modularity using group averaged FC

%
% Version 1.0
% 29-Sep-2023
% Copyright (c) 2023, Lingbin Bian

clear
clc
close all

positive=0; % 1: positive connectivity, 0: full connectivity
%N_roi=400; % number of ROI
gender=1;
for N_roi=100:100:400
    fprintf('Number of ROI: %d\n',N_roi)
    for scan=1:2
        fprintf('Scan: %d\n',scan)
        for resolution =0.9:0.1:2.5
            fprintf('Resolution: %d\n',resolution)
            modularity_average(positive,N_roi,scan,resolution,gender);
        end
    end
end

% -------------------------------------------------------------------------
% nested function
function modularity_average(positive,N_roi,scan,resolution,gender)
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
        switch gender
            case 0
                data_dir='data';
            case 1
                data_dir='data_F';
            otherwise
                data_dir='data_M';
        end

        if positive==1
            load(['/home/lingbin/Documents/work/pythonProject/BCP_fMRI/',data_dir,'/',num2str(N_roi),'FC_1_',scan_dir,'/',subj_info{i,4},'BCP',subj_info{i,1},'_',month,'mo_',scan_dir,'.mat'])
        else
            load(['/home/lingbin/Documents/work/pythonProject/BCP_fMRI/',data_dir,'/',num2str(N_roi),'FC_',scan_dir,'/',subj_info{i,4},'BCP',subj_info{i,1},'_',month,'mo_',scan_dir,'.mat'])
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
    count_subj=count-ones(1,9);  % an array of numbers of subjects
    
    ave_adj=cell(1,9); % averaged adjacency matrix
    
    for l=1:9
        for i=1:N_roi
            for j=1:N_roi
                adj_mean=zeros(count_subj(1,l),1);
                for s=1:count_subj(1,l)
                    adj_mean(s,1)=adj_group{s,l}(i,j);
                end
                ave_adj{1,l}(i,j)=mean(adj_mean);
                adj_mean=zeros(count_subj(1,l),1);
            end
        end
        ave_adj{1,l}(ave_adj{1,l}<0)=0;  % remove negative
    end
    
    labels_ave=zeros(N_roi,9);
    % modularity using averaged FC
    for l=1:9
        fprintf('State: %d\n',l)
        labels_ave(:,l)=modularity_und(ave_adj{1,l},resolution);
        
    end
    
    labels_ave=labelswitch(labels_ave);
    
    switch gender
        case 0
            results_dir='results';
        case 1
            results_dir='results_F';
        otherwise
            results_dir='results_M';
    end
    data_path = fileparts(mfilename('fullpath'));
    
    group_results_path=fullfile(data_path,['../',results_dir,'/','roi_',num2str(N_roi),'_1_',scan_dir,'/',num2str(resolution),'/labels_ave_results_',scan_dir]);
    save(group_results_path,'labels_ave'); 
end






