/*
 * Enums in Prolog
 * Prolog uses atoms and facts to represent enumerated values
 */

% ============================================================
% BASIC ENUM (Atoms as enum values)
% ============================================================

% Color enum values
color(red).
color(green).
color(blue).

demonstrate_basic_enum :-
    writeln('=== Basic Enum (Atoms) ==='),
    
    % Check if value is valid
    Color = red,
    (color(Color) -> 
        format('~w is a valid color~n', [Color])
    ;
        format('~w is NOT a valid color~n', [Color])
    ),
    
    % Enumerate all colors
    writeln('All colors:'),
    forall(color(C), format('  ~w~n', [C])).

% ============================================================
% HTTP STATUS CODES (Facts with values)
% ============================================================

http_status(ok, 200).
http_status(created, 201).
http_status(bad_request, 400).
http_status(unauthorized, 401).
http_status(not_found, 404).
http_status(server_error, 500).

http_status_message(ok, '200 OK').
http_status_message(created, '201 Created').
http_status_message(bad_request, '400 Bad Request').
http_status_message(unauthorized, '401 Unauthorized').
http_status_message(not_found, '404 Not Found').
http_status_message(server_error, '500 Internal Server Error').

demonstrate_http_status :-
    writeln(''),
    writeln('=== HTTP Status Codes ==='),
    
    Status = not_found,
    http_status(Status, Code),
    http_status_message(Status, Message),
    format('Status: ~w (~w)~n', [Message, Code]),
    
    Status2 = ok,
    http_status(Status2, Code2),
    http_status_message(Status2, Message2),
    format('Status: ~w (~w)~n', [Message2, Code2]).

% ============================================================
% DAYS OF WEEK
% ============================================================

day_of_week(monday, 0).
day_of_week(tuesday, 1).
day_of_week(wednesday, 2).
day_of_week(thursday, 3).
day_of_week(friday, 4).
day_of_week(saturday, 5).
day_of_week(sunday, 6).

is_weekday(Day) :-
    day_of_week(Day, Num),
    Num >= 0,
    Num =< 4.

is_weekend(Day) :-
    \+ is_weekday(Day).

demonstrate_days_of_week :-
    writeln(''),
    writeln('=== Days of Week ==='),
    
    Today = wednesday,
    day_of_week(Today, DayNum),
    format('Today: ~w (ordinal: ~w)~n', [Today, DayNum]),
    
    (is_weekday(Today) ->
        writeln('It\'s a weekday')
    ;
        writeln('It\'s a weekend')
    ),
    
    writeln(''),
    writeln('All days:'),
    forall(day_of_week(Day, _), format('  ~w~n', [Day])).

% ============================================================
% PRIORITY LEVELS
% ============================================================

priority(low, 1).
priority(medium, 5).
priority(high, 10).
priority(critical, 100).

priority_higher_than(P1, P2) :-
    priority(P1, V1),
    priority(P2, V2),
    V1 > V2.

demonstrate_priority :-
    writeln(''),
    writeln('=== Priority Levels ==='),
    
    forall(priority(Name, Value),
           format('~w priority: ~w~n', [Name, Value])),
    
    writeln(''),
    (priority_higher_than(high, medium) ->
        writeln('HIGH priority is greater than MEDIUM')
    ;
        writeln('HIGH priority is NOT greater than MEDIUM')
    ).

% ============================================================
% TRAFFIC LIGHT STATE MACHINE
% ============================================================

traffic_light(red).
traffic_light(yellow).
traffic_light(green).

light_action(red, 'Stop').
light_action(yellow, 'Caution').
light_action(green, 'Go').

next_light(red, green).
next_light(yellow, red).
next_light(green, yellow).

demonstrate_state_machine :-
    writeln(''),
    writeln('=== Traffic Light State Machine ==='),
    
    Light = red,
    light_action(Light, Action),
    format('Light: ~w - ~w~n', [Light, Action]),
    
    next_light(Light, NextLight1),
    light_action(NextLight1, Action1),
    format('Light: ~w - ~w~n', [NextLight1, Action1]),
    
    next_light(NextLight1, NextLight2),
    light_action(NextLight2, Action2),
    format('Light: ~w - ~w~n', [NextLight2, Action2]),
    
    next_light(NextLight2, NextLight3),
    light_action(NextLight3, Action3),
    format('Light: ~w - ~w~n', [NextLight3, Action3]).

% ============================================================
% LOG LEVELS
% ============================================================

log_level(debug, 0).
log_level(info, 1).
log_level(warning, 2).
log_level(error, 3).
log_level(fatal, 4).

should_log(MessageLevel, ConfigLevel) :-
    log_level(MessageLevel, MsgValue),
    log_level(ConfigLevel, CfgValue),
    MsgValue >= CfgValue.

demonstrate_log_levels :-
    writeln(''),
    writeln('=== Log Levels ==='),
    
    writeln('All log levels:'),
    forall(log_level(Level, Value),
           format('  ~w: ~w~n', [Level, Value])),
    
    writeln(''),
    writeln('Filtering (config level: warning):'),
    ConfigLevel = warning,
    (should_log(debug, ConfigLevel) ->
        writeln('  DEBUG: will log')
    ;
        writeln('  DEBUG: will NOT log')
    ),
    (should_log(error, ConfigLevel) ->
        writeln('  ERROR: will log')
    ;
        writeln('  ERROR: will NOT log')
    ).

% ============================================================
% ENUM VALIDATION
% ============================================================

valid_color(Color) :- color(Color).

demonstrate_validation :-
    writeln(''),
    writeln('=== Enum Validation ==='),
    
    TestColor1 = red,
    (valid_color(TestColor1) ->
        format('~w is a valid color~n', [TestColor1])
    ;
        format('~w is NOT a valid color~n', [TestColor1])
    ),
    
    TestColor2 = purple,
    (valid_color(TestColor2) ->
        format('~w is a valid color~n', [TestColor2])
    ;
        format('~w is NOT a valid color~n', [TestColor2])
    ).

% ============================================================
% PATTERN MATCHING WITH ENUMS
% ============================================================

process_status(ok) :- writeln('Success!').
process_status(not_found) :- writeln('Resource not found').
process_status(server_error) :- writeln('Server error occurred').
process_status(_) :- writeln('Unknown status').

demonstrate_pattern_matching :-
    writeln(''),
    writeln('=== Pattern Matching ==='),
    
    Status1 = ok,
    write('Processing status: '), write(Status1), write(' -> '),
    process_status(Status1),
    
    Status2 = not_found,
    write('Processing status: '), write(Status2), write(' -> '),
    process_status(Status2).

% ============================================================
% MAIN - DEMONSTRATION
% ============================================================

main :-
    writeln('=== Enums in Prolog ==='),
    writeln(''),
    demonstrate_basic_enum,
    demonstrate_http_status,
    demonstrate_days_of_week,
    demonstrate_priority,
    demonstrate_state_machine,
    demonstrate_log_levels,
    demonstrate_validation,
    demonstrate_pattern_matching,
    writeln(''),
    writeln('💡 Prolog Enum Features:'),
    writeln('   ✓ Atoms represent enum values'),
    writeln('   ✓ Facts associate values with atoms'),
    writeln('   ✓ Pattern matching for enum handling'),
    writeln('   ✓ Validation through queries'),
    writeln('   ✗ No compile-time type checking'),
    writeln(''),
    writeln('✓ Program completed successfully').

% Run main when loaded
:- initialization(main, main).
