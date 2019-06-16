function result = choose(vector, number)
    index = randperm(numel(vector));
    chosen_index = index(1:number);
    result = vector(chosen_index);

end