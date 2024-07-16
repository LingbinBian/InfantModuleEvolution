% This script saves all the pictures in a single destination file

% Version 1.0
% 20-Oct-2023
% Copyright (c) 2023, Lingbin Bian

clear
clc
close all

% destination file
pic_path='../figures_paper';
  
% save test sampling parameters
cd '../figures';
open('roi_100_AP_statistical_analysis_modular_evolution.fig')
saveas(gcf,[pic_path,'/roi_100_AP_statistical_analysis_modular_evolution.png'])
open('roi_100_PA_statistical_analysis_modular_evolution.fig')
saveas(gcf,[pic_path,'/roi_100_PA_statistical_analysis_modular_evolution.png'])

open('roi_100_AP_statistical_analysis_gender.fig')
saveas(gcf,[pic_path,'/roi_100_AP_statistical_analysis_gender.png'])
open('roi_100_PA_statistical_analysis_gender.fig')
saveas(gcf,[pic_path,'/roi_100_PA_statistical_analysis_gender.png'])

open('roi_100_AP_statistical_analysis_awake_sleep.fig')
saveas(gcf,[pic_path,'/roi_100_AP_statistical_analysis_awake_sleep.png'])
open('roi_100_PA_statistical_analysis_awake_sleep.fig')
saveas(gcf,[pic_path,'/roi_100_PA_statistical_analysis_awake_sleep.png'])

open('roi_200_AP_statistical_analysis_modular_evolution.fig')
saveas(gcf,[pic_path,'/roi_200_AP_statistical_analysis_modular_evolution.png'])
open('roi_200_PA_statistical_analysis_modular_evolution.fig')
saveas(gcf,[pic_path,'/roi_200_PA_statistical_analysis_modular_evolution.png'])

open('roi_200_AP_statistical_analysis_gender.fig')
saveas(gcf,[pic_path,'/roi_200_AP_statistical_analysis_gender.png'])
open('roi_200_PA_statistical_analysis_gender.fig')
saveas(gcf,[pic_path,'/roi_200_PA_statistical_analysis_gender.png'])

open('roi_200_AP_statistical_analysis_awake_sleep.fig')
saveas(gcf,[pic_path,'/roi_200_AP_statistical_analysis_awake_sleep.png'])
open('roi_200_PA_statistical_analysis_awake_sleep.fig')
saveas(gcf,[pic_path,'/roi_200_PA_statistical_analysis_awake_sleep.png'])

open('roi_300_AP_statistical_analysis_modular_evolution.fig')
saveas(gcf,[pic_path,'/roi_300_AP_statistical_analysis_modular_evolution.png'])
open('roi_300_PA_statistical_analysis_modular_evolution.fig')
saveas(gcf,[pic_path,'/roi_300_PA_statistical_analysis_modular_evolution.png'])


open('roi_300_AP_statistical_analysis_gender.fig')
saveas(gcf,[pic_path,'/roi_300_AP_statistical_analysis_gender.png'])
open('roi_300_PA_statistical_analysis_gender.fig')
saveas(gcf,[pic_path,'/roi_300_PA_statistical_analysis_gender.png'])

open('roi_300_AP_statistical_analysis_awake_sleep.fig')
saveas(gcf,[pic_path,'/roi_300_AP_statistical_analysis_awake_sleep.png'])
open('roi_300_PA_statistical_analysis_awake_sleep.fig')
saveas(gcf,[pic_path,'/roi_300_PA_statistical_analysis_awake_sleep.png'])
open('roi_300_AP_statistical_analysis_modular_evolution.fig')


open('roi_400_AP_statistical_analysis_modular_evolution.fig')
saveas(gcf,[pic_path,'/roi_400_AP_statistical_analysis_modular_evolution.png'])
open('roi_400_PA_statistical_analysis_modular_evolution.fig')
saveas(gcf,[pic_path,'/roi_400_PA_statistical_analysis_modular_evolution.png'])

open('roi_400_AP_statistical_analysis_gender.fig')
saveas(gcf,[pic_path,'/roi_400_AP_statistical_analysis_gender.png'])
open('roi_400_PA_statistical_analysis_gender.fig')
saveas(gcf,[pic_path,'/roi_400_PA_statistical_analysis_gender.png'])

open('roi_400_AP_statistical_analysis_awake_sleep.fig')
saveas(gcf,[pic_path,'/roi_400_AP_statistical_analysis_awake_sleep.png'])
open('roi_400_PA_statistical_analysis_awake_sleep.fig')
saveas(gcf,[pic_path,'/roi_400_PA_statistical_analysis_awake_sleep.png'])


cd ..

close all










