function global_alt_direction = generate_global_alt_diretion(sight,people_position,fitness)
    people_number = numel(people_position(:,1));
    px = people_position(:,1);
    py = people_position(:,2);
    
    min_surr_fitness_vector = fitness;
    for i = 1:people_number
        for j=1:people_number
            dist = cal_distance([px(i),py(i)],[px(j),py(j)]);
            if dist <= sight
                if fitness(j) <= min_surr_fitness_vector(i)
                    min_surr_fitness_vector(i) = fitness(j);
                    process_global_alt_direction(i,:) = [px(j)-px(i),py(j)-py(i)]; %#ok<AGROW>
                end
            end
        end
    end
    
    
    
    
    
    
    
    %d_m = zeros(people_number,1);
    %global_alt_direction = [process_global_alt_direction(:,1),d_m,d_m,process_global_alt_direction(:,2),d_m,d_m,d_m,d_m];
    process_global_alt_direction(process_global_alt_direction~=0)...
                                    = process_global_alt_direction(process_global_alt_direction~=0)...
                                    ./ abs(process_global_alt_direction(process_global_alt_direction~=0));
    process_global_alt_direction = [process_global_alt_direction(:,1),zeros(people_number,2),process_global_alt_direction(:,2),zeros(people_number,4)];
    global_alt_direction = cal_global_direction(process_global_alt_direction);
end