Please check the path in each script before running the scripts.

The "Statistical_Analysis_inROIs" Git folder includes the following scripts:

1. "Main_qMRI_analysis_pipeline.m":
	
	Calculate qMRI statistics per volunteer, brain region, and scan session, based on the process qMRI and segmentation maps.
	This script uses the following scripts:

	a- Label_reader - detect FreeSurfer ROIs (see the Look-up-table under "Fs_Color_label_list") in the relevant segmentation map.
	b. ROI_3D_collector_BA - calculate the statistics of all FreeSurfer availble ROIs.
	c. ROIs_pack_BA - merge regions, e.g., right and left hemisphers, and cortex segments.
	d. Top_12_ROIs - statistics for specific regions, where "12" denoted the twelve investigated brain regions in the current study.
	e. Top_LR_ROIs_BA - statistics for specific regions, dived into left and right hemispheres.


2. "Evaluate_Vox_in_sementationMap.m":
	
	Calculate mean and SD number of vexals per brain region, and the difference between two segmentation datasets.