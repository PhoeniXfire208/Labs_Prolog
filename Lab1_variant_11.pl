/*
Есть факты об отцах некотоpых людей и о бpатьях некотоpых людей. Опpеделить отношение ДЯДЯ.
Запросы:
• Опpеделить бpатьев конкpетного человека.
• Кто является отцом конкретного лица?
• Связаны ли два человека отношением ОТЕЦ?
• Опpеделить, является ли один человек дядей другого.
*/

% Факты об отцах
father(john, mike).
father(john, lisa).
father(peter, tom).
father(peter, ann).
father(robert, john).  % добавляем отца для Джона, чтобы были дяди
father(robert, david). % добавляем дядю (брата Джона)

% Факты о братьях (должны быть собраны вместе)
brother(mike, tom).
brother(tom, mike).
brother(john, david).
brother(david, john).

% Упрощенное правило для определения братьев (без сестер)
siblings(X, Y) :- brother(X, Y).

% Правило для определения дяди (только по отцовской линии)
uncle(Uncle, Person) :-
    father(Father, Person),
    siblings(Uncle, Father).

% 1. Определить братьев конкретного человека
brothers_of(Person, Brother) :-
    brother(Person, Brother).

% 2. Кто является отцом конкретного лица?
who_is_father(Person, Father) :-
    father(Father, Person).

% 3. Связаны ли два человека отношением ОТЕЦ?
is_father(Father, Child) :-
    father(Father, Child).

% 4. Определить, является ли один человек дядей другого
is_uncle(Uncle, Nephew) :-
    uncle(Uncle, Nephew).

%%%%%%%%%%

%Ответы будут такие:
%| ?- is_uncle(david, mike).

%true ? ;

%no
%| ?- brothers_of(mike, X).

%X = tom

%yes
%| ?- who_is_father(tom, X).

%X = peter ? ;

%(15 ms) no
%| ?- is_father(peter, ann).

%yes
%| ?- 