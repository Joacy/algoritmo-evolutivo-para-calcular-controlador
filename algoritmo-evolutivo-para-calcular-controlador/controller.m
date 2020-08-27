classdef controller
    % Classe para o controlador
    properties
        num
        den
        mp
        ts
        fitness
    end
    methods
        function obj = controller(num, den)
            obj.num = num;
            obj.den = den;
        end
    end
end