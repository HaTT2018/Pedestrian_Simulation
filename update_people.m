function [people_position,velocity,alt_position] = update_people(gate_position,people_position,max_out_capacity,gate_scale,velocity,alt_position)
    
    gate_x = gate_position(:,1);
    gate_y = gate_position(:,2);
    people_x = people_position(:,1);
    people_y = people_position(:,2);
    people_number = numel(people_position(:,1));
    gate_number = numel(gate_x);
    
    for i=1:numel(gate_x)
        for j = 1:people_number
            distance(j,i) = cal_distance([gate_x(i),gate_y(i)],[people_x(j),people_y(j)]); %#ok<AGROW>
        end
    end
    
    [distance,min_index] = min(distance');
    
    distance = distance';
    min_index = min_index';
    %min_index是指“哪个门”
    
    [out_index,~] = find(distance<gate_scale);
    %out_index 是出去人的距离在distance里的索引,第几个人有可能出去
    gate_index = min_index(out_index);
    %这些人是从哪扇门出去的
    
    for i=1:gate_number
        if sum(gate_index==i)>max_out_capacity
            people_to_this_door_index = out_index(gate_index==i);
            cannot_out_index = choose(people_to_this_door_index,numel(people_to_this_door_index)-max_out_capacity);
            judge = ismember(out_index,cannot_out_index);
            out_index(judge) = [];
            gate_index(judge) = [];
        else
            
        end
    end
    
    
    ok_index = zeros(people_number,1);
    ok_index(out_index) = 1;
    ok_index=ok_index==1;

    people_position(ok_index(:),:) = [];
    velocity(ok_index(:,1),:) = [];
    alt_position(ok_index(:,1),:) = [];
end