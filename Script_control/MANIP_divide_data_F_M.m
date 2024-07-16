% MANIP Datasets of female (F) and male (M)
% 
% 
% Version 1.0
% 7-November-2023
% Copyright (c) 2023, Lingbin Bian

clear
clc
close all

N_roi=400; % number of ROI
scan=2;  % 1: AP, 2:PA

if scan==1
    scan_dir='AP';
    load('subj_info_ap.mat');
else
    scan_dir='PA';
    load('subj_info_pa.mat');
end

N_scan=length(subj_info);

for i=1:N_scan
    if subj_info{i,2}==0.5
        month='0_5';
    else
        month=num2str(subj_info{i,2});
    end
    if subj_info{i,3}=='F'
        copyfile(['/home/lingbin/Documents/work/pythonProject/BCP_fMRI/data/',num2str(N_roi),'FC_',scan_dir,'/',subj_info{i,4},'BCP',subj_info{i,1},'_',month,'mo','_',scan_dir,'.mat'], ...
            ['/home/lingbin/Documents/work/pythonProject/BCP_fMRI/data_F/',num2str(N_roi),'FC_',scan_dir])
    elseif subj_info{i,3}=='M'
        copyfile(['/home/lingbin/Documents/work/pythonProject/BCP_fMRI/data/',num2str(N_roi),'FC_',scan_dir,'/',subj_info{i,4},'BCP',subj_info{i,1},'_',month,'mo','_',scan_dir,'.mat'], ...
            ['/home/lingbin/Documents/work/pythonProject/BCP_fMRI/data_M/',num2str(N_roi),'FC_',scan_dir])  
    end
end












