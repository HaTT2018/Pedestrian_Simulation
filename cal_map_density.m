function map_density = cal_map_density(x,y,people_position,map_size,radius)

    people_number = numel(people_position(:,1));
    px = people_position(:,1);
    py = people_position(:,2);
    
    people_in = 0;
    for i =1:people_number
        distance = cal_distance([x,y],[px(i),py(i)]);
        if distance < radius
            people_in=people_in+1;
        end
    end
    
    map_density = people_in;% / point_in;
end