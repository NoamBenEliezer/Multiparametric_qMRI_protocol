function[ROI_list_LR, Slice_labels_LR , qMRI_map_3D_LR, Seg_ROI_3D_LR]... 
    = Top_LR_ROIs_BA (ROI_list_all, Slice_labels_all , qMRI_map_3D_all, Seg_ROI_3D_all)


Top_11_list={'Cerebral-White-Matter','Caudate', 'Putamen','Pallidum', 'Thalamus-Proper*', 'VentralDC', 'Accumbens-area', ...
    'Amygdala', 'Hippocampus','ctx%sinsula', 'ctx%s'};

Top_LR_list={'Left-', 'Right-'};


ROIs_loc=[];
excluded_ROIs=[];
for i= 1:length(Top_11_list)
    for j=1:length (Top_LR_list)
        
        if strcmp(Top_LR_list{j}, '_all')
            curr_name=[Top_11_list{i} Top_LR_list{j}];
            if strfind (Top_11_list{i}, 'ctx')
                curr_name=[sprintf(Top_11_list{i},"_") Top_LR_list{j}];
            end
        else
            curr_name=[Top_LR_list{j} Top_11_list{i}];
            if strfind (Top_11_list{i}, 'ctx')
                if strcmp(Top_LR_list{j}, 'Left-')
                    curr_name=[sprintf(Top_11_list{i},"-lh-")];
                    if Top_11_list{i}=="ctx%s"
                        qMRI_map_3D_ctx_lh=zeros(size(qMRI_map_3D_all{1}));
                        Seg_ROI_3D_ctx_lh=qMRI_map_3D_ctx_lh;
                        ROIS_loc_ctx=strfind(Slice_labels_all ,string(curr_name));
                        ROIS_loc_ctx_list=[];
                        for ctx_ROI=1:length (ROIS_loc_ctx)
                            if ROIS_loc_ctx{ctx_ROI}==1
                                ROIS_loc_ctx_list=[ROIS_loc_ctx_list ctx_ROI];
                                qMRI_map_3D_ctx_lh=qMRI_map_3D_ctx_lh+qMRI_map_3D_all{ctx_ROI};
                                Seg_ROI_3D_ctx_lh=Seg_ROI_3D_ctx_lh+Seg_ROI_3D_all{ctx_ROI};
                            end
                        end
                        
%                         Ctx_list_lh_1=[sum(ROI_list_all(ROIS_loc_ctx_list ,2)) mean(ROI_list_all(ROIS_loc_ctx_list ,3))...
%                             std(ROI_list_all(ROIS_loc_ctx_list ,3)) 100*std(ROI_list_all(ROIS_loc_ctx_list ,3))/mean(ROI_list_all(ROIS_loc_ctx_list ,3))];
                        Ctx_list_lh=[numel(find(qMRI_map_3D_ctx_lh~=0)) mean(qMRI_map_3D_ctx_lh(qMRI_map_3D_ctx_lh~=0))...
                            std(qMRI_map_3D_ctx_lh(qMRI_map_3D_ctx_lh~=0)) 100*std((qMRI_map_3D_ctx_lh(qMRI_map_3D_ctx_lh~=0)))/mean((qMRI_map_3D_ctx_lh(qMRI_map_3D_ctx_lh~=0)))];
                        
                        
                    end
                elseif strcmp(Top_LR_list{j}, 'Right-')
                    curr_name=[sprintf(Top_11_list{i},"-rh-")];
                    if Top_11_list{i}=="ctx%s"
                        qMRI_map_3D_ctx_rh=zeros(size(qMRI_map_3D_all{1}));
                        Seg_ROI_3D_ctx_rh=qMRI_map_3D_ctx_rh;
                        ROIS_loc_ctx=strfind(Slice_labels_all ,string(curr_name));
                        ROIS_loc_ctx_list=[];
                        for ctx_ROI=1:length (ROIS_loc_ctx)
                            if ROIS_loc_ctx{ctx_ROI}==1
                                ROIS_loc_ctx_list=[ROIS_loc_ctx_list ctx_ROI];
                                qMRI_map_3D_ctx_rh=qMRI_map_3D_ctx_rh+qMRI_map_3D_all{ctx_ROI};
                                Seg_ROI_3D_ctx_rh=Seg_ROI_3D_ctx_rh+Seg_ROI_3D_all{ctx_ROI};
                            end
                        end
%                         Ctx_list_rh=[sum(ROI_list_all(ROIS_loc_ctx_list ,2)) mean(ROI_list_all(ROIS_loc_ctx_list ,3))...
%                             std(ROI_list_all(ROIS_loc_ctx_list ,3)) 100*std(ROI_list_all(ROIS_loc_ctx_list ,3))/mean(ROI_list_all(ROIS_loc_ctx_list ,3))];
                           Ctx_list_rh=[numel(find(qMRI_map_3D_ctx_rh~=0)) mean(qMRI_map_3D_ctx_rh(qMRI_map_3D_ctx_rh~=0))...
                            std(qMRI_map_3D_ctx_rh(qMRI_map_3D_ctx_rh~=0)) 100*std((qMRI_map_3D_ctx_rh(qMRI_map_3D_ctx_rh~=0)))/mean((qMRI_map_3D_ctx_rh(qMRI_map_3D_ctx_rh~=0)))];
                        
                    end
                end
            end
            
        end
        
        if Top_11_list{i}=="ctx%s"
            ROIs_loc=[ROIs_loc 1000];
        elseif find(Slice_labels_all==curr_name)
            ROIs_loc=[ROIs_loc find(Slice_labels_all==curr_name)];
        else
            %         ROIs_loc=[ROIs_loc 0];
            excluded_ROIs=[excluded_ROIs i];
        end
        
        
        
    end
end


    if ~Top_11_list{end}=='ctx%s'
ROI_list_LR     = ROI_list_all (ROIs_loc , 2:5);
Slice_labels_LR = Slice_labels_all (ROIs_loc);
qMRI_map_3D_LR    = qMRI_map_3D_all (ROIs_loc);
Seg_ROI_3D_LR   = Seg_ROI_3D_all (ROIs_loc);
    else
       ROI_list_LR     = ROI_list_all (ROIs_loc(1:20) , 2:5);
Slice_labels_LR = Slice_labels_all (ROIs_loc(1:20));
qMRI_map_3D_LR    = qMRI_map_3D_all (ROIs_loc(1:20));
Seg_ROI_3D_LR   = Seg_ROI_3D_all (ROIs_loc(1:20));

ROI_list_LR (21, 1:4)=Ctx_list_lh;
ROI_list_LR (22, 1:4)=Ctx_list_rh;
Slice_labels_LR(end+1:end+2)=["ctx_lh_all"; "ctx_rh_all"];

qMRI_map_3D_LR {21}=qMRI_map_3D_ctx_lh;
qMRI_map_3D_LR {22}=qMRI_map_3D_ctx_rh;
Seg_ROI_3D_LR {21}=Seg_ROI_3D_ctx_lh;
Seg_ROI_3D_LR {22}=Seg_ROI_3D_ctx_rh;

end




if length(excluded_ROIs)==1
    for j=15:-1:excluded_ROIs+1
        ROI_list_LR(j, 1:4)=ROI_list_LR(j-1, 1:4);
    end
    ROI_list_LR(excluded_ROIs,1:4)=[0 0 0 0];
elseif length(excluded_ROIs)>1
    disp ('Error!')
end

end
