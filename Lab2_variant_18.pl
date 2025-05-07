/* 
  18. Удалить два последних элемента списка
  Содержит два метода: рекурсивный и через append.
*/

% Рекурсивная реализация
remove_last_two([_, _], []). 
remove_last_two([H|T], [H|R]) :- 
    remove_last_two(T, R).

% Реализация через append (альтернативный метод)
remove_last_two_alt(List, Result) :- 
    append(Result, [_, _], List).

/* 
| ?- remove_last_two([1,2,3,4], R).

R = [1,2] ? 

(109 ms) yes
| ?- remove_last_two_alt([a,b,c,d,e], R).

R = [a,b,c]

yes
| ?- remove_last_two([x,y], R).

R = [] ? 

yes
| ?- remove_last_two([z], R).

no
| ?- 
*/