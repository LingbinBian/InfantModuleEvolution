import matplotlib.pyplot as plt
import numpy as np
import matplotlib; matplotlib.use('TkAgg')
import seaborn as sns
import pandas as pd
import scipy.io as scio
from statannotations.Annotator import Annotator

sns.set(style="whitegrid")
x = "Type"
y = "Correlation coefficient"

N_res=17
N_roi=300


correc = scio.loadmat('/home/lingbin/Documents/work/pythonProject/BCP_fMRI/results/roi_' + str(N_roi) + '_AP.mat')

correlation_hier= correc['corre_hier']
correlation_ave= correc['corre_ave']

correlation_hier_1=correlation_hier[:, 0]
correlation_hier_1=correlation_hier_1.tolist()

correlation_ave_1=correlation_ave[:, 0]
correlation_ave_1=correlation_ave_1.tolist()

correlation_hier_2=correlation_hier[:, 1]
correlation_hier_2=correlation_hier_2.tolist()

correlation_ave_2=correlation_ave[:, 1]
correlation_ave_2=correlation_ave_2.tolist()

correlation_hier_3=correlation_hier[:, 2]
correlation_hier_3=correlation_hier_3.tolist()

correlation_ave_3=correlation_ave[:, 2]
correlation_ave_3=correlation_ave_3.tolist()
a=correlation_hier_1+correlation_ave_1+correlation_hier_2+correlation_ave_2+correlation_hier_3+correlation_ave_3
data={'Correlation coefficient':correlation_hier_1+correlation_ave_1+correlation_hier_2+correlation_ave_2+correlation_hier_3+correlation_ave_3,
      'Type':['Bayesian 1']*N_res+['Group averaging 1']*N_res+['Bayesian 2']*N_res+['Group averaging 2']*N_res+['Bayesian 3']*N_res+['Group averaging 3']*N_res}
dataframe=pd.DataFrame(data)

plt.figure()
#plt.grid(True)  #

ax = sns.violinplot(x=dataframe['Type'], y=dataframe['Correlation coefficient'],palette="Set3", bw=.2, cut=1, linewidth=1.5)
#plt.yticks(np.arange(0.4, 0.81, 0.1))

pairs=[("Bayesian 1", "Group averaging 1"), ("Bayesian 2", "Group averaging 2"), ("Bayesian 3", "Group averaging 3")]
annotator = Annotator(ax, pairs, data=dataframe,x=x, y=y)
annotator.configure(test='Mann-Whitney', text_format='star',line_height=0.03,line_width=1)
#annotator.configure(test='t-test_paired', text_format='star',line_height=0.03,line_width=1)

annotator.apply_and_annotate()

plt.title("Comparision",fontsize = 16)
plt.xlabel('Type',fontsize=14)
plt.ylabel('Correlation coefficient',fontsize=14)
plt.xticks(fontsize=12)
plt.yticks(fontsize=12)


#images_path='/home/lingbin/Documents/work/pythonProject/AD_script/figures/boxplot_AD'
#plt.savefig('/home/lingbin/Documents/work/pythonProject/AD_script/figures/boxplot_AD/ACC.svg')
#plt.show()

#-----------------------------------------------------------------------------------------------------------------------
