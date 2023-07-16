function [ROI_list, Slice_labels , qMRI_map_3D, Seg_ROI_3D,...
    ROI_list_all, Slice_labels_all , qMRI_map_3D_all,Seg_ROI_3D_all]...
    = ROI_3D_collector_BA (Seg_vol, qqMRI_Arr, ROI_adj_flag, chauvenet_criterion, map_type)

[Label_num, Label_name] = Label_reader;

% Slice_loc=80; % out of 256
N_scans=size(qqMRI_Arr,4);
Scan_session=1;

% qMRI_map_3D=zeros(size(qqMRI_Arr(:,:,:,curr_scan)));
if ROI_adj_flag>1
    se = strel('line',ROI_adj_flag,90);
end
ROI_counter=0;

% [Seg_vol, qqMRI_Arr]=Maps_Resize(Seg_vol, qqMRI_Arr);


ROI_list=[];
% parfor i=1:14175
for FS_idx=1:14175
    if (Seg_vol(Seg_vol==FS_idx))
        %       ROI_counter=ROI_counter+1;
        ROI_list=[ROI_list FS_idx];
    end
end
ROI_list=ROI_list';
ROI_counter=length(ROI_list);

% tic
for FS_idx=1:ROI_counter
    
    Label_num_loc=find(ROI_list(FS_idx)==Label_num);
    %         Label_ROI=convertCharsToStrings(Label_name{Label_num_loc});
    Label_ROI=string(Label_name{Label_num_loc});
    
    Slice_labels(FS_idx)=Label_ROI;
    
    qMRI_map_3D{FS_idx}=zeros(size(qqMRI_Arr(:,:,:,Scan_session)));
    Seg_ROI_3D{FS_idx}= qMRI_map_3D{FS_idx};
    
    qMRI_map_3D{FS_idx}(Seg_vol==ROI_list(FS_idx))=qqMRI_Arr(Seg_vol==ROI_list(FS_idx));
    Seg_ROI_3D{FS_idx}(Seg_vol==ROI_list(FS_idx))=Seg_vol(Seg_vol==ROI_list(FS_idx));
    
    
    if ~sum(sum(sum(isnan(qMRI_map_3D{FS_idx}))))==0
    tmp_qMRI_map=qMRI_map_3D{FS_idx};
    tmp_Nan_map=isnan(qMRI_map_3D{FS_idx});
    tmp_qMRI_map(tmp_Nan_map==1)=0;
    qMRI_map_3D{FS_idx}=tmp_qMRI_map;
    clear tmp_Nan_map tmp_qMRI_map
    end
    
    % if erosion or chavenue
    if ROI_adj_flag>1
          Seg_ROI_3D{FS_idx}=imerode(Seg_ROI_3D{FS_idx},se);
          qMRI_mask_tmp=logical(Seg_ROI_3D{FS_idx}); 
          qMRI_map_3D{FS_idx}=qMRI_map_3D{FS_idx}.*qMRI_mask_tmp;
          clear qMRI_mask_tmp
    end
    
    if (chauvenet_criterion) 
        qMRImean = mean(qMRI_map_3D{FS_idx}(qMRI_map_3D{FS_idx}~=0));
        qMRISD   =  std(qMRI_map_3D{FS_idx}(qMRI_map_3D{FS_idx}~=0));
        qMRI_tmp=qMRI_map_3D{FS_idx};
        qMRI_tmp(qMRI_tmp < (qMRImean - chauvenet_criterion*qMRISD)) = 0;
        qMRI_tmp(qMRI_tmp > (qMRImean + chauvenet_criterion*qMRISD)) = 0;
        qMRI_mask = logical(qMRI_tmp);
        qMRI_map_3D{FS_idx}=qMRI_map_3D{FS_idx}.*qMRI_mask;
        Seg_ROI_3D{FS_idx}=Seg_ROI_3D{FS_idx}.*qMRI_mask;
    end
    
    %         ROI_list(FS_idx,2)= length(Seg_vol(Seg_vol==ROI_list(FS_idx)));
    ROI_list(FS_idx,2)= length(qMRI_map_3D{FS_idx}(qMRI_map_3D{FS_idx}~=0));
    
    %         qMRI_ROI=qqMRI_Arr(Seg_vol==ROI_list(FS_idx));
    qMRI_ROI=qMRI_map_3D{FS_idx}(qMRI_map_3D{FS_idx}~=0);
    
    N_scans_mat_loc= 2 + (Scan_session*2-1);
    
    ROI_list(FS_idx,N_scans_mat_loc:(N_scans_mat_loc+2))=[mean(qMRI_ROI) std(qMRI_ROI) 100*std(qMRI_ROI)/mean(qMRI_ROI)]; % mean, SD, CV
    
    
end
% toc


% [ROI_list_all, Slice_labels_all] = ROIs_gather_BA(ROI_list, Slice_labels);

[ROI_list_all, Slice_labels_all , qMRI_map_3D_all, Seg_ROI_3D_all]...
    = ROIs_pack_BA(ROI_list, Slice_labels , qMRI_map_3D, Seg_ROI_3D);


Slice_labels_all=Slice_labels_all';

