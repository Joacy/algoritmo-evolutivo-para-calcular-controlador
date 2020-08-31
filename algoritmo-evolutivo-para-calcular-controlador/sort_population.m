function [ ordered_array ] = sort_population( array )
    for k = 1:(length(array) - 1)
        min = k;
        for l = (k+1):length(array)
            if get(array(l), 'fitness') > get(array(min), 'fitness')
                min = l;
            end
            if k ~= min
                aux = array(k);
                array(k) = array(min);
                array(min) = aux;
            end
        end
    end
    ordered_array = array;
end

