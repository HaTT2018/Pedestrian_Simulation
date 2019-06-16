function field_value = cal_field_value(x_vector,y_vector,field_of_map)

    for i = 1:numel(x_vector)
        field_value(i) = field_of_map(x_vector(i),y_vector(i)); %#ok<AGROW>
    end
    field_value = field_value';

end