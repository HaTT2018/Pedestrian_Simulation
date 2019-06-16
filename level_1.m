clc
clear

map_of_level = imread('C:\Users\10169\Desktop\louvre\1_modi.jpg');%%%%%%%%%%%%%%%%%%%%
map_of_level = double(rgb2gray(map_of_level));
map_of_level(map_of_level<150) = 0;
map_of_level(map_of_level>150) = 200;

map_of_louvre = map_of_level';%����¬������ͼ

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
gate_scale = 3;%��
sight = 30;%��Ұ

%�������people
people_position = rand(100000,2);%%%%%%%%%%%%%%%%%%%%
people_position(:,1) = round(people_position(:,1)*map_size(1));
people_position(:,2) = round(people_position(:,2)*map_size(2));
people_position(people_position==0)=1;

people_position = delete_wrong_people(map_of_level',people_position,map_size);
%ɾȥ���������

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

%����people������ٶ�(people����*8)����8������
speed = rand(numel(people_position(:,1)),1) * max_velocity;
velocity_direction = rand(numel(people_position(:,1)),8);
velocity_direction = velocity_direction ./ (sum(abs(velocity_direction).^2,2).^(1/2));%ÿ�ж��ǵ�λ����
velocity = speed .* velocity_direction;%���ʳ˷���

[field_of_louvre,gate_index_matrix] = generate_fitness_matrix(people_position,gate_position,map_size,radius,alpha);
field_of_louvre(map_of_level'==200) = 2*max(field_of_louvre(:));
%����¬������ͼ�ĳ�ʼ��Ӧ�ȳ����������ˣ�field_of_louvre��һ��fitness_matrix

%field_of_louvre = update_field(people_position, origional_field_of_louvre);
%��������Ϊ�ϰ�

for i=1:numel(gate_position(:,1))
    color_set(i,:) = rand(1,3);
end

while iterate_times <= max_iterate_times

    fitness = cal_fitness2(field_of_louvre,people_position);
    %����Ŀ�꺯������Ӧ������
    
    grid_people_map = generate_grid_people_map(people_position,map_size);
    %����������ÿ�������

    is_finished = sum(fitness) < 5;
    
    generate_figure(people_position,field_of_louvre,gate_index_matrix,...
                gate_position,interval,map_size,color_set,people_number_matrix,...
                grid_people_map,figure_name,iterate_times,level,is_finished)

    disp('total people:')
    disp(numel(people_position(:,1)))


    %���絽���ſ����������
    if is_finished == 1
        break
    end

    alt_position = generate_alt_position(people_position, field_of_louvre, map_size);
    %���ɿ�ѡ������Ҫ�����˿��ܶ�

    people_number_matrix = [people_number_matrix,numel(people_position(:,1))]; %#ok<AGROW>
    %��ʵʱ�����������

    [people_position,velocity,alt_position] = update_people(gate_position,people_position,max_out_capacity,gate_scale,velocity,alt_position);
    %ȥ���Ѿ���ȥ����

    tic
    w = 0.5 + 1/(2*(log(iterate_times)+1));
    velocity = update_velocity(fitness,people_position,alt_position,w,c1,c2,velocity,sight,max_velocity,interval);
    %�����ٶȣ��������ʲ�����������ʵ��ٶ�
    toc
    
    people_position = walk(people_position, velocity, map_size,field_of_louvre,grid_people_map);
    %���ߣ�����people��λ��

    [field_of_louvre,gate_index_matrix] = generate_fitness_matrix(people_position,gate_position,map_size,radius,alpha);
    field_of_louvre(map_of_level'==200) = 2*max(field_of_louvre(:));
    %������Ӧ�ȳ�

    route_matrix = [route_matrix; people_position]; %#ok<AGROW>
    %���Ѹ��µ�λ�ü���·�߾���
    
    iterate_times = iterate_times + 1;
end