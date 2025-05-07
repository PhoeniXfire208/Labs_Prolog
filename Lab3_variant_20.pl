%20. Расставить максимальное число белых ФЕРЗЕЙ, чтобы они не били друг друга.
% max_queens_clp_gprolog.pl
% Поиск максимума ферзей на доске 8×8 с использованием FD-решателя

max_queens_clp(K, Config) :-
    between(1, 8, Rev),          % Перебор K от 8 до 1
    K is 9 - Rev,
    length(Config, K),           % Создание списка Config длины K
    fd_domain(Config, 1, 8),     % Ограничение: каждая позиция в 1..8
    fd_all_different(Config),    % Все позиции в разных столбцах
    add_diagonal_constraints(Config), % Проверка диагоналей
    fd_labeling(Config),         % Поиск решения
    !.                           % Отсечение после первого решения

% Добавление ограничений на диагонали
add_diagonal_constraints(Config) :-
    add_diagonal_constraints(Config, 1).

add_diagonal_constraints([], _).
add_diagonal_constraints([C|Rest], I) :-
    check_against_rest(Rest, C, I, I+1),
    I1 is I + 1,
    add_diagonal_constraints(Rest, I1).

check_against_rest([], _, _, _).
check_against_rest([Cj|Rest], Ci, I, J) :-
    Ci + I #\= Cj + J,          % Проверка восходящей диагонали
    Ci - I #\= Cj - J,          % Проверка нисходящей диагонали
    J1 is J + 1,
    check_against_rest(Rest, Ci, I, J1).

/*
Вывод:
| ?- max_queens_clp(K, Config).

Config = [1,5,8,6,3,7,2,4]
K = 8

yes
| ?- 
*/