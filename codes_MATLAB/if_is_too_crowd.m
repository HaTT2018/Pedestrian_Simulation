function is_too_crowd = if_is_too_crowd(people_position,sence_v,grid_people_map)
    %����people_position �����ж�ÿ��������һ���Ƿ�̫ӵ��������һ������Ϊ����������������̫ӵ������λ��Ϊ0������Ϊ1
    people_number = numel(people_position(:,1));
    new_position = sence_v + people_position;
    crowd_vector = cal_crowd_people_number(grid_people_map,new_position);
    
    is_too_crowd1 = crowd_vector < 5;%����too_crowd����λ��Ϊ0������Ϊ1
    
    is_too_crowd = ones(people_number,2);
    [r,~] = find(is_too_crowd1 == 0);
    
    is_too_crowd(r,:) = round(round([rand(numel(r),1),rand(numel(r),1)])-0.5);
    
end