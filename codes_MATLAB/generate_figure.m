function generate_figure(people_position,field_of_map,gate_index_matrix,...
                    gate_position,interval,map_size,color_set,...
                    people_number_matrix,grid_people_map,figure_name,iterated_times,level,is_finished)
    
    folders = {'C:\Users\10169\Desktop\b2\',...
               'C:\Users\10169\Desktop\b1\',...
               'C:\Users\10169\Desktop\0\',...
               'C:\Users\10169\Desktop\1\',...
               'C:\Users\10169\Desktop\2\'};
    level = level+3;
    
    px = people_position(:,1);
    py = people_position(:,2);
    
    %第一张散点图
    figure(1)
    image(field_of_map')
    
    hold on
    contour(field_of_map',10)
    colorbar
    hold on
    plot(gate_position(:,1),gate_position(:,2),'k.','markersize',15)
    people2which_gate = gate_index_matrix(sub2ind(map_size,px,py));
    for i=1:numel(gate_position(:,1))
        plot(px(people2which_gate==i), py(people2which_gate==i),'.','markersize',5,'color',color_set(i,:))
    end
    title('Population distribution');
    suptitle(figure_name)
    set(gcf,'unit','centimeters','position',[3 0 35 30]);    
    
    
    
    if is_finished ==0
        if iterated_times == 2
            saveas(gcf,[char(folders(level)),num2str(iterated_times),'_Population distribution','.jpg']);

        elseif iterated_times == 100
            saveas(gcf,[char(folders(level)),num2str(iterated_times),'_Population distribution','.jpg']);

        elseif iterated_times == 200
            saveas(gcf,[char(folders(level)),num2str(iterated_times),'_Population distribution','.jpg']);

        elseif iterated_times == 300
            saveas(gcf,[char(folders(level)),num2str(iterated_times),'_Population distribution','.jpg']);

            %第二张折线图，人数与时间的关系
            figure(2)
            plot([1:numel(people_number_matrix(:))]*interval,people_number_matrix) %#ok<NBRAK>
            title('The number of people with respect to time');
            xlabel('Time / s');
            ylabel('The number of people');
            suptitle(figure_name)
            set(gcf,'unit','centimeters','position',[3 0 35 30]);
            axis([ -inf inf 0 10000]);
            save([char(folders(level)),num2str(4),'_The number of people','.txt'],'people_number_matrix','-ascii');
            saveas(gcf,[char(folders(level)),num2str(iterated_times),'_The number of people','.jpg']);
        end  
        
    elseif is_finished == 1
            saveas(gcf,[char(folders(level)),num2str(iterated_times),'_Population distribution','.jpg']);

            %第二张折线图，人数与时间的关系
            figure(2)
            plot([1:numel(people_number_matrix(:))]*interval,people_number_matrix) %#ok<NBRAK>
            title('The number of people with respect to time');
            xlabel('Time / s');
            ylabel('The number of people');
            suptitle(figure_name)
            set(gcf,'unit','centimeters','position',[3 0 35 30]);
            axis([ -inf inf 0 10000]);
            save([char(folders(level)),num2str(4),'_The number of people','.txt'],'people_number_matrix','-ascii');
            saveas(gcf,[char(folders(level)),num2str(iterated_times),'_The number of people','.jpg']);
    end
    
    %pause(interval)
    hold off
end