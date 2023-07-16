close all
clear

results_fol='...\Results\qMRI_valuesinROIs';

map_types={'T1', 'T2', 'T2s', 'QSM', 'WF', 'MTVF', 'ADC', 'FA', 'MTRs', 'ihMTR'} ;

Save_fol=results_fol;

%% Right-Left plot with liner fitting

%     Save_fol='G:\My Drive\Dvir- Master\Brain atlas\Results\qMRI_valuesinROIs';

Top_12_list={'Cerebral-White-Matter_all','Caudate_all', 'Putamen_all','Pallidum_all','CC_all', 'Thalamus-Proper*_all', 'VentralDC_all',...
    'Accumbens-area_all', 'Amygdala_all', 'Hippocampus_all', 'ctx_insula_all', 'ctx_all'};
%
% Top_LR_list={'Left-', 'Right-'};
for map_idx=1:length (map_types)
    
    load ([results_fol filesep sprintf('%s_results.mat', map_types{map_idx})])
    Curr_mat=All_volunteer_session_1;
    
    N_vol=size(Curr_mat, 2)/4; % N voxels, mean, SD, CV
%     N_ROIs=size(Curr_mat, 1) / 2; % Left, right
    
    % figure; hold on
    All_data_table=[];
    for ROI_idx=1:length(Top_12_list)
        N_vox= Curr_mat(:,1:4:(N_vol-1)*4+1);
        Avg_N_vox=mean(N_vox(ROI_idx,:));
        SD_N_vox=std(N_vox(ROI_idx,:));
        
        Value_in_ROI=Curr_mat(:,2:4:(N_vol-1)*4+2);
        Avg_Value_all=mean(Value_in_ROI(ROI_idx,:));
        SD_Value_all=std(Value_in_ROI(ROI_idx,:)); % Inter-subject variabillity
        CV_Value_all=100*SD_Value_all/Avg_Value_all;
        
        SD_in_ROI=Curr_mat(:,3:4:(N_vol-1)*4+3);
        Avg_SD_all=mean(SD_in_ROI(ROI_idx,:)); % Intra-ROI / Intra-subject variabillity
        SD_SD_all=std(SD_in_ROI(ROI_idx,:)); % Intra-ROI / Intra-subject variabillity
        
       
        All_data_table(ROI_idx,1:5)=[Avg_N_vox SD_N_vox Avg_Value_all SD_Value_all Avg_SD_all]; %CV_Value_all 
        
    end
    
    save ([Save_fol filesep 'SummeryTables' filesep sprintf('%s_Ses1_table.mat',map_types{map_idx})], 'All_data_table')
    
end 
All_data_table=All_data_table*100;
