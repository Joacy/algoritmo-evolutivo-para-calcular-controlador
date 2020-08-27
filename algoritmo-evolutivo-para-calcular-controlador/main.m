% Define o sistema a ser controlado
Ms = 2.45;
Mus = 1;
Ks = 900;
Kus = 1250;
Bs = 7.5;
Bus = 5;
ZsFc = tf([(Mus) (Bs) (Kus)],[(Ms*Mus) (Ms*Bus + Bs*Mus + Ms*Bs) (Ms*Kus + Bs*Bus + Ks*Ms + Ks*Mus) (Ks*Bus + Bs*Kus) (Ks*Kus)]);
ZsZr = tf([(Bs*Bus) (Ks*Bus + Bs*Kus) (Ks*Kus)],[(Ms*Mus) (Ms*Bus + Bs*Mus + Ms*Bs) (Ms*Kus + Bs*Bus + Ks*Ms + Ks*Mus) (Ks*Bus + Bs*Kus) (Ks*Kus)]);

% Gera popula��o inicial
initial = generate_initial_population();

% Avalia cada indiv�duo
t = 0:0.001:10;
for i = 1:100
    %Equa��o de malha Fechada
    Ts = ZsZr*feedback(1,(ZsFc*initial(i).transfer_function));
    
    %Sinal de Controle do Sistema
    Sc = (initial(i).transfer_function*ZsZr)/(1 + initial(i).transfer_function*ZsFc);
    
    y = step(Ts, t);
    u = step(Sc, t);
end

% At� que as condi��es sejam satisfeitas
% % Seleciona pais
% % Recombina pares de pais
% % Muta os descendentes resultantes
% % Avalia novas candidatas
% % Seleciona indiv�duos para a nova gera��o