from brainspace.datasets import load_group_fc, load_parcellation,load_conte69
import numpy as np
import scipy.io as scio
import matplotlib.pyplot as plt
import numpy as np
import matplotlib; matplotlib.use('TkAgg')
import os
from brainspace.mesh.mesh_io import read_surface
# First load mean connectivity matrix and Schaefer parcellation
N_roi=100
scan='AP'
resolution=1
labeling = load_parcellation('schaefer', scale=N_roi, join=True)

mask = labeling != 0

# and load the conte69 hemisphere surfaces
surf_lh, surf_rh = load_conte69()

from brainspace.gradient import GradientMaps
from brainspace.plotting import plot_hemispheres,plot_surf
from brainspace.utils.parcellation import map_to_labels

group_results=scio.loadmat('/home/lingbin/Documents/work/pythonProject/BCP_fMRI/results/roi_'+str(N_roi)+'_1_'+scan+'/'+str(resolution)+'/labels_'+scan)
K_max=group_results['label_'+scan].max()
for i in range(9):

   community_label=group_results['label_'+scan][:,i]
   grad = map_to_labels(community_label, labeling, mask=labeling != 0,fill=0)
   label_text = None

   plot_hemispheres(surf_lh, surf_rh, array_name=grad, size=(1600, 800),color_bar=True, cmap ='Spectral',
                 label_text=None, color_range=(-1,K_max))
   #plt.savefig('/home/lingbin/Documents/work/pythonProject/BCP_fMRI/results/roi_'+str(N_roi)+'_1_'+scan+'/'+str(resolution)+'/month_N'+str(i)+'.svg')
   #plt.show()




