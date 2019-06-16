function new_global_direction = cal_global_direction(global_direction)
    for i=1:size(global_direction,1)
        if global_direction(i,1)==1 && global_direction(i,4)==1
            global_direction(i,5)=1;
        elseif global_direction(i,1)==1 && global_direction(i,4)==-1
            global_direction(i,6)=1;
        elseif global_direction(i,1)==-1 && global_direction(i,4)==1
            global_direction(i,8)=1;
        elseif global_direction(i,1)==-1 && global_direction(i,4)==-1
            global_direction(i,7)=1;
        end
    end
    new_global_direction = [zeros(numel(global_direction(:,1)),4),global_direction(:,5:8)];
end