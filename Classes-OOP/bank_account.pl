/*
 * Bank Account System in Prolog
 * Demonstrates fact-based representation (logic programming paradigm)
 * Uses dynamic predicates to simulate mutable state
 */

:- dynamic account/4.           % account(AccountNumber, Owner, Balance, Type)
:- dynamic savings_account/2.   % savings_account(AccountNumber, InterestRate)
:- dynamic checking_account/2.  % checking_account(AccountNumber, OverdraftLimit)

% ============================================================
% ACCOUNT "CLASS" - Fact-based representation
% ============================================================

% Create a new account
create_account(AccountNumber, OwnerName, InitialBalance) :-
    \+ account(AccountNumber, _, _, _),  % Check account doesn't exist
    assertz(account(AccountNumber, OwnerName, InitialBalance, generic)),
    format('✓ Account created: ~w for ~w~n', [AccountNumber, OwnerName]).

% Deposit money
deposit(AccountNumber, Amount) :-
    Amount > 0,
    retract(account(AccountNumber, Owner, Balance, Type)),
    NewBalance is Balance + Amount,
    assertz(account(AccountNumber, Owner, NewBalance, Type)),
    format('✓ Deposited $~2f. New balance: $~2f~n', [Amount, NewBalance]).

deposit(_, Amount) :-
    Amount =< 0,
    write('❌ Invalid deposit amount'), nl.

% Withdraw money (basic)
withdraw(AccountNumber, Amount) :-
    Amount > 0,
    account(AccountNumber, Owner, Balance, Type),
    Amount =< Balance,
    retract(account(AccountNumber, Owner, Balance, Type)),
    NewBalance is Balance - Amount,
    assertz(account(AccountNumber, Owner, NewBalance, Type)),
    format('✓ Withdrew $~2f. New balance: $~2f~n', [Amount, NewBalance]).

withdraw(_, Amount) :-
    (Amount =< 0 ; \+ account(_, _, Balance, _) ; Amount > Balance),
    write('❌ Insufficient funds or invalid amount'), nl.

% Display account information
display_account(AccountNumber) :-
    account(AccountNumber, Owner, Balance, Type),
    nl,
    write('=== Account Details ==='), nl,
    format('Account Number: ~w~n', [AccountNumber]),
    format('Owner: ~w~n', [Owner]),
    format('Balance: $~2f~n', [Balance]),
    format('Type: ~w~n', [Type]).

% Get account balance
get_balance(AccountNumber, Balance) :-
    account(AccountNumber, _, Balance, _).

% ============================================================
% SAVINGS ACCOUNT "CLASS" - Extended functionality
% ============================================================

% Create savings account
create_savings_account(AccountNumber, OwnerName, InitialBalance, InterestRate) :-
    \+ account(AccountNumber, _, _, _),
    assertz(account(AccountNumber, OwnerName, InitialBalance, savings)),
    assertz(savings_account(AccountNumber, InterestRate)),
    InterestPercent is InterestRate * 100,
    format('✓ Savings Account created with ~2f% interest~n', [InterestPercent]).

% Withdraw from savings (with message)
savings_withdraw(AccountNumber, Amount) :-
    account(AccountNumber, _, _, savings),
    write('🏦 [Savings Account] Processing withdrawal...'), nl,
    withdraw(AccountNumber, Amount).

% Apply interest to savings account
apply_interest(AccountNumber) :-
    account(AccountNumber, Owner, Balance, savings),
    savings_account(AccountNumber, InterestRate),
    Interest is Balance * InterestRate,
    retract(account(AccountNumber, Owner, Balance, savings)),
    NewBalance is Balance + Interest,
    assertz(account(AccountNumber, Owner, NewBalance, savings)),
    InterestPercent is InterestRate * 100,
    format('✓ Interest applied: $~2f (rate: ~2f%)~n', [Interest, InterestPercent]).

% Display savings account
display_savings(AccountNumber) :-
    account(AccountNumber, Owner, Balance, savings),
    savings_account(AccountNumber, InterestRate),
    nl,
    write('=== Savings Account Details ==='), nl,
    format('Account Number: ~w~n', [AccountNumber]),
    format('Owner: ~w~n', [Owner]),
    format('Balance: $~2f~n', [Balance]),
    InterestPercent is InterestRate * 100,
    format('Interest Rate: ~2f%~n', [InterestPercent]).

% ============================================================
% CHECKING ACCOUNT "CLASS" - Extended functionality
% ============================================================

% Create checking account
create_checking_account(AccountNumber, OwnerName, InitialBalance, OverdraftLimit) :-
    \+ account(AccountNumber, _, _, _),
    assertz(account(AccountNumber, OwnerName, InitialBalance, checking)),
    assertz(checking_account(AccountNumber, OverdraftLimit)),
    format('✓ Checking Account created with $~2f overdraft~n', [OverdraftLimit]).

% Withdraw from checking (with overdraft support)
checking_withdraw(AccountNumber, Amount) :-
    account(AccountNumber, Owner, Balance, checking),
    checking_account(AccountNumber, OverdraftLimit),
    AvailableBalance is Balance + OverdraftLimit,
    Amount > 0,
    Amount =< AvailableBalance,
    write('🏦 [Checking Account] Processing withdrawal...'), nl,
    retract(account(AccountNumber, Owner, Balance, checking)),
    NewBalance is Balance - Amount,
    assertz(account(AccountNumber, Owner, NewBalance, checking)),
    format('✓ Withdrew $~2f. New balance: $~2f~n', [Amount, NewBalance]),
    (NewBalance < 0 ->
        OverdraftUsed is -NewBalance,
        format('⚠️  Overdraft used: $~2f~n', [OverdraftUsed])
    ;
        true
    ).

checking_withdraw(_, _) :-
    write('❌ Exceeds overdraft limit'), nl.

% Display checking account
display_checking(AccountNumber) :-
    account(AccountNumber, Owner, Balance, checking),
    checking_account(AccountNumber, OverdraftLimit),
    nl,
    write('=== Checking Account Details ==='), nl,
    format('Account Number: ~w~n', [AccountNumber]),
    format('Owner: ~w~n', [Owner]),
    format('Balance: $~2f~n', [Balance]),
    format('Overdraft Limit: $~2f~n', [OverdraftLimit]).

% ============================================================
% UTILITY PREDICATES
% ============================================================

% List all accounts
list_all_accounts :-
    nl,
    write('=== All Accounts ==='), nl,
    forall(
        account(AccountNumber, Owner, Balance, Type),
        format('~w: ~w ($~2f) - ~w~n', [AccountNumber, Owner, Balance, Type])
    ).

% Calculate total balance across all accounts
total_balance(Total) :-
    findall(Balance, account(_, _, Balance, _), Balances),
    sum_list(Balances, Total).

% Clear all account data (for testing)
clear_all_accounts :-
    retractall(account(_, _, _, _)),
    retractall(savings_account(_, _)),
    retractall(checking_account(_, _)),
    write('✓ All accounts cleared'), nl.

% ============================================================
% MAIN - DEMONSTRATION
% ============================================================

demo :-
    write('=== Bank Account System (Prolog Logic-based) ==='), nl, nl,
    
    % Create accounts
    create_savings_account('SAV001', 'Alice Johnson', 5000.0, 0.03),
    create_checking_account('CHK001', 'Bob Smith', 1000.0, 500.0),
    
    nl,
    write('--- Savings Account Operations ---'), nl,
    deposit('SAV001', 500.0),
    apply_interest('SAV001'),
    display_savings('SAV001'),
    
    nl,
    write('--- Checking Account Operations ---'), nl,
    checking_withdraw('CHK001', 1200.0),  % Uses overdraft
    deposit('CHK001', 300.0),
    display_checking('CHK001'),
    
    nl,
    write('--- Account Summary ---'), nl,
    list_all_accounts,
    total_balance(Total),
    nl,
    format('Total balance across all accounts: $~2f~n', [Total]),
    
    nl,
    write('✓ Program completed successfully'), nl.

% Run demo
:- initialization(demo, main).
