function [ initial ] = generate_initial_population()
    % Gerando pupulação inicial
    for i = 1:100
        numberOfZeros = randi(5);
        numberOfPoles = randi(5);
        num = randperm(100, numberOfZeros);
        den = randperm(100, numberOfPoles);

        initial(i) = controller(num, den);
    end
end
