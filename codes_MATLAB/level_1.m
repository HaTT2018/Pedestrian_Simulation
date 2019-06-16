clc
clear

map_of_level = imread('C:\Users\10169\Desktop\louvre\1_modi.jpg');%%%%%%%%%%%%%%%%%%%%
map_of_level = double(rgb2gray(map_of_level));
map_of_level(map_of_level<150) = 0;
map_of_level(map_of_level>150) = 200;

map_of_louvre = map_of_level';%生成卢浮宫地图

map_size = size(map_of_louvre);

level = 1;%%%%%%%%%%%%%%%%%%%%
figure_name = 'level 1';%%%%%%%%%%%%%%%%%%%%
route_matrix = [];
people_number_matrix = [];
iterate_times = 1;
alpha = 0.5;
c1=1.5;
c2=3;
max_velocity = 1 ;%meter per second
interval = 0.5 / max_velocity;
max_iterate_times = 300;
radius = 3;
max_out_capacity = 5;
gate_scale = 3;%格
sight = 30;%视野

%生成随机people
people_position = rand(100000,2);%%%%%%%%%%%%%%%%%%%%
people_position(:,1) = round(people_position(:,1)*map_size(1));
people_position(:,2) = round(people_position(:,2)*map_size(2));
people_position(people_position==0)=1;

people_position = delete_wrong_people(map_of_level',people_position,map_size);
%删去在外面的人

gate_position = [
                255 65;
                550 170;
                815 175;
                1200 150;
                930 280;
                620 410;
                820 425;
                640 510;
                1060 390;
                1110 390;
                1200 400
                ];%%%%%%%%%%%%%%%%%%%%

%生成people的随机速度(people数量*8)个（8个方向）
speed = rand(numel(people_position(:,1)),1) * max_velocity;
velocity_direction = rand(numel(people_position(:,1)),8);
velocity_direction = velocity_direction ./ (sum(abs(velocity_direction).^2,2).^(1/2));%每行都是单位向量
velocity = speed .* velocity_direction;%速率乘方向

[field_of_louvre,gate_index_matrix] = generate_fitness_matrix(people_position,gate_position,map_size,radius,alpha);
field_of_louvre(map_of_level'==200) = 2*max(field_of_louvre(:));
%计算卢浮宫地图的初始适应度场，不考虑人，field_of_louvre是一个fitness_matrix

%field_of_louvre = update_field(people_position, origional_field_of_louvre);
%考虑人作为障碍

for i=1:numel(gate_position(:,1))
    color_set(i,:) = rand(1,3);
end

while iterate_times <= max_iterate_times

    fitness = cal_fitness2(field_of_louvre,people_position);
    %计算目标函数（适应函数）
    
    grid_people_map = generate_grid_people_map(people_position,map_size);
    %生成网格上每格的人数

    is_finished = sum(fitness) < 5;
    
    generate_figure(people_position,field_of_louvre,gate_index_matrix,...
                gate_position,interval,map_size,color_set,people_number_matrix,...
                grid_people_map,figure_name,iterate_times,level,is_finished)

    disp('total people:')
    disp(numel(people_position(:,1)))


    %假如到达门口则结束迭代
    if is_finished == 1
        break
    end

    alt_position = generate_alt_position(people_position, field_of_louvre, map_size);
    %生成可选方向，需要考虑人口密度

    people_number_matrix = [people_number_matrix,numel(people_position(:,1))]; %#ok<AGROW>
    %把实时人数存入矩阵

    [people_position,velocity,alt_position] = update_people(gate_position,people_position,max_out_capacity,gate_scale,velocity,alt_position);
    %去掉已经出去的人

    tic
    w = 0.5 + 1/(2*(log(iterate_times)+1));
    velocity = update_velocity(fitness,people_position,alt_position,w,c1,c2,velocity,sight,max_velocity,interval);
    %更新速度，产生速率不大于最大速率的速度
    toc
    
    people_position = walk(people_position, velocity, map_size,field_of_louvre,grid_people_map);
    %行走，更新people的位置

    [field_of_louvre,gate_index_matrix] = generate_fitness_matrix(people_position,gate_position,map_size,radius,alpha);
    field_of_louvre(map_of_level'==200) = 2*max(field_of_louvre(:));
    %更新适应度场

    route_matrix = [route_matrix; people_position]; %#ok<AGROW>
    %，把更新的位置加入路线矩阵
    
    iterate_times = iterate_times + 1;
end