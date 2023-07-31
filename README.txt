Copyrights - 
When using the data or scripts, please cite the paper "A comprehensive protocol for quantitative magnetic resonance imaging of the brain at 3 Tesla".
(c) Dvir Radunsky & Noam Ben-Eliezer 2023.

This Git repository includes scripts and data, which are related to the abovementioned paper.
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


>> The data is availble to download from the Figshare “Multiparametric qMRI data” project:
1.	qMRI data – 
All quantitative and registered segmentation maps, provided in MATLAB’s (.mat) format.
•	"qMRI_maps_Session1.zip" - covering data for all volunteers from 1st (N=28) scan session. doi: 10.6084/m9.figshare.23810808
•	"qMRI_maps_Session2.zip" - covering data for all volunteers from 2nd (N=23) scan session. doi: 10.6084/m9.figshare.23811123

2.	Raw data – "Example_RawData.zip": 
A raw dataset of a single volunteer, provided in DICOM (.dcm) format and including all raw images acquired using the qMRI protocol. doi: 10.6084/m9.figshare.23811492
The entire volunteers’ MRI raw data cannot be shared publicly due to regulatory restrictions, but only under specific research agreements and therefore will be fully available upon request from the corresponding author.




>> Processing pipelines are available online and can be download from the following links (request for download/use require either academic license, or, a license for non-academic or commercial use):

mrQ software package: https://github.com/mezera/mrQ
EMC platform: https://beneliezer-lab.com/software-downloads-page/
ihMT pipeline: https://github.com/lsoustelle/ihmt_proc
Susceptibility calculation: https://xip.uclb.com/product/mri_qsm_tkd
Diffusion pipeline: https://github.com/GalBenZvi/dmriprep

The ihMT sequence is available upon request (guillaume.duhamel@univ-amu.fr) and requires a copyright license agreement with Aix-Marseille University. All other sequences are available in conventional clinical scanners.



