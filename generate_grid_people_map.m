function grid_people_map = generate_grid_people_map(people_position,map_size)
    px = people_position(:,1);
    py = people_position(:,2);
    people_number = numel(px);
    
    %people_number_vector =
    
    for i = 1:people_number
        people_number_vector(i) = sum(px==px(i)); %#ok<AGROW>
    end
    
    grid_people_map = zeros(map_size);
    for i = 1:people_number
        grid_people_map(px(i),py(i)) = people_number_vector(i);
    end
end