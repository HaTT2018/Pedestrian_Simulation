function fitness2 = cal_fitness2(fitness_matrix,people_position)
    px = people_position(:,1);
    py = people_position(:,2);
    
    fitness2 = fitness_matrix(sub2ind(size(fitness_matrix),px,py));
end