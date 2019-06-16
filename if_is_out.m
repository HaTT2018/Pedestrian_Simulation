function is_out = if_is_out(people_position,sence_v,field_of_map)
%遍历people_position 矩阵，判断每个点是否out，返回一个长度为人数的向量，假如out，该位置为0，否则为1
    new_position = sence_v + people_position;
    fitness_vector = cal_fitness2(field_of_map,new_position);
    
    is_out = fitness_vector < max(field_of_map(:));%假如out，该位置为0，否则为1
end