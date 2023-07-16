close all
clear

results_fol='...\Results\qMRI_valuesinROIs'; 
map_types={'T1', 'T2', 'T2s', 'QSM', 'WF', 'MTVF', 'ADC', 'FA', 'MTRs', 'ihMTR'} ; %, 'PD', 'M0' 
        color_palete={'#CC3B7C','#0072BD', '#A2142F',	'#D95319', '#EDB120','#7a5230', '#7E2F8E', '#77AC30', '#4DBEEE', 'k', '#56704B' };


%% Right-Left plot with liner fitting


for map_idx=1:length (map_types)
    
load ([results_fol filesep sprintf('%s_results_LR.mat', map_types{map_idx})])
Curr_mat=All_volunteer_session_1_LR;

% Replace V035 ses 1
% A=All_volunteer_session_2_LR(:,73:76);
% Curr_mat (:, 89:92)=A;

N_vol=size(Curr_mat, 2)/4; % N voxels, mean, SD, CV
N_ROIs=size(Curr_mat, 1) / 2; % Left, right

Left_vec=Curr_mat(1:2:size(Curr_mat, 1)-1, 2:4:size(Curr_mat, 2)-2); % mean values only
Right_vec=Curr_mat(2:2:size(Curr_mat, 1), 2:4:size(Curr_mat, 2)-2); % mean values only   
    
figure;hold on
for k=1:1:N_ROIs
%                color_loc=ROI_idx;
            if k <= 4
                shape= string('o'); % Circle
            elseif k > 4 && k <= 7
                shape=string('d'); % diamond
            elseif k > 7
                shape=string('x'); % Cross
            end
scatter(Left_vec(k,:), Right_vec(k,:), shape, 'MarkerEdgeColor', color_palete{k})

end
grid on


% cftool(Left_vec, Right_vec)

min_x=min(min(Left_vec))- 0.1*min(min(Left_vec));
max_x=max(max(Left_vec))+ 0.1*min(min(Left_vec));

x=min_x:0.001:max_x;

P = polyfit(Left_vec,Right_vec,1);
    yfit = P(1)*x+P(2);
    hold on;
    plot(x,yfit,'k-.');
    
%     legend({'Cerebral-WM','Caudate', 'Putamen','Pallidum', 'Thalamus', 'VentralDC', 'Accumbens-area',...
%     'Amygdala', 'Hippocampus','Insular cortex', 'Cortex'})
    
    title(sprintf('map type = %s', map_types{map_idx}))
xlabel('Right Hemisphere');
ylabel('Left Hemisphere');

text(min_x,max(yfit)-0.05*max(yfit),sprintf('y=%.2f*x+%.2f',P(1),P(2)));


[R,p_val]= corrcoef(Left_vec,Right_vec); R_sq(map_idx)=(R(1,2)^2); r_coeff(map_idx)=R(1,2);
text(min_x,max(yfit)-0.1*max(yfit),sprintf('R^2=%.3f',R_sq(map_idx)));
map_types{map_idx}
p_val(1,2)
end


%% Right-Left plot Per ROI
% Left=All_volunteer_session_1_LR([1:3:19 23],:);
% Left_T2=Left(:, 2:4:118);
% Right=All_volunteer_session_1_LR([2:3:20 22],:);
% Right_T2=Right(:, 2:4:118);
% 
% color_palete={'k', '#0072BD', '#A2142F',	'#D95319', '#EDB120', '#7E2F8E', '#77AC30', '#4DBEEE'}; 
%     figure;hold on
% for k=1:1:8
% scatter(k*ones(1,30), Left_T2(k,:), 'd' , 'MarkerEdgeColor', color_palete{k})
% scatter(k*ones(1,30), Right_T2(k,:), 'o', 'MarkerEdgeColor', color_palete{k})
% end
% grid on
% ylim ([35 78])
% xlim ([.75 8.25])
% xticklabels({'Cerebral-WM','Caudate', 'Putamen','Pallidum', 'Thalamus', ...
%     'Amygdala', 'Hippocampus','Insular cortex'});
% ylabel('T_2 [ms]')