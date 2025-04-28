%20. Расставить максимальное число белых ладей, чтобы они не били друг друга.
% max_rooks_clp_gprolog.pl
% Поиск максимума ладей на доске 8×8 с помощью встроенного FD-решателя

% Обходим K от 8 до 1:
max_rooks_clp(K, Config) :-
    between(1, 8, Rev),             % Rev = 1..8
    K is 9 - Rev,                   % K = 8..1 :contentReference[oaicite:3]{index=3}
    length(Config, K),              % Config — список длины K
    fd_domain(Config, 1, 8),        % все C ∈ 1..8 :contentReference[oaicite:4]{index=4}
    fd_all_different(Config),       % все C попарно различны :contentReference[oaicite:5]{index=5}
    fd_labeling(Config),             % перебор значений :contentReference[oaicite:6]{index=6}
    !.                               % первый найденный (макс. K)