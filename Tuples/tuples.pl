/*
 * Tuples in Prolog
 * Demonstrates compound terms as tuples
 */

% ============================================================
% BASIC TUPLES (Anonymous Compound Terms)
% ============================================================

demonstrate_basic_tuples :-
    writeln('=== Basic Tuples ==='),
    
    % Tuple represented as compound term
    Tuple = tuple(alice, 30, true),
    Tuple = tuple(Name, Age, Active),
    format('Name: ~w, Age: ~w, Active: ~w~n', [Name, Age, Active]).

% ============================================================
% DESTRUCTURING
% ============================================================

demonstrate_destructuring :-
    writeln(''),
    writeln('=== Destructuring ==='),
    
    Person = tuple(bob, 35, false),
    Person = tuple(Name, Age, IsActive),
    format('~w is ~w years old, Active: ~w~n', [Name, Age, IsActive]),
    
    % Partial destructuring (ignore elements)
    Person = tuple(FirstName, _, _),
    format('First name only: ~w~n', [FirstName]).

% ============================================================
% RETURNING MULTIPLE VALUES
% ============================================================

get_rgb_color(tuple(255, 128, 0)).  % Orange color

divide_with_error(A, 0, tuple(false, 'Division by zero')) :- !.
divide_with_error(A, B, tuple(true, Result)) :-
    Result is A / B.

demonstrate_return_values :-
    writeln(''),
    writeln('=== Returning Multiple Values ==='),
    
    get_rgb_color(tuple(R, G, B)),
    format('RGB: (~w, ~w, ~w)~n', [R, G, B]),
    
    divide_with_error(10, 2, tuple(Success1, Result1)),
    (Success1 -> format('Division result: ~w~n', [Result1]) ; true),
    
    divide_with_error(10, 0, tuple(Success2, Error)),
    (\+ Success2 -> format('Error: ~w~n', [Error]) ; true).

% ============================================================
% PATTERN MATCHING WITH TUPLES
% ============================================================

% point(X, Y)
distance(point(X1, Y1), point(X2, Y2), Distance) :-
    DX is X2 - X1,
    DY is Y2 - Y1,
    Distance is sqrt(DX * DX + DY * DY).

demonstrate_pattern_matching :-
    writeln(''),
    writeln('=== Pattern Matching ==='),
    
    P1 = point(0, 0),
    P2 = point(3, 4),
    distance(P1, P2, Dist),
    format('Distance from ~w to ~w: ~2f~n', [P1, P2, Dist]).

% ============================================================
% LISTS OF TUPLES
% ============================================================

students([
    tuple('Alice', 95),
    tuple('Bob', 87),
    tuple('Charlie', 92)
]).

print_student(tuple(Name, Grade)) :-
    format('  ~w: ~w points~n', [Name, Grade]).

% Sort students by grade (descending)
sort_by_grade(Students, Sorted) :-
    map_list_to_pairs(second_element, Students, Pairs),
    keysort(Pairs, SortedPairs),
    pairs_values(SortedPairs, Sorted),
    reverse(Sorted, Sorted).  % Descending

second_element(tuple(_, Grade), Grade).

demonstrate_list_of_tuples :-
    writeln(''),
    writeln('=== List of Tuples ==='),
    
    students(Students),
    writeln('Students:'),
    forall(member(S, Students), print_student(S)),
    
    % Find top student
    Students = [First|_],
    First = tuple(TopName, TopGrade),
    format('~nTop student (first in list): ~w with ~w points~n', [TopName, TopGrade]).

% ============================================================
% SWAP FUNCTION
% ============================================================

swap(tuple(A, B), tuple(B, A)).

demonstrate_swap :-
    writeln(''),
    writeln('=== Swap Function ==='),
    
    Original = tuple('Alice', 30),
    swap(Original, Swapped),
    format('Original: ~w~n', [Original]),
    format('Swapped: ~w~n', [Swapped]).

% ============================================================
% TUPLE AS KEY-VALUE PAIRS
% ============================================================

% Association list (alist) of tuple(Key, Value)
ages([
    tuple('Alice', 30),
    tuple('Bob', 35),
    tuple('Charlie', 40)
]).

lookup(Key, [tuple(Key, Value)|_], Value) :- !.
lookup(Key, [_|Rest], Value) :- lookup(Key, Rest, Value).

demonstrate_key_value_pairs :-
    writeln(''),
    writeln('=== Tuple as Key-Value Pairs ==='),
    
    ages(Ages),
    lookup('Bob', Ages, Age),
    format('Bob\'s age: ~w~n', [Age]).

% ============================================================
% COMPARING TUPLES
% ============================================================

demonstrate_comparison :-
    writeln(''),
    writeln('=== Comparing Tuples ==='),
    
    T1 = tuple(10, 20),
    T2 = tuple(10, 20),
    T3 = tuple(15, 25),
    
    (T1 = T2 -> writeln('T1 equals T2: true') ; writeln('T1 equals T2: false')),
    (T1 = T3 -> writeln('T1 equals T3: true') ; writeln('T1 equals T3: false')),
    
    % Lexicographic comparison
    (T1 @< T3 -> writeln('T1 < T3 (term order): true') ; writeln('T1 < T3 (term order): false')).

% ============================================================
% NESTED TUPLES
% ============================================================

demonstrate_nested_tuples :-
    writeln(''),
    writeln('=== Nested Tuples ==='),
    
    NestedTuple = tuple('Alice', tuple(30, 'alice@example.com')),
    NestedTuple = tuple(Name, tuple(Age, Email)),
    format('Name: ~w, Age: ~w, Email: ~w~n', [Name, Age, Email]).

% ============================================================
% PRACTICAL EXAMPLE: DATABASE ROW
% ============================================================

fetch_user(42, tuple(42, 'user@example.com', 'Active', 1250.50)).

demonstrate_database_row :-
    writeln(''),
    writeln('=== Practical Example: Database Row ==='),
    
    fetch_user(42, tuple(ID, Email, Status, Balance)),
    writeln('User Record:'),
    format('  ID: ~w~n', [ID]),
    format('  Email: ~w~n', [Email]),
    format('  Status: ~w~n', [Status]),
    format('  Balance: $~2f~n', [Balance]).

% ============================================================
% TUPLE OPERATIONS
% ============================================================

% First element
first(tuple(X, _), X).
first(tuple(X, _, _), X).

% Second element
second(tuple(_, Y), Y).
second(tuple(_, Y, _), Y).

% Third element (for triples)
third(tuple(_, _, Z), Z).

demonstrate_tuple_operations :-
    writeln(''),
    writeln('=== Tuple Operations ==='),
    
    T = tuple('Alice', 30, true),
    first(T, F),
    second(T, S),
    third(T, Th),
    format('First: ~w, Second: ~w, Third: ~w~n', [F, S, Th]).

% ============================================================
% MAPPING OVER TUPLES
% ============================================================

map_tuple(Pred, tuple(A, B), tuple(A2, B2)) :-
    call(Pred, A, A2),
    call(Pred, B, B2).

demonstrate_map_tuple :-
    writeln(''),
    writeln('=== Mapping Over Tuples ==='),
    
    Original = tuple(5, 10),
    map_tuple(double, Original, Doubled),
    format('Original: ~w~n', [Original]),
    format('Doubled: ~w~n', [Doubled]).

double(X, Y) :- Y is X * 2.

% ============================================================
% COORDINATE SYSTEM
% ============================================================

% point(X, Y)
translate(point(X, Y), DX, DY, point(X2, Y2)) :-
    X2 is X + DX,
    Y2 is Y + DY.

demonstrate_coordinate_system :-
    writeln(''),
    writeln('=== Practical Example: Coordinate System ==='),
    
    P1 = point(10, 20),
    translate(P1, 5, -3, P2),
    format('Original point: ~w~n', [P1]),
    format('Translated by (5, -3): ~w~n', [P2]).

% ============================================================
% TUPLE WITH FUNCTION (Higher-order)
% ============================================================

operations([
    tuple('Double', double),
    tuple('Square', square),
    tuple('Add 10', add_10)
]).

square(X, Y) :- Y is X * X.
add_10(X, Y) :- Y is X + 10.

demonstrate_tuple_with_function :-
    writeln(''),
    writeln('=== Tuple with Function ==='),
    
    operations(Ops),
    Input = 5,
    format('Input: ~w~n', [Input]),
    forall(
        member(tuple(Name, Pred), Ops),
        (call(Pred, Input, Result),
         format('  ~w: ~w~n', [Name, Result]))
    ).

% ============================================================
% MAIN - DEMONSTRATION
% ============================================================

main :-
    writeln('=== Tuples in Prolog ==='),
    writeln(''),
    demonstrate_basic_tuples,
    demonstrate_destructuring,
    demonstrate_return_values,
    demonstrate_pattern_matching,
    demonstrate_list_of_tuples,
    demonstrate_swap,
    demonstrate_key_value_pairs,
    demonstrate_comparison,
    demonstrate_nested_tuples,
    demonstrate_database_row,
    demonstrate_tuple_operations,
    demonstrate_map_tuple,
    demonstrate_coordinate_system,
    demonstrate_tuple_with_function,
    writeln(''),
    writeln('💡 Prolog Tuple Features:'),
    writeln('   ✓ Compound terms serve as tuples'),
    writeln('   ✓ Pattern matching for destructuring'),
    writeln('   ✓ Unification for comparison'),
    writeln('   ✓ Can contain any terms (atoms, numbers, other tuples)'),
    writeln('   ✓ Used extensively in logic programming'),
    writeln('   ✗ No fixed convention (tuple/N or other functors)'),
    writeln(''),
    writeln('✓ Program completed successfully').

% Run main when loaded
:- initialization(main, main).
