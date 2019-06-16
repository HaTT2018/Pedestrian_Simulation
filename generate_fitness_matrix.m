function [fitness_matrix,gate_index_matrix] = generate_fitness_matrix(people_position,gate_position,map_size,radius,alpha)
    
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
    
    rho = cal_gate_people_density(gate_x,gate_y,gate_number, ...
        people_x,people_y,people_number, map_size,radius);    
    
    [original_x,original_y] = meshgrid(1:map_size(2),1:map_size(1));
    for i=1:gate_number
        x = abs(original_x - gate_y(i));
        y = abs(original_y - gate_x(i));
        d_point_gate(:,:,i) = min(x,y) .* 2^0.5 + max(x,y) - min(x,y);
    end
    
    surface = ones(map_size(1),map_size(2),gate_number);
    %tic
    rho = reshape(rho,1,1,numel(rho)).*surface;
    fitness_matrix = alpha * rho + (1-alpha) * d_point_gate;
    
    for i = 1:gate_number
        new_fitness_matrix(i,:,:) = fitness_matrix(:,:,i); %#ok<AGROW>
    end
    %new_fitness_matrix(2,:,:) = fitness_matrix(:,:,2);
    %new_fitness_matrix(3,:,:) = fitness_matrix(:,:,3);
    %toc
    
    [min_fitness_matrix_rough,gate_index_matrix_rough] = min(new_fitness_matrix);
    gate_index_matrix = reshape(gate_index_matrix_rough,map_size);
    min_fitness_matrix = reshape(min_fitness_matrix_rough,map_size);

    fitness_matrix = min_fitness_matrix;
    %for i = 1:map_size(1)
    %    for j = 1:map_size(2)
     %       d_single_point_gate = d_point_gate(i,j,:);
     %       [fitness_matrix(i,j),gate_index] = min(alpha .* rho + (1-alpha) .* d_single_point_gate(:));
     %   end
    %end
    
end