
x=[1:12];

map_types={'T1','T2', 'T2s', 'QSM' ,'WF', 'MTVF', 'ADC', 'FA',  'MTRs',  'ihMTR'} ; 
for map_Idx=1:length (map_types)
    % map_type='PD';
    map_type=map_types{map_Idx};

if strcmp (map_type,'T1')
units='[ms]';
Mean_Val=[982 1335 1273 1015 1051 1195 1110 1455 1405 1411 1524 1423 ];      
SD_of_Mean= [22 43 61 31 42 35 49 56 137 120 79 40 ] ;   
Mean_of_SD=[144  111 109 69 254 151 192 126 195 212 203 291 ];
end
if strcmp (map_type,'T2')
% map_type='T2';
units='[ms]';
Mean_Val=[58.8  57.9 52.0 42.0 65.7 56.8 59.2 64.6 68.8 71.7 69.1 66.4 ];    
SD_of_Mean= [1.4  2.0 2.2 1.5 1.9 1.3 1.6 1.7 1.6 2.3 1.3 1.7 ] ;  
Mean_of_SD=[4.8  7.7 4.5 6.3 16.0 6.1 10.9 6.0 5.5 8.5 6.9 8.7 ];
end
if strcmp (map_type,'T2s')
map_type='T2*';
units='[ms]';
Mean_Val=[49.2  48.8 44.2 29.5 50.5 51.5 46.3 59.1 67.4 64.4 67.9 57.5 ];    
SD_of_Mean= [1.7  3.5 3.8 2.4 2.8 4.2 2.2 6.4 5.0 4.0 2.7 2.7 ] ;   
Mean_of_SD=[7.3  10.9 9.8 7.6 11.8 10.5 15.8 14.6 17.4 19.2 16.9 15.5 ];
end
if strcmp (map_type,'QSM')
% map_type='QSM';
units='[10^{-2} ppm]';
Mean_Val=[-0.76  8.49 7.65 20.14 3.40 3.67 2.48 1.53 -1.50 -0.55 0.35 0.45 ];     
SD_of_Mean= [0.39  1.40 1.97 2.46 1.18 0.95 1.28 2.83 0.97 1.17 0.69 0.23 ] ;    
Mean_of_SD=[3.71 3.49 5.21 7.22 4.76 4.18 8.95 5.01 3.68 4.32 3.93 4.12 ]; 
end
if strcmp (map_type,'WF')
% map_type='WF';
units='[%]';
Mean_Val=[70.5 79.6 78.0 70.3 71.9 75.7 73.1 80.9 80.2 80.0 81.2 79.5 ];     
SD_of_Mean= [0.8 1.0 1.8 1.1 1.2 0.9 1.3 1.7 2.9 2.9 1.7 1.1 ] ;    
Mean_of_SD=[4.5 2.3 2.5 2.7 4.8 3.7 5.1 2.6 4.5 4.6 3.8 10.1 ]; 
end
if strcmp (map_type,'MTVF')
% map_type='MTVF';
units='[%]';
Mean_Val=[29.5 20.4 22.0 29.7 28.1 24.3 26.9 19.1 19.8 20.0 18.8 20.5 ];     
SD_of_Mean= [0.8 1.0 1.8 1.1 1.2 0.9 1.2 1.7 2.9 2.9 1.7 1.1 ] ;    
Mean_of_SD=[4.5 2.3 2.5 2.7 4.8 3.7 5.1 2.6 4.5 4.6 3.8 10.1 ];
end
if strcmp (map_type,'ADC')
map_type='MD';
units='[10^{-4} mm^2/s]';
Mean_Val=[7.37 8.14 6.94 6.83 9.23 7.59 8.02 7.90 8.35 8.78 8.34 8.55 ];   
SD_of_Mean= [0.15 0.43 0.10 0.15 0.29 0.16 0.48 0.22 0.21 0.32 0.18 0.22] ;
Mean_of_SD=[0.52 1.99 0.40 0.51 2.01 1.17 2.09 0.57 1.51 1.45 0.91 1.52 ];
end
if strcmp (map_type,'FA')
% map_type='FA';
units='[0-1]';
Mean_Val=[0.41 0.17 0.20 0.33 0.61 0.32 0.46 0.23 0.19 0.18 0.18 0.17 ];   
SD_of_Mean= [0.01 0.01 0.01 0.03 0.03 0.01 0.04 0.04 0.01 0.01 0.01 0.01 ] ;
Mean_of_SD=[0.14  0.06 0.08 0.12 0.17 0.08 0.17 0.07 0.06 0.07 0.06 0.07 ];
end
if strcmp (map_type,'MTRs')
map_type='MTR';
units='[%]';
Mean_Val=[16.2 13.7 14.1 14.6 16.3 15.0 14.9 13.0 14.7 14.6 14.4 14.4 ];     
SD_of_Mean= [0.32 0.45 0.36 0.38 0.39 0.38 0.50 0.33 0.41 0.36 0.28 0.25] ;      
Mean_of_SD=[0.94 0.95 0.66 0.66 1.66 0.72 1.18 0.64 0.90 1.02 1.09 1.42]; 
end
if strcmp (map_type,'ihMTR')
% map_type='ihMTR';
units='[%]';
Mean_Val=[8.2 3.2 4.0 6.5 7.9 5.8 7.4 3.0 4.1 4.2 3.4 3.8 ];     
SD_of_Mean= [0.26 0.25 0.25 0.45 0.42 0.47 0.51 0.34 0.27 0.20 0.18 0.32 ] ;    
Mean_of_SD=[1.45 0.91 0.91 1.20 1.57 1.44 1.82 0.70 0.97 1.03 0.95 1.24 ]; 
end

%% Plot

figure;
bar(x,Mean_Val, 'FaceColor', '#c8dbde', 'EdgeColor','#81989c')                
title (map_type)
hold on

er = errorbar(x-0.2,Mean_Val,SD_of_Mean,SD_of_Mean);
er.Color = '#104b73';                            
er.LineStyle = 'none'; 
er.LineWidth=1;

er2 = errorbar(x+0.2,Mean_Val,Mean_of_SD,Mean_of_SD, 'Color', '#a2142f');                           
er2.LineStyle = 'none'; 
er2.LineWidth=1;

xtickangle(45)
ytickangle(90)

xlabel('Brain ROI')
xticklabels({'cerebral-WM', 'CN','putamen','pallidum','CC','thalamus','Ventral-DC','accumbens area','amygdala','hippocampus','insular cortex','cortex-all'})

ylabel (sprintf('%s %s', map_type, units))

% legend ('Mean value','inter-subject variability', 'Intra-ROI variability')
grid on

end
