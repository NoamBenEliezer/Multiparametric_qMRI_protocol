Please check the path in each script before running the scripts.

The "Generate_figures_tables" Git folder includes the following scripts:

1. "qMRI_table_mean_variabilities.m":
	
	Calculate mean qMRI values across volunteers, and produce a summery table (Table 3) with mean and SD of Number of voxels, mean and SD of qMRI values and intra-ROI variability (mean of SD across volunteers).


2. "Table3_qMRI_paramsin_statistics_inFigure.m":
	
	Plot mean and SD values per ROI and qMRI map.

3. "RightLeft_inTable.m":
	
	Calculate mean qMRI values across volunteers per brain hemisphere, and produce a summery table with mean and SD of Number of voxels, mean and SD of qMRI values and intra-ROI variability (mean of SD across volunteers).


4. "RightLeft_fitting.m":
	
	Calculate the linear regression between mean qMRI values across volunteers per brain hemisphere, and plot the graph per qMRI map.


5. "Bland_Altman_Ses1vsSes2.m":
	
	Calculate statistics and generate Blant-Altman plots between two scan sessions.


6. "Outlier_voxels_count.m":
	
	Calculate mean and SD number of vexals per brain region, and the difference between two dataset of processed ROIs (i.e., evalute the number of outlier voxels, removed using a weak Chauvenet criterion).

