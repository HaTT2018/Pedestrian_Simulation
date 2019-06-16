function velocity = update_velocity(fitness, people_position,...
                    alt_position, w, c1, c2, old_velocity, sight,max_velocity,interval)

    global_alt_direction = generate_global_alt_diretion(sight,people_position,fitness);
    
    
    
    people_number = numel(people_position(:,1));%计算人数
    
    velocity = w .* old_velocity + c1 .* rand(people_number, 8) .* alt_position...
               + c2 .* rand(people_number,8) .* global_alt_direction;

    max_velocity = max_velocity * interval / 0.5;
    
    speed = sum(abs(velocity).^2,2).^(1/2);
    speed(speed>max_velocity) = max_velocity;
    
    velocity = speed .* velocity ./ (sum(abs(velocity).^2,2).^(1/2));%速率乘速度方向
end