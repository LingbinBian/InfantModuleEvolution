% MANIP Read MRI .csv file for age and gender

% Version 1.0
% 25-Jun-2023
% Copyright (c) 2023, Lingbin Bian

clear
clc
close all

scan=1;  % ap:1, pa:2

filename_MRI='/home/lingbin/Documents/work/pythonProject/BCP_fMRI/psychometrics/table/image03.csv';  % read MRI imaging table
MRI_table=readtable(filename_MRI);
MRI_info=table2cell(MRI_table);
[N_MRI_info,L_MRI_info]=size(MRI_info);   % N_MRI_info: the number of scans in the MRI imaging table

if scan==1
    filename_id='/home/lingbin/Documents/work/pythonProject/BCP_fMRI/Script_control/subj_id_ap.txt';    % subjects of ap
else
    filename_id='/home/lingbin/Documents/work/pythonProject/BCP_fMRI/Script_control/subj_id_pa.txt';    % subjects of pa
end

subj_idtable=readtable(filename_id);
subj_id=table2cell(subj_idtable);
[N,L]=size(subj_id);     % N: number of subjects

subj_info=cell(N,4);    % 1: subject ID, 2: age, 3: gender, 4: site

for i=1:N
    subj_info{i,1}=subj_id{i,1}(6:end);
    subj_info{i,2}=str2num(subj_id{i,2}(1:end-2));
    for j=1:N_MRI_info
        if str2num(subj_info{i,1})==MRI_info{j,5}
            subj_info{i,3}=MRI_info{j,8};
        end
    end
    subj_info{i,4}=subj_id{i,1}(1:2);

end

if scan==1
    save_path=fullfile('../Script_control/subj_info_ap');
    save(save_path,'subj_info');
else
    save_path=fullfile('../Script_control/subj_info_pa');
    save(save_path,'subj_info');
end

