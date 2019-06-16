function alt_position = generate_alt_position(people_position, field_of_map, map_size)

    x = round(people_position(:,1));
    y = round(people_position(:,2));
    
    corr_points_value = cal_field_value(x,y,field_of_map);
    
    left_x = x-1;
    right_x = x+1;
    up_y = y+1;
    down_y = y-1;
    
    left_x(left_x<1) = 1;
    right_x(right_x>map_size(1)) = map_size(1);
    up_y(up_y>map_size(2)) = map_size(2);
    down_y(down_y<1) = 1;
    
    
    surr_plus(:,1) = cal_field_value(right_x,y,field_of_map);%1��λ��
    surr_plus(:,2) = cal_field_value(x,down_y,field_of_map);%2��λ��
    surr_plus(:,3) = cal_field_value(left_x,y,field_of_map);%3��λ��
    surr_plus(:,4) = cal_field_value(x,up_y,field_of_map);%4��λ��
    

    surr_x(:,1) = cal_field_value(right_x,up_y,field_of_map);%5��λ��
    surr_x(:,2) = cal_field_value(right_x,down_y,field_of_map);%6��λ��
    surr_x(:,3) = cal_field_value(left_x,down_y,field_of_map);%7��λ��
    surr_x(:,4) = cal_field_value(left_x,up_y,field_of_map);%8��λ��
    
    
    %����numel(x)*8�ľ��󣬵ڶ�ά��Booleanֵ����ʾ�÷����Ƿ��ܶ���1Ϊ��
    alt_position = zeros(numel(x),8);
    
    alt_position(:,1) = surr_plus(:,1) - corr_points_value;%���Լ�����������
    alt_position(:,2) = surr_plus(:,2) - corr_points_value;
    alt_position(:,3) = surr_plus(:,3) - corr_points_value;
    alt_position(:,4) = surr_plus(:,4) - corr_points_value;
    alt_position(:,5) = surr_x(:,1) - corr_points_value;
    alt_position(:,6) = surr_x(:,2) - corr_points_value;
    alt_position(:,7) = surr_x(:,3) - corr_points_value;
    alt_position(:,8) = surr_x(:,4) - corr_points_value;
    
    alt_position(alt_position>=0) = 0;
    alt_position = alt_position ./ min(alt_position')';
    alt_position(alt_position~=1)=0;
    
end