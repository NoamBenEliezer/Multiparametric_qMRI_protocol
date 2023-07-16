
% clear all; clc

function [Label_num, Label_name] = Label_reader ()

fid = fopen('FS_Color_label_list');
tline = fgetl(fid);
Labels_counter=0;
while ischar(tline)
    if (length (tline)>10 && tline(1)~='#' && tline(1)~='*')
            Labels_counter=Labels_counter+1;

%     disp (tline)
    
 Space_loc=find(tline==' ');
 Space_loc_new=Space_loc;
 for i=1:length(Space_loc)-2
     if (Space_loc(i+1)== Space_loc(i)+1 && Space_loc(i+2)== Space_loc(i)+2)
         Space_loc_new (i+1)=0;             
     end
 end
 if (Space_loc_new(2)~=0 && Space_loc_new(2)~=Space_loc_new(1)+1)
 Space_loc_new=[Space_loc_new(1) Space_loc_new(1) Space_loc_new(2:end)];
 end
 Space_loc_new=Space_loc_new(Space_loc_new~=0);

%  Label_num{Labels_counter}=tline(1:Space_loc(1)-1); %char2num
 Label_num(Labels_counter)=str2num(tline(1:Space_loc_new(1)-1)); %char2num
% disp(tline((Space_loc_new(2)+1):(Space_loc_new(3)-1)));
 Label_name{Labels_counter}=tline((Space_loc_new(2)+1):(Space_loc_new(3)-1));

    end
        tline = fgetl(fid);
end
fclose(fid);