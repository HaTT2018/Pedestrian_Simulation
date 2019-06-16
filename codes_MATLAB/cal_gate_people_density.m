function gate_people_density = cal_gate_people_density(gate_x,gate_y,...
    gate_number, people_x,people_y,people_number, map_size,radius)

    people_in = zeros(gate_number,1);
    for i=1:gate_number
        for j=1:people_number
            distance=cal_distance([gate_x(i),gate_y(i)],[people_x(j),people_y(j)]);
            if distance<=radius
                people_in(i) = people_in(i) + 1;
            end
        end
    end
    
    %gate_in=zeros(gate_number,1);
    %for i=1:gate_number
    %    for j=1:map_size(1)
    %        for k = 1:map_size(2)
    %            distance = cal_distance([j,k],[gate_x(i),gate_y(i)]);
    %            if distance<=radius
    %                gate_in(i) = gate_in(i)+1;
    %            end
    %        end
    %    end
    %end
    gate_people_density = people_in; %./ gate_in;

end