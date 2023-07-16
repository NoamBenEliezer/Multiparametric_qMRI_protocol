clear all;

map_types={'T1','T2', 'T2s' ,'QSM','WF','MTVF', 'ADC', 'FA',  'MTRs',  'ihMTR'};
N_vol=28;

Fol_removal='...\qMRI_valuesinROIs';
Fol_AllVox='...\Results\qMRI_valuesinROIs\All_Voxels_no_Chavnete';
Save_fol=Fol_removal;

for map_idx=1:length(map_types)
    map_type=map_types{map_idx};
load ([Fol_removal filesep sprintf('%s_results.mat',map_type)])
% Curr_mat_removal_orig=All_volunteer_session_1([1:10,14,15],:);
Curr_mat_removal=All_volunteer_session_1;
load ([Fol_AllVox filesep sprintf('%s_results.mat',map_type)])
Curr_mat_AllVox=All_volunteer_session_1;

clear All_volunteer_session_1 All_volunteer_session_1_retest All_volunteer_session_2 Slice_labels_15


    for ROI_idx=1:12
     
        No_removel=Curr_mat_AllVox(ROI_idx,1:4:109);
With_removal=Curr_mat_removal(ROI_idx,1:4:109);
        
       mean_Vox_AllVox=mean(No_removel);
std_Vox_AllVox=std(No_removel);
    mean_Vox_removal=mean(With_removal);
std_Vox_removal=std(With_removal);


    Change_per=100*(No_removel-With_removal)./No_removel;
    
    mean_per_change=mean(Change_per);
        std_per_change=std(Change_per);

    All_outliers_data(ROI_idx,1:6)= [mean_Vox_AllVox std_Vox_AllVox mean_Vox_removal std_Vox_removal mean_per_change std_per_change];
    
    end
           
All_data_table((map_idx-1)*12+[1:12], 1:6)=All_outliers_data;
end

    save ([Save_fol filesep 'SummeryTables' filesep sprintf('Ses1_OutlierRemoval_table.mat')], 'All_data_table')
