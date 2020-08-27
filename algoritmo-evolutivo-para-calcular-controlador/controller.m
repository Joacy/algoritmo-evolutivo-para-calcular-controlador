classdef controller
    % Classe para o controlador
    properties
        num
        den
        mp
        ts
        fitness
        transfer_function
    end
    methods
        function obj = controller(num, den)
            obj.num = num;
            obj.den = den;
            obj.transfer_function = tf(num, den);
        end
    end
end