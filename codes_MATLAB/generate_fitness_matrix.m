function [fitness_matrix,gate_index_matrix] = ...
    generate_fitness_matrix(people_position,gate_position,map_size,radius,alpha,map_of_level)
    
    gate_x = gate_position(:,1);
    gate_y = gate_position(:,2);
    size_gate=size(gate_position);
    gate_number=size_gate(1);

    people_x = people_position(:,1);
    people_x(people_x<1) = 1;
    people_y = people_position(:,2);
    people_y(people_y<1) = 1;
    
    size_people = size(people_position);
    people_number = size_people(1);
    
    d_point_gate = zeros(map_size(1),map_size(2),gate_number);
    %---------------------------------------------------------
    %background data above
    %---------------------------------------------------------
    
    
    
    
    
    rho = cal_gate_people_density(gate_x,gate_y,gate_number, ...
        people_x,people_y,people_number, map_size,radius);
    %calculate how many people there are near each gates within a radius of 'radius'
    
    [original_x,original_y] = meshgrid(1:map_size(2),1:map_size(1));
    parfor i=1:gate_number
        x = abs(original_x - gate_y(i));
        y = abs(original_y - gate_x(i));
        d_point_gate(:,:,i) = min(x,y) .* 2^0.5 + max(x,y) - min(x,y);
    end
    
    
    
    rho = reshape(rho,1,1,numel(rho)) .* ones(map_size(1),map_size(2),gate_number);
    
    fitness_matrix = alpha * rho + (1-alpha) * d_point_gate;%0.000727s
    
    [fitness_matrix,gate_index_matrix] = min(fitness_matrix,[],3);%0.000581s
    m = max(fitness_matrix(:));
    
    %when there exist a wall, the value of potential field near the walls
    %will be raised up by an offset linearly
    [raise_x, raise_y] = find(map_of_level'==150);
    number_of_raise_point = numel(raise_x);
    parfor i=1:number_of_raise_point
        x = abs(original_x - raise_y(i));
        y = abs(original_y - raise_x(i));
        d_point_wall(:,:,i) = 1./(1 - (max(m - (min(x,y) .* 2^0.5 + max(x,y) - min(x,y)),0)./m));
    end
    fitness_matrix = fitness_matrix+max(d_point_wall,[],3);
    
    fitness_matrix(map_of_level'==250) = 2*max(fitness_matrix(:));
    
    
    
    
    
end