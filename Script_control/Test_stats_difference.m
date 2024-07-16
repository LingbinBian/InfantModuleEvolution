clear;
clc;
close all;
% 做T检验获取p值
data_1 = [0.1,0.2,0.3,0.4,0.5];
data_2 = [6,7,8,9,10];

[h,p,ci,stats] = vartest2(data_1,data_2);
if p < 0.05
    [h1,p1,ci1] = ttest2(data_1,data_2,'Vartype','unequal');
else
    [h1,p1,ci1] = ttest2(data_1,data_2);
end

% 对数据求均值和标准差
mean_1 = mean(data_1)
std_1 = std(data_1)
mean_2 = mean(data_2)
std_2 = std(data_2)

% 数据是m * n的矩阵，m对应的是一共有几组，n对应的是每堆有几个柱子
data_mean = [mean_1,mean_2]   %此时m=1,n=2
data_std = [std_1,std_2]

% 设置颜色
color =[255,238,111;145,213,66;188,212,231;187,161,203]/255;

% 绘制条形图
figure;
y = data_mean;
neg = data_std;
pos = data_std;
m = 1;
n = size(y,2);
x = 1;
h = bar(x,y,0.4);

% 单独设置条形图第i个组第j个柱子的颜色
for i = 1 : m
    for j = 1 : n
        h(1, j).FaceColor = 'flat';
        h(1, j).CData(i,:) = color(j,:);
        h(1,j).EdgeColor = 'flat';
    end
end

% 获取误差线 x 值
xx = zeros(m, n);
for i = 1 : n
    xx(:, i) = h(1, i).XEndPoints';
end

% 绘制误差线
hold on
errorbar(xx, y, neg, pos, 'LineStyle', 'none', 'Color', 'k', 'LineWidth', 1);

%绘制显著性差异
t1 = 1; %第1组
n1 = 1; %第1组的第n1个柱子
n2 = 2; %第1组的第n2个柱子
%获取显著性差异线的x坐标
x1 = xx(t1,n1); x2 = xx(t1,n2);
%获取显著性差异线的y坐标
ySig = max(y(t1,n1)+pos(t1,n1),y(t1,n2)+pos(t1,n2));
%绘制显著性差异
sigline([x1,x2],ySig, p1); % p1是上面T检验得到的p值


% 函数sigline
function sigline(x, y, p)
hold on
x = x';

if p<0.001
    plot(mean(x),       y*1.15, '*k')          % the sig star sign
    plot(mean(x)- 0.02, y*1.15, '*k')          % the sig star sign
    plot(mean(x)+ 0.02, y*1.15, '*k')          % the sig star sign

elseif (0.001<=p)&&(p<0.01)
    plot(mean(x)- 0.01, y*1.15, '*k')         % the sig star sign
    plot(mean(x)+ 0.01, y*1.15, '*k')         % the sig star sign

elseif (0.01<=p)&&(p<0.05)
    plot(mean(x), y*1.15, '*k')               % the sig star sign
else
    print('not significance');
end

plot(x, [1;1]*y*1.1, '-k', 'LineWidth',1); % 显著性的那条直线
plot([1;1]*x(1), [y*1.05, y*1.1], '-k', 'LineWidth', 1); % 显著性的那条直线的左方下直线
plot([1;1]*x(2), [y*1.05, y*1.1], '-k', 'LineWidth', 1); % 显著性的那条直线的右方下直线

hold off
end