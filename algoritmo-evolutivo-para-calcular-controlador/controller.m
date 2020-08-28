classdef controller < matlab.mixin.SetGet
    % Classe para o controlador
    properties
        num
        den
        transfer_function
        mp
        ts
        control_signal
        fitness
    end
    methods
        function obj = controller(num, den)
            obj.num = num;
            obj.den = den;
            obj.transfer_function = tf(num, den);
        end
    end
end