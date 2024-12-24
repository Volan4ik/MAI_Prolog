% Проверка на уникальность элементов в списке
is_unique([]).
is_unique([Head|Tail]) :-
    \+ member(Head, Tail),
    is_unique(Tail).

% Задаем список учителей
teacher_list([morozov, vasilyev, tokarev]).

% Задаем список предметов
subject_list([history, french, biology, english, maths, geography]).

% Определяем возможные комбинации учителей и их предметов
assign_teachers(Assignments) :-
    Assignments = [teacher(T1, S1a, S1b), teacher(T2, S2a, S2b), teacher(T3, S3a, S3b)],
    teacher_list(Teachers),
    permutation(Teachers, [T1, T2, T3]),
    subject_list(Subjects),
    select(S1a, Subjects, R1),
    select(S1b, R1, R2),
    select(S2a, R2, R3),
    select(S2b, R3, R4),
    select(S3a, R4, R5),
    select(S3b, R5, _),
    is_unique([S1a, S1b, S2a, S2b, S3a, S3b]),
    % Условия исключения
    \+ (T1 == tokarev, (S1a == biology; S1b == biology; S1a == french; S1b == french)),
    \+ (T2 == tokarev, (S2a == biology; S2b == biology; S2a == french; S2b == french)),
    \+ (T3 == tokarev, (S3a == biology; S3b == biology; S3a == french; S3b == french)),
    \+ (S1a == biology, S1b == maths),
    \+ (S2a == biology, S2b == maths),
    \+ (S3a == biology, S3b == maths),
    \+ (S1a == english, S1b == maths),
    \+ (S2a == english, S2b == maths),
    \+ (S3a == english, S3b == maths),
    \+ (T1 == morozov, (S1a == english; S1b == english; S1a == maths; S1b == maths)).

% Решение задачи
solve(Solution) :-
    assign_teachers(Solution),
    \+ member(teacher(_, geography, french), Solution),
    \+ member(teacher(_, french, geography), Solution).
