/* 
  18. Удалить два последних элемента списка
  Содержит два метода: рекурсивный и через append.
*/

% Рекурсивная реализация
remove_last_two_recursive([_, _], []).  % Базовый случай: список из двух элементов
remove_last_two_recursive([H | T], [H | R]) :- 
    remove_last_two_recursive(T, R).     % Рекурсивный случай: сохраняем голову

% Реализация через append
remove_last_two_append(List, Result) :- 
    append(Result, [_, _], List).        % Разделяем список на префикс и два последних элемента

/* 
  Примеры запросов:			И ответы:
  ?- remove_last_two_recursive([1,2,3,4], R).  	% R = [1,2]
  ?- remove_last_two_append([a,b,c,d,e], R).  	% R = [a,b,c]
  ?- remove_last_two_recursive([x,y], R).      	% R = []
  ?- remove_last_two_append([z], R).           	% false
  ?- remove_last_two_recursive([], R).         	% false
*/