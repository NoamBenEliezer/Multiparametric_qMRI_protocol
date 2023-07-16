close all
clear

results_fol='...\Results\qMRI_valuesinROIs';


map_types={'T1', 'T2', 'T2s', 'QSM', 'WF', 'MTVF', 'ADC', 'FA', 'MTRs', 'ihMTR'} ;
        color_palete={'#CC3B7C','#0072BD', '#A2142F',	'#D95319', '#EDB120','#7a5230', '#7E2F8E', '#77AC30', '#4DBEEE', 'k', '#56704B' };


%% qMRI parameters - Left-Right Table

% Top_LR_list={'Left-', 'Right-'};
for map_idx=1:length (map_types)
    
load ([results_fol filesep sprintf('%s_results_LR.mat', map_types{map_idx})])
Curr_mat=All_volunteer_session_1_LR;

% N_vol=size(Curr_mat, 2)/4; % N voxels, mean, SD, CV
N_ROIs=size(Curr_mat, 1); % Left, right


for ROI_idx=1:N_ROIs
Mean_Nvox (ROI_idx)= mean(All_volunteer_session_1_LR(ROI_idx, 1:4:109));
STD_Nvox (ROI_idx)= std(All_volunteer_session_1_LR(ROI_idx, 1:4:109));
Mean_value (ROI_idx)=mean(All_volunteer_session_1_LR(ROI_idx, 2:4:110));
Std_of_Mean_value  (ROI_idx)= std(All_volunteer_session_1_LR(ROI_idx, 2:4:110));
Mean_STD (ROI_idx)= mean(All_volunteer_session_1_LR(ROI_idx, 3:4:111));
end

Table_summery_Left=[Mean_Nvox(1:2:21)', STD_Nvox(1:2:21)', Mean_value(1:2:21)', Std_of_Mean_value(1:2:21)', Mean_STD(1:2:21)'];
Table_summery_Right=[Mean_Nvox(2:2:22)', STD_Nvox(2:2:22)', Mean_value(2:2:22)', Std_of_Mean_value(2:2:22)', Mean_STD(2:2:22)'];

All_data_table = [Table_summery_Left Table_summery_Right];

save ([results_fol filesep 'SummeryTables' filesep sprintf('%s_Ses1_table_LR.mat',map_types{map_idx})], 'All_data_table')

end

All_data_table=All_data_table;