function new_people_position = delete_wrong_people(map_pic,people_position,map_size)

    px = people_position(:,1);
    py = people_position(:,2);
    
    people_matrix = zeros(map_size);
    
    for i = 1:numel(px)
        people_matrix(px(i),py(i)) = 1;
    end
    
    people_matrix = (max(map_pic(:)) - map_pic) ./ max(map_pic(:)) .* people_matrix;
    
    
    new_people_position = [];
    for i=1:size(people_matrix,1)
        for j=1:size(people_matrix,2)
            if people_matrix(i,j) == 1
                new_people_position = [new_people_position;[i,j]]; %#ok<AGROW>
            end
        end
    end
end