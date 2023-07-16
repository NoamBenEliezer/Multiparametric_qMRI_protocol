function [ROI_list_12, Slice_labels_12 , T2_map_3D_12, Seg_ROI_3D_12]...
    = Top_12_ROIs (ROI_list_all, Slice_labels_all , T2_map_3D_all, Seg_ROI_3D_all)

Top_12_list={'Cerebral-White-Matter_all','Caudate_all', 'Putamen_all','Pallidum_all','CC_all', 'Thalamus-Proper*_all', 'VentralDC_all',...
    'Accumbens-area_all', 'Amygdala_all', 'Hippocampus_all',  'ctx_insula_all', 'ctx_all'}; %'Brain-Stem', 'Cerebellum-White-Matter_all', 'Cerebellum-Cortex_all',

ROIs_loc=[];
excluded_ROIs=[];
for i= 1:length(Top_12_list)
    if find(Slice_labels_all==Top_12_list{i})
       ROIs_loc=[ROIs_loc find(Slice_labels_all==Top_12_list{i})];
    else 
%         ROIs_loc=[ROIs_loc 0];
        excluded_ROIs=[excluded_ROIs i];
    end
end
    
%    
ROI_list_12     = ROI_list_all (ROIs_loc , 2:5);
Slice_labels_12 = Slice_labels_all (ROIs_loc); 
T2_map_3D_12    = T2_map_3D_all (ROIs_loc);
Seg_ROI_3D_12   = Seg_ROI_3D_all (ROIs_loc);
if length(excluded_ROIs)==1
    for j=12:-1:excluded_ROIs+1
        ROI_list_12(j, 1:4)=ROI_list_12(j-1, 1:4);
    end
    ROI_list_12(excluded_ROIs,1:4)=[0 0 0 0];
elseif length(excluded_ROIs)>1
    disp ('Error!')
end
end



