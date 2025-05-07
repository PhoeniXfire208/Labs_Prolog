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
father(robert, john).  % отец Джона и Дэвида
father(robert, david).

% Факты о братьях (взаимные)
brother(mike, tom).
brother(tom, mike).
brother(john, david).
brother(david, john).

% 1. Определить братьев конкретного человека
brothers_of(Person, Brother) :-
    brother(Person, Brother).

% 2. Кто является отцом конкретного лица?
who_is_father(Person, Father) :-
    father(Father, Person).

% 3. Связаны ли два человека отношением ОТЕЦ?
is_father(Father, Child) :-
    father(Father, Child).

% 4. Определить, является ли один человек дядей другого (исправлено)
is_uncle(Uncle, Nephew) :-
    uncle(Uncle, Nephew).

% Правило для дяди (исправлено)
uncle(Uncle, Person) :-
    father(Father, Person),
    brother(Uncle, Father).

%%%%%%%%%%

%Ответы будут такие:

%| ?- is_uncle(david, mike).

%true ? 

%yes
%| ?- brothers_of(mike, X).

%X = tom

%yes
%| ?- who_is_father(tom, X).

%X = peter ? 

%yes
%| ?- is_father(peter, ann).

%yes
