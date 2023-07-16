clear


Maps_path='...\Brain_Atlas_result_maps';
addpath ('...\Statistical_Analysis_inROIs');

chauvenet_criterion = 0 ; % remove voxels where value > mean ± 3*SD
erosion_flag        = 2 ; % 0/1= no erosion, 2= single voxel erosion, 3= two voxels erosion ....
LR_analysis_flag    = 0 ; % Compare left to right hemispheres


map_types={'Seg', 'T1'} ; 
for map_Idx=1:length (map_types)
    % map_type='PD';
    map_type=map_types{map_Idx};
    switch map_type
        case 'Seg'
            qMRI_map_name = 'Segments_MP2RAGE';
            Seg_map_name  = 'Segments_MP2RAGE';
            map_def='Anat_seg';
%             Seg_def='qT2_seg_rot_flip';
        case 'T1'
            qMRI_map_name = 'mrQ_maps';
            qMRI_map_Sub_name = 'mrQ_maps.Segments';
            Seg_map_name  = 'mrQ_maps.Segments';
    end
    
    
    Maps_path_dir=dir(Maps_path);
    count=0;
    for i=1:length (Maps_path_dir)
        if Maps_path_dir(i).name(1)=='V'
            %         if strcmp(Maps_path_dir(i).name,'V002') ||  strcmp(Maps_path_dir(i).name,'V041')
            %             continue;
            %         else
            count=count+1;
            volunteer_list{count}=Maps_path_dir(i).name;
            %         end
        end
    end
    clear i Maps_path_dir
    
    count_ses1=0;
    count_ses2=0;
    for Vol_idx=1:count
        
        Session = 1;
        Vol_ID  = volunteer_list{Vol_idx} % Vol_ID='V002';
        %     Vol_ID='V020'
        if contains(Vol_ID, '_S2')
            Session = 2;
            %         if  ~strcmp(Vol_ID,'V035_S2')
            %             continue;
            %         end
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
            
%             load (Seg_map_path);
            Seg_map=qMRI_map;
            

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
            %         if strcmp(Vol_ID,'V035_S2')
            %         All_volunteer_session_1(1:12,end-3:end)=ROI_list_12;
            %         end
            All_volunteer_session_2(1:12,curr_idx)=ROI_list_12;
            
            All_volunteer_session_1_4retest(1:12,curr_idx)=All_volunteer_session_1(1:12,end-3:end);
        end
        
        if LR_analysis_flag==1
            if Session==1
                curr_idx=4*(count_ses1-1)+[1:4];
                All_volunteer_session_1_LR(1:size(ROI_list_LR,1),curr_idx)=ROI_list_LR;
            else
                curr_idx=4*(count_ses2-1)+[1:4];
                %                     if strcmp(Vol_ID,'V035_S2')
                %         All_volunteer_session_1_LR(1:size(ROI_list_LR,1),end-3:end)=ROI_list_LR;
                %         end
                
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
            Save_fol='...\Results\Segmentation_maps';
        save ([Save_fol filesep sprintf('%s_results.mat',map_type)], ...
            'All_volunteer_session_1_4retest', 'All_volunteer_session_2', 'All_volunteer_session_1', 'Slice_labels_12')
    end
    
end
    
    A=5;
    
    
    
    
    
    
    
    
    
    
    
    
