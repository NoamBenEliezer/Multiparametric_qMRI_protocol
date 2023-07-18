Copyrights - 
When using the data or scripts, please cite the paper "A comprehensive protocol for quantitative magnetic resonance imaging of the brain at 3 Tesla".
(c) Dvir Radunsky & Noam Ben-Eliezer 2023.

This Git respiratory includes scripts and data, which are related to the abovementioned paper.
>> The main Git folder includes:

1. "FreeSurfer_related":

	Includes Matlab scripts to apply FreeSurfer based segmentation and registration. 
	This requires to download and install the FreeSurfer tool from: https://surfer.nmr.mgh.harvard.edu/fswiki/DownloadAndInstall

2. "Statistical_Analysis_inROIs":

	Includes Matlab scripts for extracting quantitative values per brain region of interest (ROI(, based on the segmented maps.

3. "Generate_figures_tables":

	Includes Matlab scripts to produce the paper's figures and tables, based on the statistics per brain region.

Note:
Download the scripts and data to a local path. Then, check the path in each script before running the scripts.


>> The data is availble to download from: https://drive.google.com/drive/folders/1sP84ArWZJpT4-4NuuWaWCPrmFpBDjZA4?usp=sharing

1. "All_volunteers_qMRI_maps.zip":
	
	All types of quantitative and registered segmentation maps, provided in .mat format - 
	Includes the data of all volunteers from 1st (N=28) and 2nd (N=23, denoted with '_S2') scan sessions.

2. "V001_Example_RawData.zip": 

	Example raw dataset of a single volunteer, provided in .dcm format - 
	Includes all raw images acquired using the qMRI protocol.



>> Processing pipelines are available online and can be download from the following links (request for download/use require either academic license, or, a license for non-academic or commercial use):

mrQ software package: https://github.com/mezera/mrQ
EMC platform: https://beneliezer-lab.com/software-downloads-page/
ihMT pipeline: https://github.com/lsoustelle/ihmt_proc
Susceptibility calculation: https://xip.uclb.com/product/mri_qsm_tkd
Diffusion pipeline: https://github.com/GalBenZvi/dmriprep

The ihMT sequence is available upon request (guillaume.duhamel@univ-amu.fr) and requires a copyright license agreement with Aix-Marseille University. All other sequences are available in conventional clinical scanners.



