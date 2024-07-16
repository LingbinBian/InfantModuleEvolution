% MANIP convert .txt to .mat (fMRI signals)
% Version 1.0
% 24-Jun-2023
%
% Copyright (c) 2023, Lingbin Bian

clear
clc
close all

N_roi=100;
scan='AP';

switch scan
    case 'AP'
        subjects=readtable('subj_id_ap.txt');
    case 'PA'
        subjects=readtable('subj_id_pa.txt');
end

subjects=table2cell(subjects);

L_subjects=length(subjects);

for i=1:L_subjects

    fprintf('subject id = %s\n',subjects{i});
   
    read_fmri_signal(N_roi,scan,[subjects{i,1},'_',subjects{i,2},'_',subjects{i,3},'_',subjects{i,4}]);    
end

% Nested function ---------------------------------------------------------

function [list]=read_fmri_signal(N_roi,scan,subjects)

list=dir(['../data/Schaefer_',num2str(N_roi),'Parcels_7Networks_',scan,'/',subjects]);

L_list=length(list);
    for i=1:L_list  
        load(['../data/Schaefer_',num2str(N_roi),'Parcels_7Networks_',scan,'/',list(i).name]);
        filename=['../data/',num2str(N_roi),'ROI_',scan,'/',list(i).name(1:end-4),'.mat'];
        
        vari_name=list(i).name(1:end-4);
      
        if vari_name(14)=='.'
            vari_name(14)='_';
        end
        save(filename,vari_name);
    end

end






