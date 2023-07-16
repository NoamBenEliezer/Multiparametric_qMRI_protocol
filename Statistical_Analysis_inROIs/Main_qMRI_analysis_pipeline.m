clear

Maps_path='...\Brain_Atlas_result_maps';
addpath ('...\Statistical_Analysis_inROIs');

chauvenet_criterion = 3 ; % remove voxels where value > mean ± 3*SD
erosion_flag        = 2 ; % 0/1= no erosion, 2= single voxel erosion, 3= two voxels erosion ....
LR_analysis_flag    = 0 ; % Compare left to right hemispheres


map_types={'T1','T2', 'T2s', 'QSM' ,'WF', 'MTVF', 'ADC', 'FA',  'MTRs',  'ihMTR'} ; 

for map_Idx=1:length (map_types)
    map_type=map_types{map_Idx};
    switch map_type
        case 'T2'
            qMRI_map_name = 'T2map_EMC';
            Seg_map_name  = 'Segments_EMC';
            map_def='T2map_EMC';
            Seg_def='qT2_seg_rot_flip';
        case 'PD'
            qMRI_map_name = 'PDmap_EMC';
            Seg_map_name  = 'Segments_EMC';
            map_def='PDmap_EMC';
            Seg_def='qT2_seg_rot_flip';
        case 'ADC'
            qMRI_map_name = 'ADC_map';
            Seg_map_name  = 'Segments_DTI';
            map_def='ADC_map';
            Seg_def='Segments_DTI';
        case 'FA'
            qMRI_map_name = 'FA_map';
            Seg_map_name  = 'Segments_DTI';
            map_def='FA_map';
            Seg_def='Segments_DTI';
        case 'ihMTR'
            qMRI_map_name = 'ihMTR_map';
            Seg_map_name  = 'Segments_ihMT';
            map_def='ihMTR_map';
            Seg_def='ihMTR_seg';
        case 'MTRs'
            qMRI_map_name = 'MTRs_map';
            Seg_map_name  = 'Segments_ihMT';
            map_def='MTRs_map';
            Seg_def='ihMTR_seg';
        case 'QSM'
            qMRI_map_name = 'QSM_map_new';
            %         Seg_map_name  = 'Segments_QSM';
            Seg_map_name  = 'Segments_T2s';
            map_def='QSM_map_new';
            %         Seg_def='QSM_seg_new';
            Seg_def='qT2s_seg_rot_flip';
        case 'T2s'
            qMRI_map_name = 'T2_star_map';
            Seg_map_name  = 'Segments_T2s';
            map_def='T2s_map';
            Seg_def='qT2s_seg_rot_flip';
        case 'T1'
            qMRI_map_name = 'mrQ_maps';
            qMRI_map_Sub_name = 'mrQ_maps.T1';
            Seg_map_name  = 'mrQ_maps.Segments';
        case 'MTVF'
            qMRI_map_name = 'mrQ_maps';
            qMRI_map_Sub_name = 'mrQ_maps.TV';
            Seg_map_name  = 'mrQ_maps.Segments';
        case 'WF'
            qMRI_map_name = 'mrQ_maps';
            qMRI_map_Sub_name = 'mrQ_maps.WF';
            Seg_map_name  = 'mrQ_maps.Segments';
        case 'MTR'
            qMRI_map_name = 'mrQ_maps';
            qMRI_map_Sub_name = 'mrQ_maps.MTR_DR';
            Seg_map_name  = 'mrQ_maps.Segments';
        case 'MTsat'
            qMRI_map_name = 'mrQ_maps';
            qMRI_map_Sub_name = 'mrQ_maps.MTsat';
            Seg_map_name  = 'mrQ_maps.Segments';
        case 'M0'
            qMRI_map_name = 'mrQ_maps';
            qMRI_map_Sub_name = 'mrQ_maps.M0';
            Seg_map_name  = 'mrQ_maps.Segments';
        case 'B1'
            qMRI_map_name = 'mrQ_maps';
            qMRI_map_Sub_name = 'mrQ_maps.B1';
            Seg_map_name  = 'mrQ_maps.Segments';
    end
    
    
    Maps_path_dir=dir(Maps_path);
    count=0;
    for i=1:length (Maps_path_dir)
        if Maps_path_dir(i).name(1)=='V'
            count=count+1;
            volunteer_list{count}=Maps_path_dir(i).name;
        end
    end
    clear i Maps_path_dir
    
    count_ses1=0;
    count_ses2=0;
    for Vol_idx=1:count
        
        Session = 1;
        Vol_ID  = volunteer_list{Vol_idx} % Vol_ID='V002';
        if contains(Vol_ID, '_S2')
            Session = 2;
        end
        
        qMRI_map_path=[Maps_path filesep Vol_ID filesep qMRI_map_name '.mat'];
        Seg_map_path=[Maps_path filesep Vol_ID filesep Seg_map_name '.mat'];
        
        if  strcmp(qMRI_map_name,'mrQ_maps') % mrQ results
            load (qMRI_map_path)
            %     qMRI_map=sprintf();
            qMRI_map=eval(qMRI_map_Sub_name);
            Seg_map = eval(Seg_map_name);
        else
            load (qMRI_map_path);
            qMRI_map=eval(map_def);
            
            load (Seg_map_path);
            Seg_map=eval(Seg_def);
            
            %     if isstruct (qMRI_map)
            %         map_name=fields(qMRI_map);
            %         map_name=map_name{1};
            %     end
        end
        
        if strcmp(map_type,'QSM')
            Seg_map=permute(Seg_map, [2,1,3]);
            Seg_map=fliplr(Seg_map);
        end
        
        if strcmp(map_type,'ADC')
            qMRI_map=double(qMRI_map);
            qMRI_map=qMRI_map*1e4;
        end
        
        if strcmp(map_type,'T1')
            qMRI_map=1e3*(qMRI_map); %sec->msec
        end
             
        
        [ROI_list, Slice_labels , qMRI_map_3D, Seg_ROI_3D,...
            ROI_list_all, Slice_labels_all , qMRI_map_3D_all, Seg_ROI_3D_all]...
            = ROI_3D_collector_BA (double(Seg_map), double(qMRI_map), erosion_flag, chauvenet_criterion, map_type); % All_FS_ROIs
        
        [ROI_list_12, Slice_labels_12 , qMRI_map_3D_12, Seg_ROI_3D_12]...
            = Top_12_ROIs (ROI_list_all, Slice_labels_all , qMRI_map_3D_all, Seg_ROI_3D_all); % 12_ROIs
        
        if LR_analysis_flag==1
            [ROI_list_LR, Slice_labels_LR , qMRI_map_3D_LR, Seg_ROI_3D_LR]...
                = Top_LR_ROIs_BA (ROI_list_all, Slice_labels_all , qMRI_map_3D_all, Seg_ROI_3D_all); % divided into L-R
        end
        
        if Session==1
            count_ses1=count_ses1+1;
            curr_idx=4*(count_ses1-1)+[1:4];
            All_volunteer_session_1(1:12,curr_idx)=ROI_list_12;
        else
            count_ses2=count_ses2+1;
            curr_idx=4*(count_ses2-1)+[1:4];
            All_volunteer_session_2(1:12,curr_idx)=ROI_list_12;          
%             All_volunteer_session_1_4retest(1:12,curr_idx)=All_volunteer_session_1(1:12,end-3:end);
        end
        
        if LR_analysis_flag==1
            if Session==1
                curr_idx=4*(count_ses1-1)+[1:4];
                All_volunteer_session_1_LR(1:size(ROI_list_LR,1),curr_idx)=ROI_list_LR;
            else
                curr_idx=4*(count_ses2-1)+[1:4];
                All_volunteer_session_2_LR(1:size(ROI_list_LR,1),curr_idx)=ROI_list_LR;              
                All_volunteer_session_1_retest_LR(1:size(ROI_list_LR,1),curr_idx)=All_volunteer_session_1_LR(1:size(ROI_list_LR,1),end-3:end);
            end
        end
        
        
        clear ROI_list Slice_labels qMRI_map_3D Seg_ROI_3D curr_idx ROI_list_12 ...
            qMRI_map_3D_12 Seg_ROI_3D_12 ROI_list_all Slice_labels_all ...
            qMRI_map_3D_all Seg_ROI_3D_all Seg_map qMRI_map Session
        
        
        if strcmp(map_type,'T2')
            clear qT2_seg_rot_flip T2map_EMC
        elseif strcmp(map_type,'ADC')
            clear ADC_map Segments_DTI
        elseif strcmp(map_type,'FA')
            clear FA_map Segments_DTI
        end
        
        if LR_analysis_flag==1
            clear  Seg_ROI_3D_LR qMRI_map_3D_LR ROI_list_LR
        end
        
        
    end
    
    
    %% save
    if LR_analysis_flag==1
        Save_fol='...\Results\qMRI_values_inROIs';
        save ([Save_fol filesep sprintf('%s_results_LR.mat',map_type)], 'All_volunteer_session_1_LR', 'Slice_labels_LR')
        else
            Save_fol='...\Results\qMRI_valuesinROIs'; %\Without_Chauvnete
        save ([Save_fol filesep sprintf('%s_results.mat',map_type)], ...
            'All_volunteer_session_2', 'All_volunteer_session_1', 'Slice_labels_12')
    end
    
end
    
    
    
    
    
    
    
    
    
    
    
    
