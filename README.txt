Copyrights - 
When using the data or scripts, please cite the paper "A comprehensive protocol for quantitative magnetic resonance imaging of the brain at 3 Tesla".
(c) Dvir Radunsky & Noam Ben-Eliezer 2023.

This Git respiratory includes scripts and data, which are related to the abovementioned paper.
The main Git folder includes:

1. "All_volunteers_qMRI_maps.zip":
	
	All types of quantitative and registered segmentation maps, provided in .mat format - 
	Includes the data of all volunteers from 1st (N=28) and 2nd (N=23, denoted with '_S2') scan sessions.

2. "V001_Example_RawData.zip": 

	Example raw dataset of a single volunteer, provided in .dcm format - 
	Includes all raw images acquired using the qMRI protocol. 

3. "FreeSurfer_related":

	Includes Matlab scripts to apply FreeSurfer based segmentation and registration. 
	This requires to download and install the FreeSurfer tool from: https://surfer.nmr.mgh.harvard.edu/fswiki/DownloadAndInstall

4. "Statistical_Analysis_inROIs":

	Includes Matlab scripts for extracting quantitative values per brain region of interest (ROI(, based on the segmented maps.

5. "Generate_figures_tables":

	Includes Matlab scripts to produce the paper's figures and tables, based on the statistics per brain region.


Note:
Download the scripts and data to a local path. Then, check the path in each script before running the scripts.