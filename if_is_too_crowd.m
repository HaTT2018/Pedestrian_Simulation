function is_too_crowd = if_is_too_crowd(people_position,sence_v,grid_people_map)
    %遍历people_position 矩阵，判断每个点走下一步是否太拥挤，返回一个长度为人数的向量，假如太拥挤，该位置为0，否则为1
    people_number = numel(people_position(:,1));
    new_position = sence_v + people_position;
    crowd_vector = cal_crowd_people_number(grid_people_map,new_position);
    
    is_too_crowd1 = crowd_vector < 5;%假如too_crowd，该位置为0，否则为1
    
    is_too_crowd = ones(people_number,2);
    [r,~] = find(is_too_crowd1 == 0);
    
    is_too_crowd(r,:) = round(round([rand(numel(r),1),rand(numel(r),1)])-0.5);
    
end