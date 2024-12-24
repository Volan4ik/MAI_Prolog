% Длина списка
my_length([], 0).
my_length([_|Tail], Length) :-
    my_length(Tail, N),
    Length is N + 1.

% Проверка на вхождение
my_member(Element, [Element|_]).
my_member(Element, [_|Tail]) :-
    my_member(Element, Tail).

% Конкатенация списков
my_append([], List, List).
my_append([Head|Tail], List, [Head|Result]) :-
    my_append(Tail, List, Result).

% Удаление трех первых элементов
remove_first_three([_, _, _ | Tail], Tail).
remove_first_three(List, List) :-
    my_length(List, Len),
    Len < 3.

% Сумма элементов списка
sum_list([], 0).
sum_list([Head|Tail], Sum) :-
    sum_list(Tail, TailSum),
    Sum is Head + TailSum.

% Вычисление среднего значения списка
average(List, Avg) :-
    sum_list(List, Sum),
    my_length(List, Length),
    Length > 0,
    Avg is Sum / Length.

% Обработка списка: удаление трех первых элементов и вычисление среднего
process_list(List, Result) :-
    remove_first_three(List, Trimmed),
    average(Trimmed, Result).
