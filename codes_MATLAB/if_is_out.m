function is_out = if_is_out(people_position,sence_v,field_of_map)
%����people_position �����ж�ÿ�����Ƿ�out������һ������Ϊ����������������out����λ��Ϊ0������Ϊ1
    new_position = sence_v + people_position;
    fitness_vector = cal_fitness2(field_of_map,new_position);
    
    is_out = fitness_vector < max(field_of_map(:));%����out����λ��Ϊ0������Ϊ1
end