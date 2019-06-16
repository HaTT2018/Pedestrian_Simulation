function field = generate_map_field(gate_position,map_size)
    
    f1 = zeros(map_size);
    f2 = zeros(map_size);
    f3 = zeros(map_size);
    f4 = zeros(map_size);
    
    x_cordnts = gate_position(:,1);
    y_cordnts = gate_position(:,2);
    
    for s = 1:4
        for i = 1:map_size(1)
            for j = 1:map_size(2)
                if s==1
                    f1(i,j) = cal_distance([i,j],[x_cordnts(s),y_cordnts(s)]);
                elseif s==2
                	f2(i,j) = cal_distance([i,j],[x_cordnts(s),y_cordnts(s)]);
                elseif s==3
                    f3(i,j) = cal_distance([i,j],[x_cordnts(s),y_cordnts(s)]);
                elseif s==4
                    f4(i,j) = cal_distance([i,j],[x_cordnts(s),y_cordnts(s)]);
                end
            end
        end
    end
    
    for i = 1:map_size(1)
        for j = 1:map_size(2)
            field(i,j) = min([f1(i,j),f2(i,j),f3(i,j),f4(i,j)]); %#ok<AGROW>
        end
    end
end