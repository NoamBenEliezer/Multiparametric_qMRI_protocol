clear

results_fol='...\Results\qMRI_valuesinROIs'; 

map_types={'T1', 'T2', 'T2s', 'QSM', 'WF', 'MTVF', 'ADC', 'FA', 'MTRs', 'ihMTR'} ;
color_palete={'#CC3B7C','#0072BD', '#A2142F',	'#D95319', '#EDB120', '#7E2F8E', '#77AC30', '#4DBEEE', 'k', '#56704B'};


for map_idx=1:length (map_types)
    map_types{map_idx}
    load ([results_fol filesep sprintf('%s_results.mat', map_types{map_idx})])
    % result_mat_ses1=All_volunteer_session_1_retest;
    result_mat_ses1=All_volunteer_session_1(:, [1:8 13:68 73:76 85:88 93:112]);
    
    result_mat_ses2=All_volunteer_session_2;
    
     
    N_ROI=size(result_mat_ses1,1); %15
    N_vol=size(result_mat_ses1,2)/4; %24
    
        SD_mat_ses1=result_mat_ses1(:,3:4:N_vol*4-1);
    SD_mat_ses2=result_mat_ses2(:,3:4:N_vol*4-1);
    
    result_mat_ses1=result_mat_ses1(:,2:4:N_vol*4-2);
    result_mat_ses2=result_mat_ses2(:,2:4:N_vol*4-2);

    
    % sort the data into vector
    for i=1:N_vol
        for j=1:N_ROI
            result_vec_ses1(N_ROI*(i-1)+j,1)=result_mat_ses1(j,i);
            result_vec_ses2(N_ROI*(i-1)+j,1)=result_mat_ses2(j,i);
            SD_vec_ses1(N_ROI*(i-1)+j,1)=SD_mat_ses1(j,i);
            SD_vec_ses2(N_ROI*(i-1)+j,1)=SD_mat_ses2(j,i);      
        end
    end
    
    if length (result_vec_ses1)~=length(result_vec_ses2)
        error ('Error: check the matrix size')
    end
    
%     result_vec_ses1=result_vec_ses1*100;
%     result_vec_ses2=result_vec_ses2*100;
    
    diff_vec=result_vec_ses1-result_vec_ses2;
    avg_vec=(result_vec_ses1+result_vec_ses2)/2;
    

    P = polyfit(avg_vec,diff_vec,1);
%     yfit = P(1)*x+P(2);
    [R, P_val] = corrcoef(avg_vec,diff_vec); R_sq=(R(1,2)^2);
%       P_val(1,2);
%     clear result_vec_ses1 result_vec_ses2
        
    diff_mean=mean(diff_vec);
    diff_SD=std(diff_vec);
    upper_lim=diff_mean+1.96*diff_SD;
    lower_lim=diff_mean-1.96*diff_SD;
    
    BA_mat_summery (1:8,map_idx)=[diff_mean;diff_SD;upper_lim;lower_lim;P(1);P(2);R(1,2);P_val(1,2)]; 
    
 

    
    %  Bland-Altman Plot Session 1 vs Session 2
    figure; % plot by ROI
    hold on;
    sz = 40;
    Five_color=0;
    if Five_color
        color_palete={'#0072BD', '#A2142F',	'#D95319', '#EDB120', '#7E2F8E'};
    else
        color_palete={'#CC3B7C','#0072BD', '#A2142F',	'#D95319','#005594', '#EDB120','#7a5230', '#7E2F8E', '#77AC30', '#4DBEEE', 'k', '#56704B', };
    end
    
    % blue, red, orange, yellow, purple, '#77AC30'-green '#4DBEEE'-light blue
    for ROI_idx=1:N_ROI
        if Five_color
            color_loc=mod(ROI_idx,5);
            if color_loc==0
                color_loc=5;
            end
            if ROI_idx <= 5
                shape= string('o'); % Circle
            elseif ROI_idx > 5 && ROI_idx <= 10
                shape=string('d'); % diamond
            elseif ROI_idx > 10
                shape=string('x'); % Cross
            end
        else
           color_loc=ROI_idx;
            if ROI_idx <= 4
                shape= string('o'); % Circle
            elseif ROI_idx > 4 && ROI_idx <= 8
                shape=string('d'); % diamond
            elseif ROI_idx > 8
                shape=string('x'); % Cross
            end
        end
        
        
        
        scatter(avg_vec(ROI_idx:N_ROI:(N_vol-1)*N_ROI+ROI_idx,1),...
            diff_vec(ROI_idx:N_ROI:(N_vol-1)*N_ROI+ROI_idx,1),...
            sz,shape, 'MarkerEdgeColor',color_palete{color_loc});
        
    end
    grid on
    
    
    x_vec=min(xlim):0.01:max(xlim);
    lower_lim_vec=lower_lim*ones(length(x_vec),1);
    upper_lim_vec=upper_lim*ones(length(x_vec),1);
    diff_mean_vec=diff_mean*ones(length(x_vec),1);
    plot(x_vec,lower_lim_vec,'--','Color', [17 17 17]/255, 'LineWidth',2)
    plot(x_vec,upper_lim_vec,'--','Color', [17 17 17]/255, 'LineWidth',2)
    plot(x_vec,diff_mean_vec, 'k', 'LineWidth',1)
    xlabel('Average')
    ylabel('Difference')
    
    
%     legend('Cerebral-WM','Caudate', 'Putamen','Pallidum','CC', 'Thalamus', 'Ventral DC',...
%         'Accumbens-area', 'Amygdala', 'Hippocampus', 'Insular cortex', 'Cortex - all')
    
    title(sprintf('%s values',map_types{map_idx}));
    
    % Values for statistics
    
         
    for ROI_idx=1:N_ROI
        curr_vec_ses1=result_vec_ses1(ROI_idx:N_ROI:N_ROI*(N_vol-1)+ROI_idx);
        curr_vec_ses2=result_vec_ses2(ROI_idx:N_ROI:N_ROI*(N_vol-1)+ROI_idx);
             curr_SD_vec_ses1=SD_vec_ses1(ROI_idx:N_ROI:N_ROI*(N_vol-1)+ROI_idx);
        curr_SD_vec_ses2=SD_vec_ses2(ROI_idx:N_ROI:N_ROI*(N_vol-1)+ROI_idx);  
        

    stats_mat((map_idx-1)*N_ROI+ROI_idx,1)= mean (curr_vec_ses1); % mean ses 1
    stats_mat((map_idx-1)*N_ROI+ROI_idx,2)= std (curr_vec_ses1); % SD between means
    stats_mat((map_idx-1)*N_ROI+ROI_idx,3)= mean (curr_SD_vec_ses1); % mean of SD (across volunteers)
    stats_mat((map_idx-1)*N_ROI+ROI_idx,4)= mean (curr_vec_ses2);
    stats_mat((map_idx-1)*N_ROI+ROI_idx,5)= std (curr_vec_ses2);
        stats_mat((map_idx-1)*N_ROI+ROI_idx,6)= mean (curr_SD_vec_ses2);

    relative_diff_means=100*abs(((mean (curr_vec_ses1)-mean (curr_vec_ses2))./mean (curr_vec_ses1)));
    stats_mat((map_idx-1)*N_ROI+ROI_idx,7)= relative_diff_means; % percentage % diff between means
    relative_diff=100*abs(((curr_vec_ses1-curr_vec_ses2)./curr_vec_ses1));
    stats_mat((map_idx-1)*N_ROI+ROI_idx,8)= mean(relative_diff); % mean of % diff (across volunteers)
    
        
   end
    
end

       save ([results_fol filesep 'SummeryTables' filesep 'BlandAltman_Summery.mat'], 'BA_mat_summery')

