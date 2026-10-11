/*
 * Structures in Prolog
 * Demonstrates compound terms (functors) as structures
 */

% ============================================================
% BASIC STRUCT (Compound Terms)
% ============================================================

% Point represented as compound term
% point(X, Y)

demonstrate_basic_struct :-
    writeln('=== Basic Struct (Compound Terms) ==='),
    Point = point(10, 20),
    Point = point(X, Y),
    format('Point: (~w, ~w)~n', [X, Y]).

% ============================================================
% NESTED STRUCTS
% ============================================================

% address(Street, City, ZipCode)
% person(Name, Age, Address)

demonstrate_nested_structs :-
    writeln(''),
    writeln('=== Nested Structures ==='),
    Address = address('123 Main St', 'Springfield', '12345'),
    Person = person('Alice Johnson', 30, Address),
    
    Person = person(Name, Age, address(Street, City, Zip)),
    format('Name: ~w~n', [Name]),
    format('Age: ~w~n', [Age]),
    format('Address: ~w, ~w ~w~n', [Street, City, Zip]).

% ============================================================
% DYNAMIC DATABASE (Mutable Structs)
% ============================================================

:- dynamic account/3.

% Facts: account(ID, Name, Balance)
account(1001, 'Alice', 5000.50).
account(1002, 'Bob', 3200.75).
account(1003, 'Charlie', 7500.00).

print_account(ID, Name, Balance) :-
    format('  ID: ~w, Name: ~w, Balance: $~2f~n', [ID, Name, Balance]).

demonstrate_database_structs :-
    writeln(''),
    writeln('=== Database Structs (Facts) ==='),
    writeln('Bank Accounts:'),
    forall(account(ID, Name, Balance), print_account(ID, Name, Balance)).

% Update account balance
update_balance(ID, NewBalance) :-
    retract(account(ID, Name, _)),
    assertz(account(ID, Name, NewBalance)).

% ============================================================
% PATTERN MATCHING WITH STRUCTS
% ============================================================

% Rectangle: rect(Width, Height)
area(rect(W, H), Area) :- Area is W * H.
perimeter(rect(W, H), Perimeter) :- Perimeter is 2 * (W + H).

% Circle: circle(Radius)
area(circle(R), Area) :- Area is pi * R * R.
perimeter(circle(R), Perimeter) :- Perimeter is 2 * pi * R.

demonstrate_pattern_matching :-
    writeln(''),
    writeln('=== Pattern Matching with Structs ==='),
    
    Rectangle = rect(10, 5),
    area(Rectangle, RectArea),
    perimeter(Rectangle, RectPerimeter),
    format('Rectangle: area = ~w, perimeter = ~w~n', [RectArea, RectPerimeter]),
    
    Circle = circle(7),
    area(Circle, CircleArea),
    perimeter(Circle, CirclePerimeter),
    format('Circle: area = ~2f, circumference = ~2f~n', [CircleArea, CirclePerimeter]).

% ============================================================
% STRUCT DECOMPOSITION
% ============================================================

% Extract first name from person struct
first_name(person(Name, _, _), Name).

% Extract city from person with address
city(person(_, _, address(_, City, _)), City).

demonstrate_decomposition :-
    writeln(''),
    writeln('=== Struct Decomposition ==='),
    
    Person = person('Bob Smith', 35, address('456 Elm St', 'Portland', '97201')),
    first_name(Person, Name),
    city(Person, City),
    format('Name: ~w, City: ~w~n', [Name, City]).

% ============================================================
% LISTS OF STRUCTS
% ============================================================

% student(Name, Grade)
students([
    student('Alice', 95),
    student('Bob', 87),
    student('Charlie', 92)
]).

print_student(student(Name, Grade)) :-
    format('  ~w: ~w points~n', [Name, Grade]).

demonstrate_list_of_structs :-
    writeln(''),
    writeln('=== List of Structs ==='),
    students(Students),
    writeln('Students:'),
    forall(member(S, Students), print_student(S)).

% Find top student
top_student(Students, Top) :-
    member(Top, Students),
    Top = student(_, TopGrade),
    \+ (member(student(_, Grade), Students), Grade > TopGrade).

% ============================================================
% RECURSIVE STRUCTURES (Linked List)
% ============================================================

% node(Data, Next)
% empty represents end of list

print_list(empty) :- writeln('nil').
print_list(node(Data, Next)) :-
    format('~w -> ', [Data]),
    print_list(Next).

list_length(empty, 0).
list_length(node(_, Next), Length) :-
    list_length(Next, NextLength),
    Length is NextLength + 1.

demonstrate_recursive_struct :-
    writeln(''),
    writeln('=== Recursive Structures (Linked List) ==='),
    
    List = node(10, node(20, node(30, empty))),
    write('List: '),
    print_list(List),
    list_length(List, Length),
    format('Length: ~w~n', [Length]).

% ============================================================
% RECORD SYNTAX (SWI-Prolog extension)
% ============================================================

% :- record person(name, age, email).
% This would generate accessors like person_name/2, person_age/2, etc.
% For portability, we demonstrate manual accessors

get_name(person(Name, _, _), Name).
get_age(person(_, Age, _), Age).
set_age(person(Name, _, Email), NewAge, person(Name, NewAge, Email)).

demonstrate_accessors :-
    writeln(''),
    writeln('=== Struct Accessors ==='),
    
    Person1 = person('Diana', 28, 'diana@example.com'),
    get_name(Person1, Name),
    get_age(Person1, Age),
    format('Name: ~w, Age: ~w~n', [Name, Age]),
    
    set_age(Person1, 29, Person2),
    get_age(Person2, NewAge),
    format('Updated age: ~w~n', [NewAge]).

% ============================================================
% COMPARING STRUCTS
% ============================================================

demonstrate_comparison :-
    writeln(''),
    writeln('=== Comparing Structs ==='),
    
    P1 = point(10, 20),
    P2 = point(10, 20),
    P3 = point(15, 25),
    
    (P1 = P2 -> writeln('P1 equals P2: true') ; writeln('P1 equals P2: false')),
    (P1 = P3 -> writeln('P1 equals P3: true') ; writeln('P1 equals P3: false')),
    
    % Structural comparison
    (P1 == P2 -> writeln('P1 identical to P2: true') ; writeln('P1 identical to P2: true')),
    (P1 @< P3 -> writeln('P1 < P3 (term order): true') ; writeln('P1 < P3 (term order): false')).

% ============================================================
% PRACTICAL EXAMPLE: BINARY TREE
% ============================================================

% tree(Value, Left, Right) or empty
sum_tree(empty, 0).
sum_tree(tree(Value, Left, Right), Sum) :-
    sum_tree(Left, LeftSum),
    sum_tree(Right, RightSum),
    Sum is Value + LeftSum + RightSum.

print_tree(empty, Indent) :-
    format('~w<empty>~n', [Indent]).
print_tree(tree(Value, Left, Right), Indent) :-
    format('~w~w~n', [Indent, Value]),
    atom_concat(Indent, '  ', NewIndent),
    print_tree(Left, NewIndent),
    print_tree(Right, NewIndent).

demonstrate_tree :-
    writeln(''),
    writeln('=== Practical Example: Binary Tree ==='),
    
    Tree = tree(10,
                tree(5, tree(3, empty, empty), tree(7, empty, empty)),
                tree(15, empty, tree(20, empty, empty))),
    
    writeln('Tree structure:'),
    print_tree(Tree, ''),
    sum_tree(Tree, Sum),
    format('Sum of all nodes: ~w~n', [Sum]).

% ============================================================
% MAIN - DEMONSTRATION
% ============================================================

main :-
    writeln('=== Structures in Prolog ==='),
    writeln(''),
    demonstrate_basic_struct,
    demonstrate_nested_structs,
    demonstrate_database_structs,
    demonstrate_pattern_matching,
    demonstrate_decomposition,
    demonstrate_list_of_structs,
    demonstrate_recursive_struct,
    demonstrate_accessors,
    demonstrate_comparison,
    demonstrate_tree,
    writeln(''),
    writeln('💡 Prolog Struct (Compound Term) Features:'),
    writeln('   ✓ Functors with fixed arity (name/arity)'),
    writeln('   ✓ Pattern matching for decomposition'),
    writeln('   ✓ Unification for comparison'),
    writeln('   ✓ Dynamic predicates for mutable data'),
    writeln('   ✗ No type checking (atoms can represent anything)'),
    writeln(''),
    writeln('✓ Program completed successfully').

% Run main when loaded
:- initialization(main, main).
