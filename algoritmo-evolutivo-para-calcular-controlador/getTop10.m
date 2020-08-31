function [ best_individuals ] = getTop10( array )
    best_individuals = controller.empty(10);
    for i = 1:10
        best_individuals(i) = array(i);
    end
end

