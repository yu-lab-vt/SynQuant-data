# Data sets used in SynQuant paper
All data sets used in the paper, along with the labels, can be downloaded from [zenodo](https://doi.org/10.5281/zenodo.10561290)
<!---
or [here](https://drive.google.com/open?id=1cGgpkxL0z0vnMTR1eXLxQFacjlVRmwNW).
-->

## Bass's 3D in vivo data
This data set is obtaind from [1], which can be downloaded at https://www.zenodo.org/record/215600#.XK0LBJhKjBV.

We save the 20 images used in MATLAB file `Bass.mat`. Inside that file, the 3D images are saved in cell array `img3DLst`. The mean-projected 2D images are saved in cell array `imgLst`. The 2D annotations are saved in `annoMapLst`. 

## Collman's array tomography data
This data is obtained from [2], which can be downloaded at https://neurodata.io/data/collman15/.

We save Collman 14 and Collman 15 in `Collman_clean.mat`. The annotations in EM channel that does not correspond to any fluorescence staining are removed. The images are saved in `imgLst`. The first element of it is `Collman 14` and the second is `Collman 15`. Each is a 4D array (Height x Width by Depth by channel). The first chanenl is pre-synaptic and the second is post-synaptic. The 3D annotations from EM channel are saved in `annoMapLst`. The first element is for `Collman14` and the second is for `Collman15`. Each is a 3D array (Height x Width x Depth).

## In-house neuron astrocyte co-culture data
This data is obtained from experiments performed in [3]. We save the data in `guilai_ctrl_1_strong_high.mat`.

The 16 images are save in `imgLst` where each element is a 2D image. The annotations are saved in `annoMapLst`.

## Synthetic data
We generate synthetic data with three noise levels and three ranges of puncta sizes. There are 9 (3x3) experiment conditions in all. Each condition is saved in an individual `.mat` file in folder `synthetic`. The code to generate the data is `prep_synthetic.m`.

| Data                               | Min size (pixel) | Max size (pixel) | Average SNR |
|------------------------------------|------------------|------------------|-------------|
| synthetic_smax_16_var1_0.0004.mat  | 9                | 16               | 23.8        |
| synthetic_smax_16_var1_0.0025.mat  | 9                | 16               | 17.2        |
| synthetic_smax_16_var1_0.01.mat    | 9                | 16               | 11.5        |
| synthetic_smax_50_var1_0.0004.mat  | 9                | 50               | 23.8        |
| synthetic_smax_50_var1_0.0025.mat  | 9                | 50               | 17.2        |
| synthetic_smax_50_var1_0.01.mat    | 9                | 50               | 11.5        |
| synthetic_smax_150_var1_0.0004.mat | 9                | 150              | 23.8        |
| synthetic_smax_150_var1_0.0025.mat | 9                | 150              | 17.2        |
| synthetic_smax_150_var1_0.01.mat   | 9                | 150              | 11.5        |

In each `.mat` file, `imgLst` contains 10 images and `annoMapLst` contains the ground truth labels. 

## Reference
[1] Bass, Cher, et al. "Detection of axonal synapses in 3d two-photon images." PloS one 12.9 (2017): e0183309.

[2] Collman, Forrest, et al. "Mapping synapses by conjugate light-electron array tomography." Journal of Neuroscience 35.14 (2015): 5792-5807.

[3] Mizuno, Grace O., et al. "Aberrant calcium signaling in astrocytes inhibits neuronal excitability in a human Down syndrome stem cell model." Cell reports 24.2 (2018): 355-365.


