Instructions on how to run the code
Version 1.0
25-July-2024
Copyright (c) 2024, Lingbin Bian

1. copy_ap_pa.sh   Copy the overall .txt ROI signals to ap.txt and pa.txt
2. MANIP_signal_txt2mat.m   Transfer the ROI signals of .txt files to .mat files
3. MANIP_read_MRI.m   Read MRI .csv file for age and gender
4. MANIP_roi2fc.m    Calculate functional connectivity

Comparing Bayesian modelling and group averaging methods

5. MANIP_individual_model.m   Perform individual modularity (scan:1,2; gender:0 for both female and male). After modularity, individual module labels are switched to make them consistent across subjects using a relabelling algorithm implemented by a MATLAB function: labelswitching.m
6. MANIP_group_model.m Perform   group-level analysis (scan:1,2; gender:0 for both female and male)
7. DEMO_consistent_memberships.m   Consistent community memberships for both AP and PA using Bayesian modelling (gender:0 for both female and male)
8. MANIP_modularity_group_ave.m   Modularity using group averaged FC (scan:1,2)
9. DEMO_consistent_memberships_ave.m   Consistent community memberships for both AP and PA using group averaging (gender:0 for both female and male)
10.DEMON_community_resolution.m   Number of communities versus resolution
11.MANIP_modular_compare.m   Compare the modular structures of the neighbouring age groups using Bayesian modelling and group averaging methods
12.DEMO_group_boxplot.m   Plot the boxplots of the modular similarity of the neighbouring age groups using Bayesian modelling and group averaging methods
13.MANIP_save_picture.m   Save the figures of experimental restuls

Comparing the development of modular between male and female

14.MANIP_divide_data_F_M.m Divide the whole dataset into the group of female and male (for both FC and positive FC)
15.MANIP_individual_model.m   Perform individual modularity (scan:1,2; gender:1 female; 2 male)
16.MANIP_group_model.m Perform   group-level analysis (scan:1,2; gender:1 female; 2 male)
17.DEMO_consistent_memberships.m   Consistent community memberships for both AP and PA using Bayesian modelling (gender:1 female; 2 male)
18.MANIP_modularity_group_ave.m   Modularity using group averaged FC (scan:1,2; gender:1 female; 2 male)
19.DEMO_consistent_memberships_ave.m   Consistent community memberships for both AP and PA using group averaging (gender:1 female; 2 male)
20.MANIP_modular_compare_gender.m   Compare the modular structures of the neighbouring age groups using Bayesian modelling and group averaging methods
21.MANIP_modular_compare_gender_ave.m   Compare the modular structures of the neighbouring age groups using Bayesian modelling and group averaging methods
