function [colormap_type] = color_type(v)
% Colormap
% v: a vector of labels

color_1=[0.69,0.19,0.38];
color_2=[1.00,0.89,0.52];
color_3=[0.25,0.41,0.88];
color_4=[0.63,0.32,0.18];
color_5=[0.92,0.56,0.33];
color_6=[0.50,0.54,0.53];
color_7=[0.53,0.81,0.92];
color_8=[0.63,0.40,0.83];
color_9=[0.74,0.56,0.56];
color_10=[1.00,0.50,0.31];
color_11=[0.13,0.55,0.13];
color_12=[0.61,0.4,0.12];
color_13=[0.75,0.75,0.75];
color_14=[0.89,0.09,0.05];
color_15=[1,0.5,0.31]; % 珊瑚色
color_16=[0.89,0.81,0.34]; %香蕉色
color_17=[0.51,0.21,0.06];
color_18=[0.01,0.66,0.62];
color_19=[0.1,0.1,0.44]; %深蓝色
color_20=[0.5,1,0]; %黄绿色
color_21=[1,0,0];%红色
color_22=[0.61,0.4,0.12]; %砖红
color_23=[0.69,0.09,0.12];%印度红
color_24=[1,0.75,0.8];%粉红
color_25=[0.53,0.15,0.34];%草莓色

color_map_RGB=[color_1;color_2;color_3;color_4;color_5;color_6;color_7;color_8;color_9;color_10;color_11;color_12;color_13;color_14;color_15;color_16;color_17;color_18;color_19;color_20;color_21;color_22;color_23;color_24;color_25];
colormap_type=color_map_RGB(unique(v),:);

end

