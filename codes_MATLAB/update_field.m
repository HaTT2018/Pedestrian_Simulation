function new_field = update_field(people_position, field_of_map)
    
    x = people_position(:,1);
    y = people_position(:,2);
    x(x<1) = 1;
    y(y<1) = 1;
    
    field_of_map(x,y) = Inf;
    new_field = field_of_map;

end