% Define os requisitos de controle
mp = 10;
ts = 3;
sc = 30;

% Define o sistema a ser controlado
Ms = 2.45;
Mus = 1;
Ks = 900;
Kus = 1250;
Bs = 7.5;
Bus = 5;
ZsFc = tf([(Mus) (Bs) (Kus)],[(Ms*Mus) (Ms*Bus + Bs*Mus + Ms*Bs) (Ms*Kus + Bs*Bus + Ks*Ms + Ks*Mus) (Ks*Bus + Bs*Kus) (Ks*Kus)]);
ZsZr = tf([(Bs*Bus) (Ks*Bus + Bs*Kus) (Ks*Kus)],[(Ms*Mus) (Ms*Bus + Bs*Mus + Ms*Bs) (Ms*Kus + Bs*Bus + Ks*Ms + Ks*Mus) (Ks*Bus + Bs*Kus) (Ks*Kus)]);

% Gera população inicial
initial = generate_initial_population();

% Avalia cada indivíduo
t = 0:0.001:10;
% zr = 0.01*square(2*pi*0.3*t);
zr = ones(size(t));

for i = 1:100
    %Equação de malha Fechada
    Ts = ZsZr*feedback(1,(ZsFc*get(initial(i), 'transfer_function')));
    
    %Sinal de Controle do Sistema
    Sc = (get(initial(i), 'transfer_function')*ZsZr)/(1 + get(initial(i), 'transfer_function')*ZsFc);
    
    y = lsim(Ts, zr, t);
    u = lsim(Sc, zr, t);
    
    infoY = stepinfo(y, t);
    infoU = stepinfo(u, t);
    
    set(initial(i), 'mp', infoY.Overshoot, 'ts', infoY.SettlingTime, 'control_signal', infoU.Peak);
end

for j = 1:100
    if isnan(get(initial(j), 'mp')) || isnan(get(initial(j), 'ts')) || isnan(get(initial(j), 'control_signal'))
        set(initial(j), 'fitness', 0);
    end
    if get(initial(j), 'mp') <= mp
        if get(initial(j), 'ts') <= ts
            if get(initial(j), 'control_signal') <= sc
                set(initial(j), 'fitness', 1000);
            else
                set(initial(j), 'fitness', 0);
            end
        else
            if get(initial(j), 'control_signal') <= sc
                set(initial(j), 'fitness', 70);
            else
                set(initial(j), 'fitness', 0);
            end
        end
    else
        if get(initial(j), 'ts') <= ts
            if get(initial(j), 'control_signal') <= sc
                set(initial(j), 'fitness', 70);
            else
                set(initial(j), 'fitness', 0);
            end
        else
            if get(initial(j), 'control_signal') <= sc
                set(initial(j), 'fitness', 35);
            else
                set(initial(j), 'fitness', 0);
            end
        end
    end
end

ordered_array = sort_population(initial);

% Até que as condições sejam satisfeitas
% % Seleciona pais
% % Recombina pares de pais
% % Muta os descendentes resultantes
% % Avalia novas candidatas
% % Seleciona indivíduos para a nova geração