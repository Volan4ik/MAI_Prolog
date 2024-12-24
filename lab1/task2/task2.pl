:- consult('data.pl').

% Задание 1: Средний балл для каждого предмета
grades_for_subject(Subject, Grades) :-
    findall(Grade, (student(_, _, List), member(grade(Subject, Grade), List)), Grades).

average_grade(Subject, Average) :-
    grades_for_subject(Subject, Grades),
    sum_list(Grades, Sum),
    length(Grades, Count),
    Count > 0,
    Average is Sum / Count.

print_average_grades :-
    subject(Code, Name),
    average_grade(Code, Avg),
    format('Средний балл по ~w (~w): ~2f~n', [Name, Code, Avg]),
    fail.
print_average_grades.

% Задание 2: Количество не сдавших студентов для каждой группы
failed(Grades) :- member(grade(_, Grade), Grades), Grade < 3.

count_failed_in_group(Group, Count) :-
    findall(1, (student(Group, _, Grades), failed(Grades)), Fails),
    length(Fails, Count).

print_failed_students_per_group :-
    findall(Group, student(Group, _, _), Groups),
    sort(Groups, UniqueGroups),
    member(Group, UniqueGroups),
    count_failed_in_group(Group, Count),
    format('Количество не сдавших студентов в группе ~w: ~w~n', [Group, Count]),
    fail.
print_failed_students_per_group.

% Задание 3: Количество не сдавших студентов для каждого предмета
count_failed_subject(Subject, Count) :-
    findall(1, (student(_, _, Grades), member(grade(Subject, Grade), Grades), Grade < 3), Fails),
    length(Fails, Count).

print_failed_students_per_subject :-
    subject(Code, Name),
    count_failed_subject(Code, Count),
    format('Количество не сдавших студентов по предмету ~w (~w): ~w~n', [Name, Code, Count]),
    fail.
print_failed_students_per_subject.

% Основная программа для вывода всех результатов
run :-
    writeln('Средний балл для каждого предмета:'),
    print_average_grades,
    writeln('\nКоличество не сдавших студентов для каждой группы:'),
    print_failed_students_per_group,
    writeln('\nКоличество не сдавших студентов для каждого предмета:'),
    print_failed_students_per_subject.
