function distance = cal_distance(p1,p2)
    res_p2 = abs(p2-p1);
    distance = min(res_p2)*2^0.5 + ...
        max(res_p2) - min(res_p2);
end