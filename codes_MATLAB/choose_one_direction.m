function alt_position = choose_one_direction(alt_position)
    
    pos_size = size(alt_position);
    r = alt_position .* rand(pos_size);
    r = r./max(r')';
    r(r~=1)=0;
    alt_position = r;
end