function crowd_people_number = cal_crowd_people_number(grid_people_map,people_position)
    px = people_position(:,1);
    py = people_position(:,2);
    
    crowd_people_number = grid_people_map(sub2ind(size(grid_people_map),px,py));
end