function [ROI_list_all, Slice_labels_all , T2_map_3D_all, Seg_ROI_3D_all] = ROIs_pack_BA(ROI_list_orig, Slice_labels_orig , T2_map_3D_orig, Seg_ROI_3D_orig)

Seg_ROI_3D_all=Seg_ROI_3D_orig;
ROI_list_all=ROI_list_orig;
Slice_labels_all=Slice_labels_orig;
T2_map_3D_all=T2_map_3D_orig;

% ROI_list, Slice_labels , T2_map_3D

%% Remove T2 outliers

Counter=0;
for idx_labels=1:length(ROI_list_all)
    
    if ROI_list_all(idx_labels,2)<30
        Counter=Counter+1;
        ROI_chronological_idx(Counter)=idx_labels;
        %         ROI_FS_idx(Counter)=ROI_list_small(idx_labels,1);
    end
end

for idx_correction=1:Counter
    
    % ROI list
    ROI_list_tmp=ROI_list_all(1:ROI_chronological_idx(idx_correction)-idx_correction,:);
    ROI_list_tmp (size(ROI_list_tmp,1)+1:length(ROI_list_all)-1,:)=ROI_list_all(ROI_chronological_idx(idx_correction)+2-idx_correction:end,:);
    ROI_list_all=ROI_list_tmp;
    clear ROI_list_tmp;
    
    % Slice_labels
    Slice_labels_tmp=Slice_labels_all(1:ROI_chronological_idx(idx_correction)-idx_correction);
    Slice_labels_tmp (length(Slice_labels_tmp)+1:length(Slice_labels_all)-1)=Slice_labels_all((ROI_chronological_idx(idx_correction)+2-idx_correction):end);
    Slice_labels_all=Slice_labels_tmp;
    clear Slice_labels_tmp;
    
    % T2_map_3D
    T2_map_3D_tmp=T2_map_3D_all(1:ROI_chronological_idx(idx_correction)-idx_correction);
    T2_map_3D_tmp (length(T2_map_3D_tmp)+1:length(T2_map_3D_all)-1)=T2_map_3D_all((ROI_chronological_idx(idx_correction)+2-idx_correction):end);
    T2_map_3D_all=T2_map_3D_tmp;
    clear T2_map_3D_tmp;
    
    %Seg_ROI_3D
    Seg_ROI_3D_tmp=Seg_ROI_3D_all(1:ROI_chronological_idx(idx_correction)-idx_correction);
    Seg_ROI_3D_tmp (length(Seg_ROI_3D_tmp)+1:length(Seg_ROI_3D_all)-1)=Seg_ROI_3D_all((ROI_chronological_idx(idx_correction)+2-idx_correction):end);
    Seg_ROI_3D_all=Seg_ROI_3D_tmp;
    clear Seg_ROI_3D_tmp;
end

clear ROI_chronological_idx; clear ROI_FS_idx;

%% Cortex
Counter=0;
ctx_all_3D_map=zeros(size(T2_map_3D_all{1}));
ctx_all_Seg_3D_map=zeros(size(T2_map_3D_all{1}));

ctx_all_N_pix=0;
for idx_labels=1:length(Slice_labels_all)
    
    %     ROIname=convertStringsToChars(Slice_labels_small(idx_labels));
    ROIname=char(Slice_labels_all(idx_labels));
    try
        if strcmp(ROIname(1:3),'ctx')
            Counter=Counter+1;
            ROI_chronological_idx(Counter)=idx_labels;
            %         ROI_FS_idx(Counter)=ROI_list_small(idx_labels,1);
            ctx_all_3D_map= ctx_all_3D_map + T2_map_3D_all{ROI_chronological_idx(Counter)};
            ctx_all_Seg_3D_map=ctx_all_Seg_3D_map+Seg_ROI_3D_all{ROI_chronological_idx(Counter)};
            ctx_all_N_pix=ctx_all_N_pix+ROI_list_all(ROI_chronological_idx(Counter),2);
        end
    catch
        woperpweor=5345;
    end
end

% ROI list
ctx_all_stats=[5000 ...
    ctx_all_N_pix ...
    mean(ctx_all_3D_map(ctx_all_3D_map~=0)) ...
    std(ctx_all_3D_map(ctx_all_3D_map~=0))...
    100*std(ctx_all_3D_map(ctx_all_3D_map~=0))/mean(ctx_all_3D_map(ctx_all_3D_map~=0))];

Slice_labels_all(end+1)='ctx_all'; % Slice_labels
ROI_list_all(end+1,:)=ctx_all_stats;
T2_map_3D_all(end+1)={ctx_all_3D_map}; % T2_map_3D
Seg_ROI_3D_all(end+1)={ctx_all_Seg_3D_map} ;%Seg_ROI_3D

clear ROI_chronological_idx; clear ROI_FS_idx;


%% Corpus callosum
Counter=0;
CC_all_3D_map=zeros(size(T2_map_3D_all{1}));
CC_all_Seg_3D_map=CC_all_3D_map;

CC_all_N_pix=0;
for idx_labels=1:length(Slice_labels_all)
    
    %     ROIname=convertStringsToChars(Slice_labels_small(idx_labels));
    ROIname=char(Slice_labels_all(idx_labels));
    
    if  contains(ROIname,'CC_')
        Counter=Counter+1;
        ROI_chronological_idx(Counter)=idx_labels;
        %         ROI_FS_idx(Counter)=ROI_list_small(idx_labels,1);
        CC_all_3D_map= CC_all_3D_map + T2_map_3D_all{ROI_chronological_idx(Counter)};
        CC_all_Seg_3D_map=CC_all_Seg_3D_map+Seg_ROI_3D_all{ROI_chronological_idx(Counter)};
        CC_all_N_pix=CC_all_N_pix+ROI_list_all(ROI_chronological_idx(Counter),2);
    end
    
end

% ROI list
CC_all_stats=[5001 ...
    CC_all_N_pix ...
    mean(CC_all_3D_map(CC_all_3D_map~=0)) ...
    std(CC_all_3D_map(CC_all_3D_map~=0))...
    100*std(CC_all_3D_map(CC_all_3D_map~=0))/mean(CC_all_3D_map(CC_all_3D_map~=0))];

Slice_labels_all(end+1)='CC_all';% Slice_labels
ROI_list_all(end+1,:)=CC_all_stats;% ROI list
T2_map_3D_all(end+1)={CC_all_3D_map};% T2_map_3D
Seg_ROI_3D_all(end+1)={CC_all_Seg_3D_map};%Seg_ROI_3D

clear ROI_chronological_idx; clear ROI_FS_idx;


%% Left-right pairs

for idx_labels=1:length(Slice_labels_all)
    
    ROIname=char(Slice_labels_all(idx_labels));
    
    if  contains(ROIname,'Left')
        curr_ROI_name=ROIname(6:end);
        
        ROI_chronological_idx(1)=idx_labels;
        
        if find(Slice_labels_all==['Right-' curr_ROI_name])
        ROI_chronological_idx(2)=find(Slice_labels_all==['Right-' curr_ROI_name]);
        else
            continue;
        end
        
        %         ROI_FS_idx(Counter)=ROI_list_small(idx_labels,1);
        Slice_labels_all(end+1)=[curr_ROI_name '_all'];
        curr_3D_map=T2_map_3D_all{ROI_chronological_idx(1)}+T2_map_3D_all{ROI_chronological_idx(2)};
        T2_map_3D_all{end+1}= curr_3D_map;
        Seg_ROI_3D_all{end+1}=Seg_ROI_3D_all{ROI_chronological_idx(1)}+Seg_ROI_3D_all{ROI_chronological_idx(2)};
        
        ROI_list_all(end+1,:)=[ 6000+idx_labels ...
            ROI_list_all(ROI_chronological_idx(1),2)+ROI_list_all(ROI_chronological_idx(2),2)...
            mean(curr_3D_map(curr_3D_map~=0)) ...
            std(curr_3D_map(curr_3D_map~=0)) ...
            100*std(curr_3D_map(curr_3D_map~=0))/mean(curr_3D_map(curr_3D_map~=0))];
        
        clear ROI_chronological_idx;
        
    end
    
    
    if  contains(ROIname,'ctx-lh')
        curr_ROI_name=ROIname(8:end);
        
        ROI_chronological_idx(1)=idx_labels;
        if find(Slice_labels_all==['ctx-rh-' curr_ROI_name])
        ROI_chronological_idx(2)=find(Slice_labels_all==['ctx-rh-' curr_ROI_name]);
        else
            continue;
        end
        %         ROI_FS_idx(Counter)=ROI_list_small(idx_labels,1);
        Slice_labels_all(end+1)=['ctx_' curr_ROI_name '_all'];
        curr_3D_map=T2_map_3D_all{ROI_chronological_idx(1)}+T2_map_3D_all{ROI_chronological_idx(2)};
        T2_map_3D_all{end+1}= curr_3D_map;
        Seg_ROI_3D_all{end+1}=Seg_ROI_3D_all{ROI_chronological_idx(1)}+Seg_ROI_3D_all{ROI_chronological_idx(2)};
        
        ROI_list_all(end+1,:)=[ 6000+idx_labels ...
            ROI_list_all(ROI_chronological_idx(1),2)+ROI_list_all(ROI_chronological_idx(2),2)...
            mean(curr_3D_map(curr_3D_map~=0)) ...
            std(curr_3D_map(curr_3D_map~=0)) ...
            100*std(curr_3D_map(curr_3D_map~=0))/mean(curr_3D_map(curr_3D_map~=0))];
        
        clear ROI_chronological_idx;
        
    end
    
end





